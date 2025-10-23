// HTML 模板
const HTML_TEMPLATE = `
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FxClash 配置生成器</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding: 20px; }
        .form-group { margin-bottom: 1rem; }
        pre { white-space: pre-wrap; word-wrap: break-word; }
        .base-url-group { margin-bottom: 0.5rem; }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mb-4">FxClash 配置生成器</h2>
        
        <!-- 配置粘贴区域 -->
        <div class="form-group mb-4">
            <label for="configPaste">粘贴配置 JSON</label>
            <textarea class="form-control" id="configPaste" rows="5" 
                      placeholder="在此粘贴 app_config.json 的内容..."></textarea>
            <button class="btn btn-secondary mt-2" onclick="parseConfig()">解析配置</button>
        </div>

        <form id="configForm">
            <div class="form-group">
                <label for="configUrl">配置 URL</label>
                <input type="url" class="form-control" id="configUrl" required 
                       placeholder="https://example.com/app_config.json">
            </div>
            <div class="form-group">
                <label for="appTitle">应用名称</label>
                <input type="text" class="form-control" id="appTitle" required>
            </div>
            
            <!-- 多个 baseUrl 输入框 -->
            <div class="form-group">
                <label>基础 URL (最多3个)</label>
                <div id="baseUrlContainer">
                    <div class="base-url-group">
                        <input type="url" class="form-control mb-2" name="baseUrl[]" required>
                    </div>
                </div>
                <button type="button" class="btn btn-secondary btn-sm" onclick="addBaseUrl()">添加 URL</button>
            </div>

            <div class="form-group">
                <label for="appUpdateUrl">应用更新 URL</label>
                <input type="url" class="form-control" id="appUpdateUrl" required>
            </div>
            <div class="form-group">
                <label for="appUpdateCheckUrl">更新检查 URL</label>
                <input type="url" class="form-control" id="appUpdateCheckUrl" required>
            </div>
            <button type="submit" class="btn btn-primary">生成配置</button>
        </form>
        <div class="mt-4" id="result" style="display:none;">
            <h4>加密结果：</h4>
            <div class="alert alert-success">
                <pre id="encryptedResult"></pre>
            </div>
            <button class="btn btn-secondary" onclick="copyToClipboard()">复制</button>
        </div>
    </div>
    <script>
        function addBaseUrl() {
            const container = document.getElementById('baseUrlContainer');
            const urlGroups = container.getElementsByClassName('base-url-group');
            
            if (urlGroups.length >= 3) {
                alert('最多只能添加3个基础 URL');
                return;
            }
            
            const newGroup = document.createElement('div');
            newGroup.className = 'base-url-group';
            newGroup.innerHTML = \`
                <div class="input-group mb-2">
                    <input type="url" class="form-control" name="baseUrl[]" required>
                    <button class="btn btn-outline-danger" type="button" onclick="removeBaseUrl(this)">删除</button>
                </div>
            \`;
            
            container.appendChild(newGroup);
        }

        function removeBaseUrl(button) {
            button.closest('.base-url-group').remove();
        }

        function parseConfig() {
            try {
                const jsonText = document.getElementById('configPaste').value;
                const config = JSON.parse(jsonText);
                
                // 填充表单
                document.getElementById('configUrl').value = config.configUrl || '';
                document.getElementById('appTitle').value = config.appTitle || '';
                document.getElementById('appUpdateUrl').value = config.appUpdateUrl || '';
                document.getElementById('appUpdateCheckUrl').value = config.appUpdateCheckUrl || '';
                
                // 处理 baseUrl 数组
                const baseUrls = Array.isArray(config.baseUrl) ? config.baseUrl : [config.baseUrl];
                const container = document.getElementById('baseUrlContainer');
                container.innerHTML = ''; // 清空现有的 URL 输入框
                
                baseUrls.slice(0, 3).forEach((url, index) => {
                    const group = document.createElement('div');
                    group.className = 'base-url-group';
                    group.innerHTML = \`
                        <div class="input-group mb-2">
                            <input type="url" class="form-control" name="baseUrl[]" required value="\${url}">
                            \${index > 0 ? '<button class="btn btn-outline-danger" type="button" onclick="removeBaseUrl(this)">删除</button>' : ''}
                        </div>
                    \`;
                    container.appendChild(group);
                });
                
                alert('配置解析成功！');
            } catch (error) {
                alert('配置解析失败：' + error.message);
            }
        }

        document.getElementById('configForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            
            // 收集所有 baseUrl
            const baseUrls = Array.from(document.getElementsByName('baseUrl[]'))
                .map(input => input.value)
                .filter(url => url.trim() !== '');
            
            const config = {
                configUrl: document.getElementById('configUrl').value,
                appTitle: document.getElementById('appTitle').value,
                baseUrl: baseUrls,
                appUpdateUrl: document.getElementById('appUpdateUrl').value,
                appUpdateCheckUrl: document.getElementById('appUpdateCheckUrl').value
            };
            
            try {
                const response = await fetch('/encrypt', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(config)
                });
                
                const result = await response.json();
                document.getElementById('encryptedResult').textContent = 
                    JSON.stringify(result.data, null, 2);
                document.getElementById('result').style.display = 'block';
            } catch (error) {
                alert('生成配置失败：' + error.message);
            }
        });

        function copyToClipboard() {
            const text = document.getElementById('encryptedResult').textContent;
            navigator.clipboard.writeText(text)
                .then(() => alert('已复制到剪贴板'))
                .catch(err => alert('复制失败：' + err));
        }
    </script>
</body>
</html>
`;

// XOR 加密函数
function xorEncrypt(data, key) {
    const result = new Uint8Array(data.length);
    for (let i = 0; i < data.length; i++) {
        result[i] = data[i] ^ key[i % key.length];
    }
    return result;
}

// 生成密钥
async function deriveKey(salt, key) {
    const encoder = new TextEncoder();
    const saltBytes = encoder.encode(salt);
    const keyBytes = encoder.encode(key);
    
    // 使用与 Dart 相同的 HMAC-SHA256 逻辑
    const hmacKey = await crypto.subtle.importKey(
        "raw",
        saltBytes,
        { name: "HMAC", hash: "SHA-256" },
        false,
        ["sign"]
    );
    
    const signature = await crypto.subtle.sign(
        "HMAC",
        hmacKey,
        keyBytes
    );
    
    return new Uint8Array(signature);
}

// 从字符串中随机截取指定长度的子串
function getRandomSubstring(str, length) {
    if (str.length < length) return str;
    const start = Math.floor(Math.random() * (str.length - length));
    return str.substring(start, start + length);
}

// 加密配置
async function encryptConfig(config, env) {
    const encoder = new TextEncoder();
    
    // 验证 baseUrl 数组
    if (!Array.isArray(config.baseUrl)) {
        config.baseUrl = [config.baseUrl];
    }
    // 限制最多3个 URL
    config.baseUrl = config.baseUrl.slice(0, 3);
    
    // 先加密配置 URL
    const urlContent = encoder.encode(config.configUrl);
    const urlChecksum = new Uint8Array(await crypto.subtle.digest("SHA-256", urlContent));
    const urlWithChecksum = new Uint8Array(urlChecksum.length + urlContent.length);
    urlWithChecksum.set(urlChecksum);
    urlWithChecksum.set(urlContent, urlChecksum.length);
    
    const key = await deriveKey(
        env.ENCRYPTION_SALT || 'FxClash',
        env.ENCRYPTION_KEY || 'FxClash'
    );
    const encryptedUrl = xorEncrypt(urlWithChecksum, key);
    const encryptedUrlHex = Array.from(encryptedUrl)
        .map(b => b.toString(16).padStart(2, '0'))
        .join('');
    
    // 从加密后的 URL 中随机获取安全标记
    const securityFlag = getRandomSubstring(encryptedUrlHex, 10);
    
    // 加密完整配置
    const fullConfig = {
        ...config,
        securityFlag
    };
    delete fullConfig.configUrl; // 从最终配置中移除 configUrl
    
    // 加密最终配置
    const content = encoder.encode(JSON.stringify(fullConfig));
    const checksum = new Uint8Array(await crypto.subtle.digest("SHA-256", content));
    const dataWithChecksum = new Uint8Array(checksum.length + content.length);
    dataWithChecksum.set(checksum);
    dataWithChecksum.set(content, checksum.length);
    
    const encrypted = xorEncrypt(dataWithChecksum, key);
    const encryptedHex = Array.from(encrypted)
        .map(b => b.toString(16).padStart(2, '0'))
        .join('');
    
    return {
        config: encryptedHex
    };
}

export default {
    async fetch(request, env) {
        const url = new URL(request.url);
        
        // 处理 Web 界面请求
        if (request.method === "GET" && url.pathname === "/") {
            return new Response(HTML_TEMPLATE, {
                headers: { "Content-Type": "text/html" }
            });
        }
        
        // 处理加密请求
        if (request.method === "POST" && url.pathname === "/encrypt") {
            try {
                const config = await request.json();
                const encrypted = await encryptConfig(config, env);
                return new Response(JSON.stringify({ data: encrypted }), {
                    headers: { "Content-Type": "application/json" }
                });
            } catch (error) {
                return new Response(JSON.stringify({ error: error.message }), {
                    status: 400,
                    headers: { "Content-Type": "application/json" }
                });
            }
        }
        
        // 处理 APP 请求
        if (request.headers.get('User-Agent')?.includes('FxClash')) {
            // 获取请求的文件路径
            const filePath = url.pathname.substring(1);
            // 如果路径为空，默认使用 app_config.json
            const fileName = filePath || 'app_config.json';
            
            // 获取配置文件
            const configFile = await env.MY_BUCKET.get(fileName);
            if (!configFile) {
                return new Response('Config not found', { status: 404 });
            }

            try {
                const config = JSON.parse(await configFile.text());
                return new Response(JSON.stringify({ data: config }), {
                    headers: {
                        "Content-Type": "application/json",
                        "Cache-Control": "public, max-age=3600"
                    }
                });
            } catch (error) {
                return new Response(JSON.stringify({ error: 'Invalid JSON' }), {
                    status: 500,
                    headers: { "Content-Type": "application/json" }
                });
            }
        }

        return new Response('Not Found', { status: 404 });
    }
}; 
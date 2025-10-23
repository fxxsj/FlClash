1. worker 目录结构：

```
lib/board/worker/
├── config/
│   └── app_config.json    # 应用配置文件模板
│   └── app_latest_version.json    # 应用最新版本配置文件模板
├── src/
│   └── worker.js          # Worker 源代码
│   └── wrangler.toml      # Wrangler 配置文件
└── docs/
    └── README.md          # Worker 文档
```

# FxClash Worker

这是 FxClash 的 Cloudflare Worker 配置服务。用于动态管理应用配置。

## 功能

- 提供应用配置的动态加载
- 支持 CORS 和访问控制
- 自动处理中文编码
- 防止未授权访问

## 配置说明

### app_config.json

```json
{
  "appTitle": "FxClash",
  "baseUrl": "https://your.base.url",
  "apiVersion": "/api/v1",
  "appUpdateUrl": "https://github.com/chen08209/FlClash/releases/latest",
  "appUpdateCheckUrl": "https://api.github.com/repos/chen08209/FlClash/releases/latest"
}
```

### wrangler.toml

```toml
name = "config-worker"
main = "worker.js"

[[r2_buckets]]
binding = "MY_BUCKET"
bucket_name = "my-config-bucket"
preview_bucket_name = "my-config-bucket"
```

## 部署步骤

1. 创建 R2 存储桶
   - 登录 Cloudflare Dashboard
   - 进入 R2 页面
   - 创建新的存储桶
   - 上传 `app_config.json`

2. 创建 Worker
   - 进入 Workers & Pages
   - 创建新的 Worker
   - 部署 `worker.js`
   - 绑定 R2 存储桶

3. 配置访问控制
   - Worker 通过 User-Agent 验证请求来源
   - 只允许 `FxClash/1.0` 的请求

## 安全说明

1. 访问控制
   - 使用 User-Agent 验证
   - 403 响应未授权访问

2. CORS 配置
   - 仅允许 GET 请求
   - 设置适当的缓存时间

## 开发说明

1. 本地测试
```bash
wrangler dev
```

2. 部署更新
```bash
wrangler deploy
```

3. 更新配置
   - 通过 Cloudflare Dashboard 更新 `app_config.json`
   - 或使用 Wrangler CLI:
```bash
# 进入 worker 目录
cd lib/board/worker/src
```
```bash
# 创建 bucket (如果还没有创建)
wrangler r2 bucket create fx-config
```
```bash
# 上传配置文件
wrangler r2 object put fx-config/app_config.json --file ../config/app_config.json --content-type "application/json"
```
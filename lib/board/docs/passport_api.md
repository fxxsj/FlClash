# Passport 模块 API 文档

## 基础说明
- **所有接口基于基础 URL: `/api/v1`**
- **返回格式均为 JSON**
- **认证相关接口不需要 Authorization 请求头**

## 接口详情

### 1. 获取系统配置
- **请求路径**: `GET /api/v1/guest/comm/config`
- **描述**: 获取系统基础配置信息，包含站点信息、注册配置等
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": {
    "tos_url": null,                // 服务条款URL，可能为null
    "is_email_verify": 1,           // 是否启用邮箱验证(1:启用,0:禁用)
    "is_invite_force": 0,           // 是否强制邀请注册(1:启用,0:禁用)
    "email_whitelist_suffix": [     // 邮箱白名单后缀列表，当email_whitelist_enable=1时返回数组，否则返回0
      "gmail.com",
      "qq.com",
      "163.com"
    ],
    "is_recaptcha": 0,             // 是否启用验证码(1:启用,0:禁用)
    "recaptcha_site_key": null,     // reCAPTCHA站点密钥，可能为null
    "app_description": "string",    // APP描述，可能为null
    "app_url": "string",           // 网站地址，可能为null
    "logo": null                   // 站点LOGO，可能为null
  }
}
```
- **注意事项**:
  1. `email_whitelist_suffix` 字段在 `email_whitelist_enable=0` 时返回数值0
  2. 所有字符串类型的字段都可能返回null
  3. 布尔值统一使用1和0表示

---

### 2. 登录接口
- **请求路径**: `POST /api/v1/passport/auth/login`
- **描述**: 用户登录获取访问令牌
- **请求参数**:
```json
{
  "email": "",           // 邮箱地址(必填)
  "password": "",        // 密码(必填)
  "recaptcha_data": ""   // reCAPTCHA验证数据(当系统开启 is_recaptcha 时必填)
}
```
- **返回示例**:
  - 成功响应:
```json
{
  "data": {
    "token": "",         // 访问令牌
    "is_admin": 0,       // 是否管理员(0:否, 1:是)
    "auth_data": ""      // JWT Token
  }
}
```
  - 失败响应:
```json
{
  "message": "邮箱或密码错误"  // 错误信息
}
```
- **注意事项**:
  1. 返回的 auth_data 为 JWT 格式的令牌
  2. 登录失败时会返回具体的错误信息
  3. reCAPTCHA验证数据仅在系统开启验证码时需要提供

---

### 3. 注册接口
- **请求路径**: `POST /api/v1/passport/auth/register`
- **描述**: 用户注册
- **请求参数**:
```json
{
  "email": "",           // 邮箱地址(必填)
  "password": "",        // 注册密码(必填)
  "invite_code": "",     // 邀请码(可选，当开启邀请注册时必填)
  "email_code": "",      // 邮件验证码(可选，当开启邮件验证时必填)
  "recaptcha_data": ""   // reCAPTCHA验证数据(可选，当开启reCAPTCHA验证时必填)
}
```
- **返回示例**:
  - 成功响应:
```json
{
  "data": {
    "token": "string",      // 访问令牌
    "auth_data": "string"   // JWT Token
  }
}
```
  - 失败响应:
```json
{
  "message": "注册失败的具体原因"  // 错误信息
}
```
- **注意事项**:
  1. 返回的 auth_data 为 JWT 格式的令牌
  2. 注册失败时会返回具体的错误信息
  3. 邀请码、邮件验证码和reCAPTCHA验证数据根据系统配置决定是否必填

---

### 4. 重置密码接口
- **请求路径**: `POST /api/v1/passport/auth/forget`
- **描述**: 忘记密码时重置密码
- **请求参数**:
```json
{
  "email": "",        // 电子邮件地址(必填)
  "email_code": "",   // 电子邮件验证码(必填)
  "password": ""      // 新密码(必填)
}
```
- **返回示例**:
  - 成功响应:
```json
{
  "data": true       // 重置成功
}
```
  - 失败响应:
```json
{
  "message": "重置失败的具体原因"  // 错误信息
}
```
- **注意事项**:
  1. 同一邮箱重置密码失败次数限制为3次，超过后需要等待5分钟
  2. 邮箱验证码必须正确且在有效期内
  3. 邮箱必须已在系统中注册
  4. 重置密码会清除该用户所有的登录会话
  5. 重置成功后会清除验证码缓存

---

### 5. 发送邮箱验证码
- **请求路径**: `POST /api/v1/passport/comm/sendEmailVerify`
- **描述**: 发送邮箱验证码，用于注册或重置密码
- **请求参数**:
```json
{
  "email": ""  // 邮箱地址(必填)
}
```
- **返回示例**:
  - 成功响应:
```json
{
  "data": true   // 发送成功
}
```
  - 失败响应:
```json
{
  "message": "发送失败的具体原因"  // 错误信息
}
```
- **注意事项**:
  1. 同一邮箱的发送间隔限制为60秒
  2. 验证码有效期为5分钟
  3. 邮箱必须符合系统配置的白名单要求（如果启用）
  4. 发送失败会返回具体的错误原因

---

### 6. 检查登录状态
- **请求路径**: `GET /api/v1/passport/auth/check`
- **描述**: 检查当前登录状态是否有效
- **请求头**: 需要包含 `Authorization: Bearer {token}`
- **请求参数**: 无
- **返回示例**:
```json
{
  "code": 0,
  "message": "",
  "data": {
    "is_login": false,
    "auth_data": {
      "id": 0,
      "email": "",
      "nickname": ""
    }
  }
}
```

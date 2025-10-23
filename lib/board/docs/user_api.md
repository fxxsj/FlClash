# User 模块 API 文档

## 基础说明
- **所有接口基于基础 URL: `/api/v1`**
- **返回格式均为 JSON**
- **所有接口都需要 Authorization 请求头**
- **请求头格式**: `Authorization: Bearer {token}`

## 接口详情

### 1. 获取用户信息
- **请求路径**: `GET /api/v1/user/info`
- **描述**: 获取当前登录用户的详细信息
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": {
    "email": "string",              // 用户邮箱
    "transfer_enable": 0,           // 总流量(字节)
    "device_limit": null,           // 设备限制数量
    "last_login_at": 0,            // 最后登录时间(时间戳)
    "created_at": 0,               // 创建时间(时间戳)
    "banned": 0,                   // 是否被封禁(0:否, 1:是)
    "auto_renewal": 0,             // 是否自动续费(0:否, 1:是)
    "remind_expire": 0,            // 到期提醒(0:关闭, 1:开启)
    "remind_traffic": 0,           // 流量提醒(0:关闭, 1:开启)
    "expired_at": 0,               // 账户过期时间(时间戳)
    "balance": 0,                  // 账户余额
    "commission_balance": 0,       // 佣金余额
    "plan_id": 0,                  // 当前订阅计划ID
    "discount": 0,                 // 用户折扣率
    "commission_rate": 0,          // 推广佣金比例
    "telegram_id": "string",       // Telegram ID
    "uuid": "string",              // 用户UUID
    "avatar_url": "string"         // 头像URL(基于邮箱的Gravatar头像)
  }
}
```
- **注意事项**:
  1. 头像URL使用Gravatar服务，基于用户邮箱的MD5生成
  2. 所有时间戳均为UNIX时间戳
  3. 设备限制可能为null，表示无限制
  4. 余额和佣金余额的单位由系统配置决定

### 2. 获取订阅信息
- **请求路径**: `GET /api/v1/user/getSubscribe`
- **描述**: 获取用户的订阅配置信息
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": {
    "plan_id": 0,                   // 订阅计划ID
    "token": "",                    // 订阅token
    "expired_at": 0,                // 过期时间戳
    "u": 0,                         // 上传流量(字节)
    "d": 0,                         // 下载流量(字节)
    "transfer_enable": 0,           // 总流量限制(字节)
    "device_limit": null,           // 设备数量限制
    "email": "",                    // 用户邮箱
    "uuid": "",                     // 用户UUID
    "plan": {                       // 订阅计划详情(仅当plan_id存在时返回)
      "id": 0,                      // 计划ID
      "group_id": 0,                // 分组ID
      "transfer_enable": 0,         // 流量大小(GB)
      "name": "",                   // 计划名称
      "device_limit": null,         // 设备限制
      "speed_limit": null,          // 速度限制
      "show": 0,                    // 是否显示(0:否, 1:是)
      "sort": null,                 // 排序值
      "renew": 0,                   // 是否可续费(0:否, 1:是)
      "content": "",                // 计划描述
      "month_price": 0,             // 月付价格(分)
      "quarter_price": 0,           // 季付价格(分)
      "half_year_price": 0,         // 半年付价格(分)
      "year_price": 0,              // 年付价格(分)
      "two_year_price": null,       // 两年付价格(分)
      "three_year_price": null,     // 三年付价格(分)
      "onetime_price": null,        // 一次性价格(分)
      "reset_price": 0,             // 重置流量价格(分)
      "reset_traffic_method": null, // 重置流量方式
      "capacity_limit": null,       // 容量限制
      "created_at": 0,              // 创建时间戳
      "updated_at": 0               // 更新时间戳
    },
    "alive_ip": 0,                  // 当前在线IP数
    "subscribe_url": "",            // 订阅地址
    "reset_day": 0                  // 流量重置日
  }
}
```
- **错误响应**:
  - 500: 用户不存在
  - 500: 订阅计划不存在
- **注意事项**:
  1. 所有流量相关数值均以字节(byte)为单位
  2. `plan` 字段仅在用户有订阅计划时返回
  3. `alive_ip` 从缓存中获取，表示当前在线设备数
  4. `reset_day` 表示每月的流量重置日期

### 3. 重置订阅链接
- **请求路径**: `POST /api/v1/user/resetSecurity`
- **描述**: 重置用户的订阅链接
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": null
}
```

### 4. 修改密码
- **请求路径**: `POST /api/v1/user/changePassword`
- **描述**: 修改用户密码
- **请求参数**:
```json
{
  "old_password": "",    // 原密码(必填)
  "new_password": ""     // 新密码(必填)
}
```
- **返回示例**:
```json
{
  "data": null
}
```

### 5. 更新用户信息
- **请求路径**: `POST /api/v1/user/update`
- **描述**: 更新用户基本信息
- **请求参数**:
```json
{
  "remind_expire": 0,   // 到期提醒(可选, 0:关闭, 1:开启)
  "remind_traffic": 0   // 流量提醒(可选, 0:关闭, 1:开启)
}
```
- **返回示例**:
```json
{
  "data": null
}
```

### 6. 佣金划转
- **请求路径**: `POST /api/v1/user/transfer`
- **描述**: 将佣金余额划转到账户余额
- **请求参数**:
```json
{
  "transfer_amount": 200    // 划转金额(必填，单位：分，如 200 表示 2.00 元)
}
```
- **返回示例**:
```json
{
  "data": true
}
```
- **错误响应**:
  - 500: 划转金额不能为空
  - 500: 划转金额不能小于等于0
  - 500: 佣金余额不足
- **注意事项**:
  1. 划转金额单位为分，200分表示2.00元
  2. 划转后的余额仅可在应用内消费使用
  3. 划转金额不能超过当前佣金余额
  4. 客户端应将用户输入的元金额乘以100转换为分后发送
  5. 成功时返回 `{data: true}`，失败时返回错误信息

### 7. 申请提现
- **请求路径**: `POST /api/v1/user/ticket/withdraw`
- **描述**: 申请佣金提现，创建提现工单
- **请求参数**:
```json
{
  "withdraw_method": "",    // 提现方式(必填，如: 支付宝、USDT、Paypal)
  "withdraw_account": ""    // 提现账号(必填，对应提现方式的账号信息)
}
```
- **返回示例**:
```json
{
  "data": null
}
```
- **错误响应**:
  - 500: 提现功能已关闭
  - 500: 佣金余额不足
  - 500: 提现方式不支持
- **注意事项**:
  1. 提现申请将创建工单，需要人工审核
  2. 提现方式需要在系统支持的方式列表中
  3. 提现账号格式需要符合对应支付方式的要求
  4. 提现金额为当前全部佣金余额

### 8. 获取公告列表
- **请求路径**: `GET /api/v1/user/notice/fetch`
- **描述**: 获取系统公告列表
- **请求参数**: 
```json
{
  "current": 1     // 当前页码(可选，默认1)
}
```
- **返回示例**:
```json
{
  "data": [
    {
      "id": 0,                // 公告ID
      "title": "",           // 公告标题
      "content": "",         // 公告内容
      "show": 1,             // 是否显示(0:否, 1:是)
      "img_url": "",         // 公告图片URL
      "tags": [],            // 公告标签(可能为null)
      "created_at": 0,       // 创建时间戳
      "updated_at": 0        // 更新时间戳
    }
  ],
  "total": 0                // 公告总数
}
```
- **注意事项**:
  1. 每页固定返回5条记录
  2. 公告按创建时间倒序排列
  3. 只返回显示状态(show=1)的公告

### 9. 获取公告详情
- **请求路径**: `GET /api/v1/user/notice/detail/{id}`
- **描述**: 获取指定ID的公告详情
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": {
    "id": 0,                // 公告ID
    "title": "",           // 公告标题
    "content": "",         // 公告内容
    "show": 1,             // 是否显示(0:否, 1:是)
    "img_url": "",         // 公告图片URL
    "tags": [],            // 公告标签(可能为null)
    "created_at": 0,       // 创建时间戳
    "updated_at": 0        // 更新时间戳
  }
}
```

### 10. 获取用户配置
- **请求路径**: `GET /api/v1/user/comm/config`
- **描述**: 获取用户相关的系统配置信息
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": {
    "is_telegram": 1,                         // 是否启用Telegram(1:启用, 0:禁用)
    "telegram_discuss_link": "string",        // Telegram讨论组链接
    "stripe_pk": null,                       // Stripe公钥
    "withdraw_methods": [                    // 提现支持的方式
      "支付宝",
      "USDT",
      "Paypal"
    ],
    "withdraw_close": 0,                     // 是否关闭提现(1:关闭, 0:开启)
    "currency": "CNY",                       // 货币类型
    "currency_symbol": "¥",                  // 货币符号
    "commission_distribution_enable": 0,      // 是否启用佣金分销(1:启用, 0:禁用)
    "commission_distribution_l1": null,       // 一级分销比例
    "commission_distribution_l2": null,       // 二级分销比例
    "commission_distribution_l3": null        // 三级分销比例
  }
}
```

### 11. 获取 Telegram 机器人信息
- **请求路径**: `GET /api/v1/user/telegram/getBotInfo`
- **描述**: 获取系统 Telegram 机器人的信息
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": {
    "username": ""       // Telegram 机器人用户名
  }
}
```

### 12. 获取统计信息
- **请求路径**: `GET /api/v1/user/getStat`
- **描述**: 获取用户相关的统计数据
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": [
    0,  // 未支付订单数量
    0,  // 未处理工单数量
    0   // 邀请用户数量
  ]
}
```
- **注意事项**:
  1. 返回数组固定包含3个数字
  2. 数组索引0: 表示未支付订单数量
  3. 数组索引1: 表示未处理工单数量
  4. 数组索引2: 表示邀请用户数量

## 错误码说明

- 1000: 参数错误
- 1001: 原密码错误
- 1002: 新密码不合要求
- 1003: 用户已被封禁
- 1004: 账户已过期
- 1005: 流量已用尽
- 1006: 操作频繁,请稍后再试
- 1007: 提现功能已关闭

## 注意事项

1. 所有流量相关数值均以字节(byte)为单位
2. 修改密码时，新密码长度要求 8-20 位
3. 昵称长度限制为 2-20 个字符
4. 头像URL需要是有效的图片地址
5. 重置订阅链接后，原订阅地址将立即失效
6. 提现方式由系统配置决定，请以实际返回为准
7. 货币单位和符号由系统配置决定，请以实际返回为准
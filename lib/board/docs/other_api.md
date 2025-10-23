# 其他模块 API 文档

## 基础说明
- **所有接口基于基础 URL: `/api/v1`**
- **返回格式均为 JSON**
- **所有接口都需要 Authorization 请求头**
- **请求头格式**: `Authorization: Bearer {token}`

## Plan 模块

### 1. 获取订阅计划列表
- **请求路径**: `GET /api/v1/user/plan/fetch`
- **描述**: 获取可用的订阅计划列表
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": [
    {
      "id": 0,                      // 计划ID
      "group_id": 0,                // 分组ID
      "transfer_enable": 0,         // 流量大小(GB)
      "name": "",                   // 计划名称
      "device_limit": null,         // 设备限制(null表示不限制)
      "speed_limit": null,          // 速度限制(null表示不限制)
      "show": 1,                    // 是否显示(0:否, 1:是)
      "sort": null,                 // 排序值
      "renew": 1,                   // 是否可续费(0:否, 1:是)
      "content": "",                // 计划描述(支持HTML)
      "month_price": 0,             // 月付价格(分)
      "quarter_price": 0,           // 季付价格(分)
      "half_year_price": 0,         // 半年付价格(分)
      "year_price": 0,              // 年付价格(分)
      "two_year_price": null,       // 两年付价格(分，null表示不支持)
      "three_year_price": null,     // 三年付价格(分，null表示不支持)
      "onetime_price": null,        // 一次性价格(分，null表示不支持)
      "reset_price": 0,             // 重置流量价格(分)
      "reset_traffic_method": null, // 重置流量方式
      "capacity_limit": null,       // 容量限制(null表示不限制)
      "created_at": 0,              // 创建时间戳
      "updated_at": 0               // 更新时间戳
    }
  ]
}
```

### 2. 获取计划详情
- **请求路径**: `GET /api/v1/user/plan/detail/{id}`
- **描述**: 获取指定计划的详细信息
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": {
    "id": 0,                      // 计划ID
    "group_id": 0,                // 分组ID
    "transfer_enable": 0,         // 流量大小(GB)
    "name": "",                   // 计划名称
    "device_limit": null,         // 设备限制(null表示不限制)
    "speed_limit": null,          // 速度限制(null表示不限制)
    "show": 1,                    // 是否显示(0:否, 1:是)
    "sort": null,                 // 排序值
    "renew": 1,                   // 是否可续费(0:否, 1:是)
    "content": "",                // 计划描述(支持HTML)
    "month_price": 0,             // 月付价格(分)
    "quarter_price": 0,           // 季付价格(分)
    "half_year_price": 0,         // 半年付价格(分)
    "year_price": 0,              // 年付价格(分)
    "two_year_price": null,       // 两年付价格(分，null表示不支持)
    "three_year_price": null,     // 三年付价格(分，null表示不支持)
    "onetime_price": null,        // 一次性价格(分，null表示不支持)
    "reset_price": 0,             // 重置流量价格(分)
    "reset_traffic_method": null, // 重置流量方式
    "capacity_limit": null,       // 容量限制(null表示不限制)
    "created_at": 0,              // 创建时间戳
    "updated_at": 0               // 更新时间戳
  }
}
```

### 3. 验证优惠码
- **请求路径**: `POST /api/v1/user/coupon/check`
- **描述**: 验证优惠码是否可用于指定套餐
- **请求参数**:
```json
{
  "plan_id": 1,    // 套餐ID
  "code": "welcome" // 优惠码
}
```
- **返回示例**:
```json
{
  "data": {
    "id": 1,                    // 优惠码ID
    "code": "welcome",          // 优惠码
    "name": "欢迎！",           // 优惠码名称
    "type": 2,                  // 优惠类型(1:固定金额, 2:百分比折扣)
    "value": 5,                 // 优惠值(固定金额时为金额(分), 百分比时为折扣率)
    "show": 1,                  // 是否显示(0:否, 1:是)
    "limit_use": 8237,          // 使用次数限制
    "limit_use_with_user": null,// 每用户使用次数限制(null表示不限)
    "limit_plan_ids": null,     // 可用套餐ID列表(null表示不限)
    "limit_period": null,       // 可用周期限制(null表示不限)
    "started_at": 1672502400,   // 生效时间
    "ended_at": 1767110400,     // 过期时间
    "created_at": 1612878918,   // 创建时间
    "updated_at": 1733628207    // 更新时间
  }
}
```
- **错误返回**:
```json
{
  "message": "优惠券无效"  // 错误信息
}
```

## Order 模块

### 1. 获取订单列表
- **请求路径**: `GET /api/v1/user/order/fetch`
- **描述**: 获取用户订单列表
- **请求参数**: 
```json
{
  "status": null     // 订单状态(可选，null表示获取全部)
}
```
- **返回示例**:
```json
{
  "data": [
    {
      "invite_user_id": null,         // 邀请人ID
      "plan_id": 0,                   // 订阅计划ID
      "coupon_id": null,              // 优惠券ID
      "payment_id": null,             // 支付方式ID
      "type": 0,                      // 订单类型
      "period": "",                   // 订阅周期(month_price/quarter_price/half_year_price/year_price/two_year_price/three_year_price/reset_price)
      "trade_no": "",                 // 订单号
      "callback_no": null,            // 支付回调单号
      "total_amount": 0,              // 订单总金额(分)
      "handling_amount": null,        // 手续费金额(分)
      "discount_amount": null,        // 优惠金额(分)
      "surplus_amount": null,         // 剩余金额(分)
      "refund_amount": null,          // 退款金额(分)
      "balance_amount": null,         // 余额支付金额(分)
      "surplus_order_ids": null,      // 剩余订单ID
      "status": 0,                    // 订单状态(0:未支付,1:已支付,2:已取消)
      "commission_status": 0,         // 佣金状态
      "commission_balance": 0,        // 佣金金额
      "actual_commission_balance": null, // 实际佣金金额
      "paid_at": null,                // 支付时间
      "created_at": 0,                // 创建时间
      "updated_at": 0,                // 更新时间
      "plan": {                       // 订阅计划详情
        "id": 0,                      // 计划ID
        "name": "",                   // 计划名称
        "transfer_enable": 0,         // 流量大小(GB)
        "show": 1,                    // 是否显示
        "renew": 1                    // 是否可续费
      }
    }
  ]
}
```

### 2. 创建订单
- **请求路径**: `POST /api/v1/user/order/save`
- **描述**: 创建新订单
- **请求参数**:
```json
{
  "plan_id": 0,           // 计划ID(必填)
  "period": "",          // 购买周期(必填)
  "coupon_code": "",     // 优惠码(可选)
  "deposit_amount": 0    // 充值金额(仅当plan_id为0时需要)
}
```
- **成功返回示例**:
```json
{
  "data": "202401010000001"  // 订单号
}
```
- **错误返回示例**:
```json
{
  "message": "您有未付款或开通中的订单，请稍后再试或将其取消"
}
```

### 3. 获取订单详情
- **请求路径**: `GET /api/v1/user/order/detail`
- **描述**: 获取指定订单的详细信息
- **请求参数**: 
```json
{
  "trade_no": ""    // 订单号(必填)
}
```
- **返回示例**:
```json
{
  "data": {
    "trade_no": "",                 // 订单号
    "total_amount": 0,              // 订单总金额(分)
    "plan_id": 0,                   // 订阅计划ID
    "status": 0,                    // 订单状态
    "plan": {                       // 订阅计划详情
      "id": 0,                      // 计划ID
      "name": "",                   // 计划名称
      "transfer_enable": 0          // 流量大小(GB)
    },
    "try_out_plan_id": 0,          // 试用计划ID
    "bounus": 0,                    // 充值赠送金额(仅充值订单)
    "get_amount": 0                 // 实际到账金额(仅充值订单)
  }
}
```

### 4. 获取支付方式
- **请求路径**: `GET /api/v1/user/order/getPaymentMethod`
- **描述**: 获取可用的支付方式列表
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": [
    {
      "id": 0,                      // 支付方式ID
      "name": "",                   // 支付方式名称
      "payment": "",                // 支付类型
      "icon": "",                   // 支付方式图标
      "handling_fee_fixed": 0,      // 固定手续费(分)
      "handling_fee_percent": 0     // 百分比手续费
    }
  ]
}
```

### 5. 订单结算
- **请求路径**: `POST /api/v1/user/order/checkout`
- **描述**: 订单支付结算
- **请求参数**:
```json
{
  "trade_no": "",        // 订单号(必填)
  "method": 0,          // 支付方式ID(必填)
  "token": ""           // Stripe支付Token(可选)
}
```
- **返回示例**:
```json
{
  "type": 1,                // 支付类型
  "data": "支付链接或数据"    // 支付所需数据
}
```

### 6. 检查订单状态
- **请求路径**: `GET /api/v1/user/order/check`
- **描述**: 检查订单支付状态
- **请求参数**:
```json
{
  "trade_no": ""         // 订单号(必填)
}
```
- **返回示例**:
```json
{
  "data": 0              // 订单状态(0:未支付,1:已支付,2:已取消)
}
```

### 7. 取消订单
- **请求路径**: `POST /api/v1/user/order/cancel`
- **描述**: 取消未支付的订单
- **请求参数**:
```json
{
  "trade_no": ""         // 订单号(必填)
}
```
- **返回示例**:
```json
{
  "data": true           // 取消成功
}
```

## Ticket 模块

### 1. 获取工单列表/详情
- **请求路径**: `GET /api/v1/user/ticket/fetch`
- **描述**: 获取工单列表或指定工单的详情
- **请求参数**:
  - `id` (可选): 工单ID，如果提供则返回该工单的详情
- **返回示例**:
  ```json
  {
    "data": [
      {
        "id": 1,
        "user_id": 123,
        "subject": "工单主题",
        "level": 1,
        "status": 0,
        "created_at": 1609459200,
        "updated_at": 1609459200,
        "message": [  // 仅在请求单个工单时返回
          {
            "id": 1,
            "ticket_id": 1,
            "user_id": 123,
            "message": "工单内容",
            "created_at": 1609459200,
            "is_me": false
          }
        ]
      }
    ]
  }
  ```
- **注意事项**:
  1. `status`: 0-未关闭，1-已关闭
  2. `level`: 工单等级
  3. `is_me`: 消息是否来自管理员

### 2. 创建工单
- **请求路径**: `POST /api/v1/user/ticket/save`
- **描述**: 创建新工单
- **请求参数**:
  - `subject`: 工单主题
  - `level`: 工单等级
  - `message`: 工单内容
- **返回示例**:
  ```json
  {
    "data": true
  }
  ```
- **注意事项**:
  1. 同一时间只能有一个未解决的工单
  2. 创建工单后会通过 Telegram 通知管理员

### 3. 回复工单
- **请求路径**: `POST /api/v1/user/ticket/reply`
- **描述**: 回复工单
- **请求参数**:
  - `id`: 工单ID
  - `message`: 回复内容
- **返回示例**:
  ```json
  {
    "data": true
  }
  ```
- **注意事项**:
  1. 已关闭的工单无法回复
  2. 必须等待技术人员回复后才能再次回复
  3. 回复后会通过 Telegram 通知管理员

### 4. 关闭工单
- **请求路径**: `POST /api/v1/user/ticket/close`
- **描述**: 关闭工单
- **请求参数**:
  - `id`: 工单ID
- **返回示例**:
  ```json
  {
    "data": true
  }
  ```

### 5. 提现工单
- **请求路径**: `POST /api/v1/user/ticket/withdraw`
- **描述**: 创建提现申请工单
- **请求参数**:
  - `withdraw_method`: 提现方式
  - `withdraw_account`: 提现账号
- **返回示例**:
  ```json
  {
    "data": true
  }
  ```
- **注意事项**:
  1. 需要检查是否开启提现功能
  2. 提现方式必须在系统支持的方式列表中
  3. 提现金额必须达到系统设置的最低提现限额
  4. 提现申请会自动创建一个工单并通知管理员

## Invite 模块

### 1. 获取邀请信息
- **请求路径**: `GET /api/v1/user/invite/fetch`
- **描述**: 获取用户的邀请码和统计信息
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": {
    "codes": [                  // 邀请码列表
      {
        "user_id": 0,          // 用户ID
        "code": "",            // 邀请码(8位随机字符)
        "status": 0            // 状态(0:未使用)
      }
    ],
    "stat": [                  // 统计数据数组
      0,                       // 已注册用户数
      0,                       // 有效的佣金
      0,                       // 确认中的佣金
      0,                       // 佣金比例
      0                        // 可用佣金
    ]
  }
}
```

### 2. 生成邀请码
- **请求路径**: `POST /api/v1/user/invite/save`
- **描述**: 生成新的邀请码
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": true            // 生成成功
}
```
- **错误返回**:
```json
{
  "message": "已达到最大创建数量"  // 当已有未使用的邀请码数量达到系统限制时(默认5个)
}
```

### 3. 获取佣金明细
- **请求路径**: `GET /api/v1/user/invite/details`
- **描述**: 获取佣金收入明细记录
- **请求参数**: 
```json
{
  "current": 1,           // 当前页码(可选，默认1)
  "page_size": 10        // 每页条数(可选，默认10，最小10)
}
```
- **返回示例**:
```json
{
  "data": [              // 佣金记录列表
    {
      "id": 0,          // 记录ID
      "trade_no": "",   // 订单号
      "order_amount": 0, // 订单金额
      "get_amount": 0,  // 获得佣金金额
      "created_at": ""  // 记录时间
    }
  ],
  "total": 0            // 总记录数
}
```

## Server 模块

### 1. 获取节点列表
- **请求路径**: `GET /api/v1/user/server/fetch`
- **描述**: 获取可用的服务器节点列表
- **请求参数**: 无
- **返回示例**:
```json
{
  "data": [
    {
      "id": 0,                      // 节点ID
      "group_id": [],               // 节点分组ID列表
      "route_id": null,             // 路由ID
      "parent_id": null,            // 父节点ID
      "tags": [],                   // 节点标签
      "name": "",                   // 节点名称
      "rate": "1",                  // 流量倍率
      "host": "",                   // 节点地址
      "port": 0,                    // 端口
      "server_port": 0,             // 服务端口
      "type": "",                   // 节点类型(shadowsocks/trojan/vmess/vless)
      "cipher": "",                 // 加密方式(shadowsocks专用)
      "network": "",                // 传输协议
      "network_settings": null,     // 传输协议设置
      "tls": 0,                     // TLS配置(0:关闭,1:开启,2:XTLS)
      "tls_settings": null,         // TLS设置
      "allow_insecure": 0,          // 允许不安全连接(0:否,1:是)
      "server_name": "",            // SNI域名
      "show": 1,                    // 是否显示(0:否,1:是)
      "sort": 0,                    // 排序值
      "created_at": 0,              // 创建时间戳
      "updated_at": 0,              // 更新时间戳
      "last_check_at": null,        // 最后检查时间
      "is_online": 0,               // 是否在线(0:离线,1:在线)
      "cache_key": ""               // 缓存键
    }
  ]
}
```

### 2. 获取流量日志
- **请求路径**: `GET /api/v1/user/server/log/fetch`
- **描述**: 获取用户的流量使用日志
- **请求参数**: 
```json
{
  "current_page": 1,     // 当前页码(可选，默认1)
  "page_size": 10,      // 每页条数(可选，默认10)
  "server_id": 0,       // 节点ID(可选，不传则查询所有节点)
  "start_time": "",     // 开始时间(可选，格式：YYYY-MM-DD)
  "end_time": ""        // 结束时间(可选，格式：YYYY-MM-DD)
}
```
- **返回示例**:
```json
{
  "data": {
    "current_page": 1,
    "page_size": 10,
    "total": 0,
    "data": [
      {
        "id": 0,                // 日志ID
        "server_id": 0,         // 节点ID
        "server_name": "",      // 节点名称
        "u": 0,                 // 上传流量(字节)
        "d": 0,                 // 下载流量(字节)
        "rate": 1,              // 流量倍率
        "created_at": ""        // 记录时间
      }
    ]
  }
}
```

## Knowledge 模块

### 1. 获取使用文档列表
- **请求路径**: `GET /api/v1/user/knowledge/fetch`
- **描述**: 获取使用文档和教程列表
- **请求参数**: 
```json
{
  "language": "zh-CN"    // 语言代码(可选，默认zh-CN)
}
```
- **返回示例**:
```json
{
  "data": {
    "分类名称1": [                  // 动态分类名称
      {
        "id": 0,                    // 文档ID
        "category": "",             // 分类名称
        "title": "",                // 文档标题
        "updated_at": 0             // 更新时间戳
      }
    ],
    "分类名称2": [
      {
        "id": 0,
        "category": "",
        "title": "",
        "updated_at": 0
      }
    ]
    // ... 可能包含更多分类
  }
}
```

### 2. 获取文档详情
- **请求路径**: `GET /api/v1/user/knowledge/fetch`
- **描述**: 获取指定文档的详细内容
- **请求参数**: 
```json
{
  "id": 0,              // 文档ID(必填)
  "language": "zh-CN"   // 语言代码(可选，默认zh-CN)
}
```
- **返回示例**:
```json
{
  "data": {
    "id": 0,                // 文档ID
    "language": "zh-CN",    // 语言代码
    "category": "",         // 分类
    "title": "",           // 标题
    "body": "",            // 文档内容(支持Markdown和HTML)
    "show": 1,             // 是否显示(0:否, 1:是)
    "sort": 0,             // 排序值
    "created_at": 0,       // 创建时间戳
    "updated_at": 0        // 更新时间
  }
}
```

## Gift Card 模块

### 1. 兑换礼品卡
- **请求路径**: `POST /api/v1/user/redeemgiftcard`
- **描述**: 兑换礼品卡
- **请求参数**:
```json
{
  "giftcard": ""            // 礼品卡兑换码(必填)
}
```
- **返回示例**:
```json
{
  "data": null          // 兑换成功
}
```

## 错误码说明

- 1000: 参数错误
- 1001: 余额不足
- 1002: 订单已失效
- 1003: 支付方式不可用
- 1004: 订单状态错误
- 1005: 工单不存在
- 1006: 操作频繁,请稍后再试
- 1007: 邀请码生成失败
- 1008: 邀请码已失效
- 1009: 佣金提现失败
- 1010: 节点不可用
- 1011: 节点维护中
- 1012: 流量超限
- 1013: 文档不存在
- 1014: 不支持的语言类型
- 1015: 礼品卡不存在
- 1016: 礼品卡已被使用
- 1017: 礼品卡已过期
- 1018: 提现金额不足最低要求
- 1019: 提现方式不可用
- 1020: 提现账号格式错误
- 1021: 佣金余额不足
- 1022: 转账金额无效

## 注意事项

1. 所有金额单位均为元
2. 所有流量相关数值均以字节(byte)为单位
3. 订单支付有效期为 30 分钟
4. 工单内容长度不超过 1000 字
5. 每个用户最多同时存在 5 个未关闭的工单
6. 邀请码有效期为 30 天
7. 每个用户最多可同时拥有 3 个使用的邀请码
8. 佣金提现最低金额为 10 元
9. 节点流量统计可能有 5-10 分钟的延迟
10. 流量日志保留时间为 30 天
11. 文档内容支持 Markdown 和 HTML 混合格式
12. 文档分类可能会随系统配置变化
13. 文档内容中的 iframe 需要确保来源可信
14. 礼品卡兑换码区分大小写
15. 礼品卡一经使用不可重复兑换
16. 提现金额必须大于等于系统设置的最低提现金额
17. 提现账号格式需符合所选提现方式的要求
18. 佣金转账后将即从佣金余额扣除并加入账户余额
19. 佣金转账金额必须大于0且不超过佣金余额

## Clash 配置相关

### 获取 Clash 配置

获取用户专属的 Clash 配置文件。

**请求路径**

```
GET /client/app/getConfig
```

**请求头**

需要包含有效的 Authorization Token。

**请求参数**

无

**响应格式**

```yaml
# 返回 YAML 格式的 Clash 配置文件
Content-Type: text/yaml

# 配置文件结构
proxies:
  - name: "服务器名称"
    type: "shadowsocks/vmess/trojan"
    server: "服务器地址"
    port: 443
    # ... 其他配置项根据协议类型不同而不同

proxy-groups:
  - name: "分组名称"
    type: "select/url-test/fallback/load-balance"
    proxies:
      - "服务器名称1"
      - "服务器名称2"
    # ... 其他分组配置
```

**说明**

1. 配置文件基于 `resources/rules/app.clash.yaml` 或 `resources/rules/custom.app.clash.yaml` 模板生成
2. 支持的代理协议:
   - Shadowsocks (仅支持 aes-128-gcm, aes-192-gcm, aes-256-gcm, chacha20-ietf-poly1305 加密方式)
   - VMess
   - Trojan
3. 配置文件会自动包含用户可用的所有服务器
4. 每个服务器会根据其类型自动生成对应的代理配置
5. 所有服务器会自动添加到现有的代理分组中

**错误响应**

如果用户未登录或订阅已过期，将返回空的配置文件（不包含任何代理服务器）。

**示例响应**

```yaml
port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: 127.0.0.1:9090

proxies:
  - name: "HK-1"
    type: "shadowsocks"
    server: "hk1.example.com"
    port: 443
    cipher: "chacha20-ietf-poly1305"
    password: "password"
  - name: "JP-1"
    type: "vmess"
    server: "jp1.example.com"
    port: 443
    uuid: "uuid"
    alterId: 0
    cipher: "auto"
    tls: true
    network: ws
    ws-path: "/path"

proxy-groups:
  - name: "Auto"
    type: "url-test"
    proxies:
      - "HK-1"
      - "JP-1"
    url: "http://www.gstatic.com/generate_204"
    interval: 300
  - name: "Proxy"
    type: "select"
    proxies:
      - "Auto"
      - "HK-1"
      - "JP-1"

rules:
  - 'DOMAIN-SUFFIX,google.com,Proxy'
  - 'DOMAIN-KEYWORD,google,Proxy'
  - 'MATCH,DIRECT'
```
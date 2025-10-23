# V2Board API 接口文档

## 基础配置
- 基础URL: `/api/v1`
- 请求头需要包含 Authorization: Bearer {token}
- 所有请求返回格式为 JSON

## 接口清单

1. Passport 模块
   - GET /api/v1/guest/comm/config - 获取系统配置
     - 返回: 站点配置、注册配置等系统设置
   - POST /api/v1/passport/auth/login - 用户登录
     - 参数: email, password, recaptcha_data(当开启reCAPTCHA验证时必填)
   - POST /api/v1/passport/auth/register - 用户注册
     - 参数: email, password, invite_code(当开启邀请注册时必填), email_code(当开启邮件验证时必填), recaptcha_data(当开启reCAPTCHA验证时必填)
   - POST /api/v1/passport/auth/forget - 重置密码
     - 参数: email, email_code, password
   - POST /api/v1/passport/comm/sendEmailVerify - 发送邮箱验证码
     - 参数: email
   - GET /api/v1/passport/auth/check - 检查登录状态
     - 需要 Authorization 请求头

2. User 模块
   - GET /api/v1/user/info - 获取用户信息
   - GET /api/v1/user/getSubscribe - 获取订阅信息
   - POST /api/v1/user/resetSecurity - 重置订阅链接
   - POST /api/v1/user/changePassword - 修改密码
     - 参数: old_password, new_password
   - POST /api/v1/user/update - 更新用户信息
     - 参数: nickname, avatar, remind_expire, remind_traffic
   - GET /api/v1/user/comm/config - 获取用户配置
     - 返回: 货币配置、提现配置、分销配置等系统设置

3. Plan 模块
   - GET /api/v1/user/plan/fetch - 获取套餐列表
   - GET /api/v1/user/plan/detail/{id} - 获取计划详情
   - POST /api/v1/user/coupon/check - 验证优惠码
     - 请求参数: plan_id: int 套餐ID, code: string 优惠码

4. Order 模块
   - GET /api/v1/user/order/fetch - 获取订单列表
     - 参数: current_page, page_size
   - POST /api/v1/user/order/save - 创建订单
     - 参数: plan_id, period, coupon_code
   - GET /api/v1/user/order/detail/{trade_no} - 获取订单详情
   - GET /api/v1/user/order/getPaymentMethod - 获取支付方式
   - POST /api/v1/user/order/checkout - 订单结算
     - 参数: trade_no, method
   - POST /api/v1/user/order/cancel - 取消订单
     - 参数: trade_no

5. Invite 模块
   - GET /api/v1/user/invite/fetch - 获取邀请码列表
     - 参数: current_page, page_size
   - POST /api/v1/user/invite/save - 生成邀请码
   - GET /api/v1/user/invite/details - 获取邀请明细
     - 参数: current_page, page_size
   - GET /api/v1/user/invite/commissionLog - 获取佣金记录
     - 参数: current_page, page_size

6. Notice 模块
   - GET /api/v1/user/notice/fetch - 获取公告列表
     - 参数: current_page, page_size
   - GET /api/v1/user/notice/detail/{id} - 获取公告详情

7. Ticket 模块
   - GET /api/v1/user/ticket/fetch - 获取工单列表
     - 参数: current_page, page_size
   - POST /api/v1/user/ticket/save - 创建工单
     - 参数: subject, level, message
   - POST /api/v1/user/ticket/reply - 回复工单
     - 参数: id, message
   - POST /api/v1/user/ticket/close - 关闭工单
     - 参数: id

8. Server 模块
   - GET /api/v1/user/server/fetch - 获取节点列表
   - GET /api/v1/user/server/log/fetch - 获取流量日志
     - 参数: current_page, page_size, server_id, start_time, end_time

9. Knowledge 模块
   - GET /api/v1/user/knowledge/fetch - 获取使用文档列表
     - 参数: language(可选)
   - GET /api/v1/user/knowledge/fetch - 获取文档详情
     - 参数: id, language(可选)

10. Gift Card 模块
    - POST /api/v1/user/redeemgiftcard - 兑换礼品卡
      - 参数: giftcard

11. Commission 模块
    - POST /api/v1/user/withdraw - 申请佣金提现
      - 参数: withdraw_method, withdraw_account
    - POST /api/v1/user/transfer - 佣金转入余额
      - 参数: transfer_amount

12. Telegram 模块
    - GET /api/v1/user/telegram/getBotInfo - 获取机器人信息

## 详细文档

- [Passport 模块](passport_api.md)
- [User 模块](user_api.md)
- [其他模块](other_api.md)
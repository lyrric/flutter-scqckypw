
///四川汽车客运票务网
const String BASE_URL = 'https://www.scqckypw.com';
///验证码Url
const String CAPTCHA_URL = BASE_URL + '/rCode.jpg?d=';
///验证码是否正确接口Url
const String CAPTCHA_CHECK_URL = BASE_URL + '/rCodeCheck';
///终点车站Url
const String TARGET_CITY_URL = BASE_URL + '/get/targetCitys.html';
///登陆页面Url
const String LOGIN_PAGE_URL = BASE_URL + '/login/index.html';
///登陆接口Url
const String LOGIN_URL = BASE_URL + '/login/check.json';
///用户基本信息接口Url
const String USER_CENTER_URL = BASE_URL + '/user/get.html';
///用户基本信息修改接口Url
const String USER_UPDATE_URL = BASE_URL + '/user/update.html';
///乘车人列表接口Url
const String PASSENGER_QUERY_URL = BASE_URL + '/user/getContactPerson';
///乘车人修改接口Url
const String PASSENGER_UPDATE_URL = BASE_URL + '/user/edit';
///乘车人是否重复接口Url
const String PASSENGER_CHECK_URL = BASE_URL + '/user/isPassengerExists';
///乘车人删除接口Url
const String PASSENGER_DELETE_URL = BASE_URL + '/user/delete.html';
///乘车人添加接口Url
const String PASSENGER_ADD_URL = BASE_URL + '/user/add.html';
///创建订单页面Url
const String CREATE_ORDER_PAGE_URL = BASE_URL + '/userCommon/createTicketOrder.html';
///判断是否有未支付订单接口Url
const String HAVING_PAYING_ORDER_URL = BASE_URL + '/ticketOrder/havePayingOrder.json';
///锁定车票接口Url
const String LOCK_TICKET_URL = BASE_URL + '/ticketOrder/lockTicket.html';
///付款选择页面Url
const String CHOOSE_PAY_WAY_URL = BASE_URL + '/ticketOrder/redirectOrder.html';
///付款中间页面Url
const String PAY_MIDDLE_URL = BASE_URL + '/ticketOrder/middlePay.html';//https://www.scqckypw.com/ticketOrder/middlePay.html?payid=50319021&plateform=alipay
///我的订单Url
const String MY_ORDER_LIST_URL = BASE_URL + '/user/order/searchOrder';
///取消订单Url
const String CANCEL_ORDER_URL = BASE_URL + '/ticketOrder/cancel';
///退款订单页面Url
const String REFUND_ORDER_PAGE_URL = BASE_URL + '/cancelticket/requestRetTicket.html';
///退款订单接口Url
const String REFUND_ORDER_URL = BASE_URL + '/cancelticket/requestRetTicket.html';
///获取当前城市（主要是获取cookie用）
const String COOKIE_URL = BASE_URL+'/userCommon/getCurrentCity.json';
///获取验证码接口Url
const String CAPTCHA_CODE_URL = 'http://122.51.84.22:8099/captcha/code';

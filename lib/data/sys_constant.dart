
///四川汽车客运票务网
const String BASE_URL = 'https://www.scqckypw.com';
///验证码Url
const String CAPTURE_URL = BASE_URL + '/rCode.jpg?d=';
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

///订单
class OrderList{

  ///交易编号
  String tradeNumber;
  ///支付订单ID
  int payOrderId;
  ///发车时间
  String departureTime;
  ///总金额
  double price;
  ///订单状态
  String orderStatus;
  ///出发车站
  String fromStation;
  ///目标车站
  String targetStation;
  ///订单详情列表
  List<OrderDetail> orderDetails;
}

class OrderDetail{
  ///车票ID
  String ticketId;
  ///车票状态
  String ticketStatus;
  ///乘客姓名
  String passengerName;
  ///乘客类型
  String passengerType;
  ///乘客证件号码
  String idNumber;
  ///是否携带小孩
  String hasChild;
}
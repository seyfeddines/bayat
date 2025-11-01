class ApiConstant {
  static const String  allCategory = "/api/categories/";
  static const String  jobs = "/api/job/";
  static const String  apply = "/api/inscriptions/create/";
  static const String  orderLoeaded = "/WorkFlow/api/OrderLoaded";
  static const String sendemailCode = "/Authentication/api/Confirmations/SendConfirmCode";
  static const String  Statics = "/Statistics/api/GetGeneralStatistics";
  static const String Leatest = "/Authentication/api/Versions/GetLastDriver";
static const String  restPassword = "/Authentication/api/Confirmations/SendConfairmResetPassword";
}


class APiConstantMap{
  static const String  Place_id = "/Map/api/GetPlace";
}
class ApiConstantPending{
  static const String  ReqeustPending= "/Order/api/DriverPendingRequestsList";
  static const String  DriverORderList= "/Order/api/DriverOrdersList";
  static const String  ActiverOrderDriver= "/Order/api/GetActiveOrder";
}

class SinglRconstant{
  static const String conectionhub = "/connecthub";
}
class ApiConstantSearch{
  static const String searchvicile ="/Vehicle/api/Closest";
}
class ApiConstantAuth{
  static const String logout ="/Authentication/api/Sings/Logout";
}
class ApiConstantNotfication{
  static const String notficationenabled ="/Notification/api/ActiveMember";
  static const String notficationdisabled ="/Notification/api/UnactiveMember";
  static const String notficationChangeLanguage ="/Notification/api/ChangeLanguage";
}
class ApIWorkFlow{
  static const String orderLoeadedConfirmation = "/WorkFlow/api/OrderLoadedConfirmation";
  static const String orderRecivedConfirmation = "/WorkFlow/api/OrderReceivedConfirmation";
  static const String cansleOrder = "/WorkFlow/api/CanceleOrder";
}

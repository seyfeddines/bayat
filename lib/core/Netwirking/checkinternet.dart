import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkUtil {
  // التحقق من وجود اتصال بالإنترنت مع التحقق من نوع الاتصال
  static Future<bool> hasInternet({int timeoutMs = 5000}) async {
    // التحقق من وجود الاتصال أولاً
    bool isConnected = await InternetConnection().hasInternetAccess;
    if (!isConnected) return false;

    // التحقق من نوع الاتصال
    return await _checkConnectionType();
  }

  // التحقق من نوع الاتصال (Wi-Fi أو بيانات الجوال)
  static Future<bool> _checkConnectionType() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();

      // إذا لم يكن هناك اتصال
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return false;
      }

      // إذا كان الاتصال عبر بيانات الجوال، قد يكون أقل استقرارًا
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        // إجراء فحص إضافي للاستقرار
        return await _additionalStabilityCheck();
      }

      // إذا كان Wi-Fi، افترض أن الاتصال أكثر استقرارًا
      return connectivityResult.contains(ConnectivityResult.wifi);
    } catch (e) {
      return false;
    }
  }

  // فحص إضافي للتحقق من استقرار الاتصال
  static Future<bool> _additionalStabilityCheck() async {
    try {
      // استخدام InternetConnection مع فترة فحص صارمة
      final checker = InternetConnection.createInstance(
        checkInterval: Duration(milliseconds: 500),
      );
      return await checker.hasInternetAccess;
    } catch (e) {
      return false;
    }
  }

  // مراقبة تغييرات حالة الاتصال
  static Stream<bool> get onConnectionChange =>
      InternetConnection().onStatusChange.asyncMap((status) async {
        if (status == InternetStatus.connected) {
          // إذا كان هناك اتصال، تحقق من نوعه واستقراره
          return await _checkConnectionType();
        }
        return false;
      });
}
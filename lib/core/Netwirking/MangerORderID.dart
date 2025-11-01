import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CachOrderInfo {
  static const _storage = FlutterSecureStorage();

  // مفاتيح المعرفات
  static const String _keyCurrentOrderId = "current_order_id";
  static const String _keyRequestedOrderId = "requested_order_id";

  // ===================== Current Order ======================

  /// حفظ معرف الطلب الجاري
  static Future<void> saveCurrentOrderId(String id) async {
    await _storage.write(key: _keyCurrentOrderId, value: id);
  }

  /// جلب معرف الطلب الجاري
  static Future<String?> getCurrentOrderId() async {
    return await _storage.read(key: _keyCurrentOrderId);
  }

  /// تحديث معرف الطلب الجاري
  static Future<void> updateCurrentOrderId(String newId) async {
    await _storage.write(key: _keyCurrentOrderId, value: newId);
  }

  /// حذف معرف الطلب الجاري
  static Future<void> deleteCurrentOrderId() async {
    await _storage.delete(key: _keyCurrentOrderId);
  }

  // ===================== Requested Order ======================

  /// حفظ معرف الطلب المطلوب
  static Future<void> saveRequestedOrderId(String id) async {
    await _storage.write(key: _keyRequestedOrderId, value: id);
  }

  /// جلب معرف الطلب المطلوب
  static Future<String?> getRequestedOrderId() async {
    return await _storage.read(key: _keyRequestedOrderId);
  }

  /// تحديث معرف الطلب المطلوب
  static Future<void> updateRequestedOrderId(String newId) async {
    await _storage.write(key: _keyRequestedOrderId, value: newId);
  }

  /// حذف معرف الطلب المطلوب
  static Future<void> deleteRequestedOrderId() async {
    await _storage.delete(key: _keyRequestedOrderId);
  }

  // ===================== حذف الكل ======================

  /// حذف جميع المعرفات
  static Future<void> deleteAllOrderIds() async {
    await _storage.delete(key: _keyCurrentOrderId);
    await _storage.delete(key: _keyRequestedOrderId);
  }
}

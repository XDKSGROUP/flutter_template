import 'package:fulate/common/commons.dart';
import 'package:fulate/config/global.dart';

class BaseApi {
  String token = MyGlobal.token;
  static Future Function(String url) get = MyHttpRequest.get;
}

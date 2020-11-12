import 'package:fulate/common/commons.dart';

class EthApi {
  static gasPrice() async {
    var url = "/eth/gsaPrice";
    Map json = await MyHttpRequest.get(url);
    return json['gasPrice'].toString();
  }

  static gasLimit(from, to, value) async {
    var url = "/eth/gasLimit";
    var data = {"from": "$from", "to": "$to", "value": "$value"};
    Map json = await MyHttpRequest.post(url, data);
    return json['amountUsed'].toString();
  }

  static getNonce(from) async {
    var url = "/eth/getNonce";
    var data = {"from": "$from"};
    Map json = await MyHttpRequest.post(url, data);
    return json['transactionCount'];
  }

  static sendRawTransaction(signMessage) async {
    var url = "/eth/sendRawTransaction";
    var data = {"signMessage": "$signMessage"};
    Map json = await MyHttpRequest.post(url, data);
    return json["transactionHash"].toString();
  }
}

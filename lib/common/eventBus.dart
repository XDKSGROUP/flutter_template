import 'dart:convert';

import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class HttpErrorEvent {
  int status;
  String message;
  HttpErrorEvent(this.status, this.message);
}

class HttpInternalErrorEvent {
  int status;
  String message;
  HttpInternalErrorEvent(this.status, this.message);
  @override
  String toString() {
    return jsonEncode({"status": status, "message": message});
  }
}

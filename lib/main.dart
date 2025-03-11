import 'package:flutter/cupertino.dart';

import 'app/app.dart';
import 'app/service_locator.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  // if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
  //   await _initializeWindowManager();
  // }

  ServiceLocator.instance.init();
  runApp(const TaskManager());
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../cache/local_storage.dart';

class AppInitiliaze {
  Future<void> initBeforeAppStart() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorage.init();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}

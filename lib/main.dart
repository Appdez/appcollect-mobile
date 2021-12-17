
import '../View/Home/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Controller/BenificiaryController.dart';
import 'View/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Syncronization.boot();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Hive.box('token').get("token") != null ? Home() : LoginPage(),
  ));
}

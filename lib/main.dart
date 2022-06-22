import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub_home_health/app/ui/pages/dashboard/home.dart';
import 'package:trackhub_home_health/app/ui/pages/intro_slider.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/login.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/ui/theme/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user_id = prefs.getString('user_id');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(
      GetMaterialApp(
          title: Strings.appName,
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 0,
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 0,
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            textSelectionTheme: const TextSelectionThemeData(
              selectionHandleColor: AppColors.appPrimaryColor,
            ),
            primaryColor: Colors.green,
            appBarTheme:const AppBarTheme(
              backgroundColor: Color(0xffffffff),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: user_id == null  ? const Login() :  const Home()
        // home.dart: Login()
      )));
}
import '../../src/screens/login_screen/login_screen.dart';
import '../../src/screens/signup_screen/signup_screen.dart';
import '../../src/screens/my_profile_screen/my_profile_screen.dart';
import '../../src/screens/home_screen/home_screen.dart';
import 'package:flutter/cupertino.dart';



final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  MyProfileScreen.routeName: (context) => const MyProfileScreen(),
};

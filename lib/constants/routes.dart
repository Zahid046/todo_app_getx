//* info:: auth screens

import 'package:get/get.dart';
import 'package:todo_app_getx/screens/home/home_page.dart';

const String krLogin = '/login';
const String krResister = '/resister';
const String krForgotPass = '/forgot-pass';
const String krResetPass = '/reset-pass';
const String krOTP = '/otp';

//* info:: home screen
const String krSplashScreen = '/splash-screen';
const String krHome = '/home';
const String krNotification = '/notification';
const String krContactUs = '/contact-us';
const String krSettings = '/settings';
const String krChangePassword = '/change-password';
const String krChangeLanguage = '/change-language';
const String krUserProfile = '/user-profile';
const String krEditUserProfile = '/edit-user-profile';
const String krDeleteAccount = '/delete-account';
const String krDeleteAccountReason = '/delete-account-reason';

//* info:: more screens
const String krMore = '/more';

List<GetPage<dynamic>>? routes = [
  // GetPage(name: krSplashScreen, page: () => SplashScreen()),
  //* info:: auth screens
  // GetPage(name: krLogin, page: () => Login()),
  // GetPage(name: krResister, page: () => Resister()),
  // GetPage(name: krForgotPass, page: () => ForgotPass()),
  // GetPage(name: krOTP, page: () => OTP()),
  // GetPage(name: krResetPass, page: () => ResetPass()),

  //* info:: home screen
  GetPage(name: krHome, page: () => HomePage(), transition: Transition.noTransition),
  // GetPage(name: krNotification, page: () => NotificationPage()),

  //* info:: More pages
  // GetPage(name: krMore, page: () => More(), transition: Transition.noTransition),
  // GetPage(name: krContactUs, page: () => ContactUs()),
  // GetPage(name: krSettings, page: () => Settings()),
  // GetPage(name: krChangePassword, page: () => ChangePassword()),
  // GetPage(name: krChangeLanguage, page: () => ChangeLanguage()),
  // GetPage(name: krUserProfile, page: () => UserProfile()),
  // GetPage(name: krEditUserProfile, page: () => EditUserProfile()),
  // GetPage(name: krDeleteAccount, page: () => DeleteAccount()),
  // GetPage(name: krDeleteAccountReason, page: () => DeleteAccountReason()),

];

import 'package:flutter/material.dart';

var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text = "©Alayan Shop | Develop By LeoSoft"; //this shows in the splash screen
  static String app_name = "Alayan Shop"; //this shows in the splash screen
  static String purchase_code = "f4b3408e-cb0d-4aac-8ff4-274951b3df2b"; //enter your purchase code for the app from codecanyon
  // static String purchase_code = ""; //enter your purchase code for the app from codecanyon

  //Default language config
  static String default_language ="en";
  static String mobile_app_code ="en";
  static bool app_language_rtl =false;

  //configure this
  static const bool HTTPS = true;

  //configure this
  // static const DOMAIN_PATH = "192.168.1.112/ecommerce"; //localhost
  static const DOMAIN_PATH = "https://alayanshop.com"; //inside a folder
  //static const DOMAIN_PATH = "mydomain.com"; // directly inside the public folder

  //do not configure these below
  static const String API_ENDPATH = "api/v2";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "https://alayanshop.com/api/v2";
}

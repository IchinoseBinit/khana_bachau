import 'package:flutter/material.dart';
import '/utils/size_config.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.green,
    iconTheme: const IconThemeData(color: Colors.blue),
    backgroundColor: Color(0xffE5E5E5),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: SizeConfig.width * 4,
      ),
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        color: Colors.black,
        fontFamily: "Open Sans",
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(color: Colors.black),
      bodyText1: TextStyle(color: Colors.black, fontFamily: "Open Sans"),
      bodyText2: TextStyle(color: Colors.black),
      subtitle1: TextStyle(
        color: Colors.black,
        fontFamily: "Open Sans",
      ),
      subtitle2: TextStyle(
        color: Colors.black,
      ),
      caption: TextStyle(
        color: Colors.black,
        fontFamily: "Open Sans",
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        vertical: SizeConfig.height * 2,
        horizontal: SizeConfig.width * 2,
      ),
      hintStyle: TextStyle(
        fontSize: SizeConfig.width * 4,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
        // borderRadius: BorderRadius.all(
        //   Radius.circular(
        //     SizeConfig.height * 2,
        //   ),
        // ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade400,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade400,
        ),
      ),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black38,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        color: Colors.white,
        fontFamily: "Open Sans",
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white, fontFamily: "Open Sans"),
      bodyText2: TextStyle(color: Colors.white),
      subtitle1: TextStyle(
        color: Colors.white,
        fontFamily: "Open Sans",
      ),
      subtitle2: TextStyle(
        color: Colors.white,
      ),
      caption: TextStyle(
        color: Colors.white,
        fontFamily: "Open Sans",
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        )),
  );
}

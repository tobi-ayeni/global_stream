import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color kColorWhite = Color(0xFFFFFFFF);
const Color kPrimaryGreen = Color(0xff00B68D);
const Color kPrimaryDeepGreen = Color(0xff007E02);
const Color kPrimaryBlue = Color(0xff0FB6DA);
const Color kPrimaryLightBlue = Color(0xff2196F3);
const Color kOffWhite = Color(0xffB7CEC9);
const Color kGreenishYellow = Color(0xff9C9239);
const Color kGreenYellow = Color(0xffFCF7DA);
const Color kOrangeColor = Colors.orange;
const kOrangeDeep = Color(0xff7C0C0E);
const kDarkColor = Color(0xff1F2826);
const kRedDeep = Color(0xffDC1215);
const Color kPrimaryLight = Color(0xffE5E5E5);
const kGreyColor = Color(0xff525252);
const kGreyLightColor = Color(0xffBFBFBF);



const double kPadding = 5;
const double kSmallPadding = 10;
const double kRegularPadding = 15;
const double kMediumPadding = 20;
const double kMicroPadding = 25;
const double kMacroPadding = 30;
const double kLargePadding = 40;
const double kFullPadding = 60;

TextStyle kBodyText1Style = const TextStyle(
  fontFamily: "Roboto",
  fontWeight: FontWeight.normal,
  color: kColorWhite,
  fontSize: 18,
);

TextStyle kSubTitle1Style = const TextStyle(
  fontFamily: "Roboto",
  fontWeight: FontWeight.w500,
  color: kColorWhite,
  fontSize: 14,
);

TextStyle kBodyText2Style = const TextStyle(
  fontFamily: "Roboto",
  fontWeight: FontWeight.normal,
  color: kColorWhite,
  fontSize: 16,
);

final ThemeData kThemeData = ThemeData.light().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: kColorWhite,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  // primaryColor: kPrimaryColor,
  canvasColor: Colors.white,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    color: kColorWhite,
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodyText1: kBodyText1Style,
    bodyText2: kBodyText2Style,
    subtitle1: kSubTitle1Style
  ),
);
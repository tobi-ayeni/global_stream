import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:global_stream/blocs/onboarding/onboarding_bloc.dart';
import 'package:global_stream/ui/onboarding/homepage/error_dialog.dart';
import 'package:global_stream/ui/onboarding/homepage/homepage.dart';
import 'package:global_stream/ui/onboarding/homepage/process_dialog.dart';
import 'package:global_stream/utils/components.dart';
import 'package:global_stream/utils/constants.dart';
import 'package:global_stream/utils/strings.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late ProcessIndicator progress;
  late ProcessIndicator2 progress2;
  String? password;
  String? userId;
  OnboardingBloc _bloc = OnboardingBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    progress = ProcessIndicator(context);
    progress2 = ProcessIndicator2(context);

    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
      ),
      backgroundColor: kPrimaryGreen,
      body: BlocListener(
        bloc: _bloc,
        listener: (event, state) {
          if (state is Loading) {
            progress.show();
          }
          if (state is LogInSuccess) {
            progress.dismiss().then((value) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => HomePage(data: state.response.data!),
                  ),
                ));
          }
          if (state is StringSuccess) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response),
              ),
            );
          }
          if (state is ErrorResponseSuccess) {
            progress.dismiss().then((value) => progress2.show());
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kLargePadding, vertical: kSmallPadding),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Image.asset("${imagePath}global_logo.png"),
                      const SizedBox(
                        height: kMacroPadding,
                      ),
                      GlobalTextField(
                        textTheme: textTheme,
                        hintText: "Enter User Id",
                        text: "User Id *",
                        onSaved: (val) {
                          setState(() {
                            userId = val;
                          });
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return emptyField;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: kMicroPadding,
                      ),
                      GlobalTextField(
                        textTheme: textTheme,
                        hintText: "Enter Password",
                        text: "Password *",
                        obscure: true,
                        onSaved: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return emptyField;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: kMicroPadding,
                      ),
                      // isLoading
                      //     ? ShowLoadingDialog(
                      //         theme: textTheme,
                      //       )
                      //     : Navigator.of(context, rootNavigator: true).pop(result);
                      ButtonWidget(
                        textTheme: textTheme,
                        text: "SIGN IN",
                        onTap: () {
                          //
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _bloc.add(LogInEvent(userId!, password!));
                            // isLoading ? _showLoading(textTheme) : null;
                          }

                          // _showClear(textTheme, size);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
              width: double.infinity,
              color: kPrimaryBlue,
              child: Text(
                appVersion,
                style: textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClear(TextTheme theme, Size size) {
    if (Platform.isIOS) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: kMediumPadding),
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                        color: kColorWhite,
                        border: Border.all(color: kRedDeep, width: 1.5),
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: kMacroPadding,
                        ),
                        Text(
                          "Invalid Password",
                          style: theme.bodyText1!.copyWith(
                              color: kDarkColor,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: kMediumPadding,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 35),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border:
                                      Border.all(width: 1, color: kRedDeep)),
                              child: Text(
                                "Close",
                                style: theme.bodyText1!.copyWith(
                                  color: kRedDeep,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: kMediumPadding,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    top: 0,
                    child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset("${iconPath}error.svg")),
                  ),
                ],
              ));
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: kMediumPadding),
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                        color: kColorWhite,
                        border: Border.all(color: kRedDeep, width: 1.5),
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: kMacroPadding,
                        ),
                        Text(
                          "Invalid Password",
                          style: theme.bodyText1!.copyWith(
                              color: kDarkColor,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: kMediumPadding,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 35),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border:
                                      Border.all(width: 1, color: kRedDeep)),
                              child: Text(
                                "Close",
                                style: theme.bodyText1!.copyWith(
                                  color: kRedDeep,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: kMediumPadding,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    top: 0,
                    child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset("${iconPath}error.svg")),
                  ),
                ],
              ));
        },
      );
    }
  }
}

class ShowLoadingDialog extends StatelessWidget {
  final TextTheme theme;

  const ShowLoadingDialog({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => _showLoading(theme, context));
    return Container();
  }

  _showLoading(TextTheme theme, BuildContext context) async {
    if (Platform.isIOS) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            content: Container(
              // width: size.width,
              padding: const EdgeInsets.only(
                  top: kSmallPadding,
                  bottom: kSmallPadding,
                  left: kSmallPadding,
                  right: kSmallPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(
                        width: kMicroPadding,
                      ),
                      Text(
                        "Loading",
                        style: theme.bodyText2!.copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      var data = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (
          BuildContext context,
        ) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            content: Container(
              padding: const EdgeInsets.only(
                top: kSmallPadding,
                bottom: kSmallPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(
                        width: kMicroPadding,
                      ),
                      Text(
                        "Loading",
                        style: theme.bodyText2!.copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ).then((value) {
        print(value);
      });
    }
    await _showLoading(theme, context);
  }
}

//Stack(children: [
//   Container(
//     margin: EdgeInsets.only(top: 48),
//     height: 300,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16.0),
//     ),
//   ),
//   Align(
//       alignment: Alignment.topCenter,
//       child: SizedBox(
//         child: CircleAvatar(
//           radius: 40.0,
//           backgroundColor: Colors.white,
//           child: CircleAvatar(
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 12.0,
//                 child: Icon(
//                   Icons.camera_alt,
//                   size: 15.0,
//                   color: Color(0xFF404040),
//                 ),
//               ),
//             ),
//             radius: 38.0,
//             backgroundImage: AssetImage(
//                 'assets/images/user-image-default.png'),
//           ),
//         ),
//       )),
//]

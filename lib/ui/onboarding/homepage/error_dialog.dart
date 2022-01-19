import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:global_stream/utils/constants.dart';
import 'package:global_stream/utils/strings.dart';

bool _isShowing = false;
String _dialogMessage = "Loading...";
String _dialogBody = "Please wait...";
late BuildContext _context, _dismissingContext;

// ignore: must_be_immutable
class _Body extends StatefulWidget {
  _State _dialog = _State();

  @override
  State<StatefulWidget> createState() {
    return _dialog;
  }

  update() {
    _dialog.update();
  }
}

class _State extends State<_Body> {
  update() {
    setState(() {});
  }

  @override
  void dispose() {
    _isShowing = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MediaQuery(
      // Set the default textScaleFactor to 1.0 for
      // the whole subtree.
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: MediaQuery(
          // Set the default textScaleFactor to 1.0 for
          // the whole subtree.
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: kMediumPadding),
                    margin: EdgeInsets.only(
                      top: 20.0,
                      left: (MediaQuery.of(context).size.width / 7),
                      right: (MediaQuery.of(context).size.width / 7),
                    ),
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
                          style: theme.textTheme.bodyText1!.copyWith(
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
                                style: theme.textTheme.bodyText1!.copyWith(
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
              )
            ],
          )),
        ),
      ),
    );
  }
}

class ProcessIndicator2 {
  late _Body _dialog;

  ProcessIndicator2(BuildContext context) {
    _context = context;
  }

  bool isShowing() {
    return _isShowing;
  }

  Future<bool> dismiss() {
    return Future.delayed(const Duration(milliseconds: 100), () {
      if (_isShowing) {
        try {
          _isShowing = false;
          if (Navigator.of(_dismissingContext).canPop()) {
            Navigator.of(_dismissingContext).pop();
          }

          return Future.value(true);
        } catch (_) {
          return Future.value(false);
        }
      } else {
        return Future.value(false);
      }
    });
  }

  void show({String? message, String? body}) {
    Future.delayed(const Duration(milliseconds: 50), () {
      _show(message: message ?? _dialogMessage, body: body ?? _dialogBody);
    });
  }

  void _show({String? message, String? body}) {
    _dialogMessage = message!;
    _dialogBody = body!;
    if (!_isShowing) {
      _dialog = new _Body();
      _isShowing = true;

      showGeneralDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 200),
        context: _context,
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          _dismissingContext = context;

          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: _dialog,
          );
        },
      );
    }
  }
}

import 'dart:async';
import 'dart:html' hide Platform;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_sdk/flutter_zoom_web.dart';
import 'package:flutter_zoom_sdk/zoom_view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_sdk/zoom_options.dart';
import 'package:global_stream/blocs/onboarding/onboarding_bloc.dart';
import 'package:global_stream/data/onboarding/local/category_response.dart';
import 'package:global_stream/data/onboarding/local/matches_response.dart';
import 'package:global_stream/utils/constants.dart';
import 'package:global_stream/utils/strings.dart';
import 'package:intl/intl.dart';

class SubCategory extends StatefulWidget {
  final GetCategoriesData data;
  final String apiKey;
  final String apiSecret;

  const SubCategory(
      {Key? key,
      required this.data,
      required this.apiKey,
      required this.apiSecret})
      : super(key: key);

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  final dateFormat = DateFormat('yyyy-dd-MM  ');
  late Timer timer;
  OnboardingBloc _bloc = OnboardingBloc();
  bool isLoading = false;
  List<GetMatchesData> getMatches = [];
  String? apiKey;
  String? apiSecret;
  String? meetingPassword;
  String? meetingId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetMatchEvent(widget.data.categoryId!));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightBlue,
        title: Row(
          children: [
            Text(
              widget.data.categoryname!,
              style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (event, state) {
          if (state is Loading) {
            setState(() {
              isLoading = true;
            });
          }

          if (state is StringSuccess) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response),
              ),
            );
          }

          if (state is GetMatchesSuccess) {
            setState(() {
              isLoading = false;
              apiSecret = state.response.apiSecret;
              apiKey = state.response.apiKey;
              state.response.data!.forEach((element) {
                getMatches.add(element);
              });
            });
          }
          if (state is ErrorResponseSuccess) {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: Container(
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("${imagePath}sub_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: isLoading
              ? Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: kColorWhite),
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : Column(
                  children: getMatches
                      .map((e) => InkWell(
                            onTap: () {
                              setState(() {
                                meetingId = e.meetingId;
                                meetingPassword = e.meetingPassword;
                              });
                              print("tapped");

                              joinMeetingWeb(context);

                              // if(Platform.isIOS || Platform.isAndroid){
                              //   print("hersse");
                              //   joinMeeting(context);
                              // }else{
                              //   print("here");
                              //   joinMeetingWeb(context);
                              // }

                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: kRegularPadding,
                                  vertical: kMediumPadding),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kRegularPadding,
                                  vertical: kSmallPadding),
                              decoration: BoxDecoration(
                                  color: kColorWhite,
                                  borderRadius:
                                      BorderRadius.circular(kPadding)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.matchName!,
                                    style: textTheme.bodyText2!.copyWith(
                                        color: kGreyColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 16,
                                        decoration: const BoxDecoration(
                                            color: kPrimaryDeepGreen,
                                            shape: BoxShape.circle),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "${dateFormat.format(e.matchDate!.toLocal())}${e.matchTime}",
                                        style: textTheme.subtitle1!
                                            .copyWith(color: kGreyLightColor),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
        ),
      ),
    );
  }

  // startMeeting(BuildContext context) {
  //   bool _isMeetingEnded(String status) {
  //     var result = false;
  //
  //     if (Platform.isAndroid)
  //       result = status == "MEETING_STATUS_DISCONNECTING" ||
  //           status == "MEETING_STATUS_FAILED";
  //     else
  //       result = status == "MEETING_STATUS_IDLE";
  //
  //     return result;
  //   }
  //
  //   ZoomOptions zoomOptions = ZoomOptions(
  //     domain: "zoom.us",
  //     appKey: widget.apiKey, //API KEY FROM ZOOM
  //     appSecret: widget.apiSecret, //API SECRET FROM ZOOM
  //   );
  //   var meetingOptions = ZoomMeetingOptions(
  //       userId: 'evilrattdeveloper@gmail.com',
  //       //pass host email for zoom
  //       userPassword: 'Dlinkmoderm0641',
  //       //pass host password for zoom
  //       disableDialIn: "false",
  //       disableDrive: "false",
  //       disableInvite: "false",
  //       disableShare: "false",
  //       disableTitlebar: "false",
  //       viewOptions: "false",
  //       noAudio: "false",
  //       noDisconnectAudio: "false");
  //
  //   var zoom = ZoomView();
  //   zoom.initZoom(zoomOptions).then((results) {
  //     if (results[0] == 0) {
  //       zoom.onMeetingStatus().listen((status) {
  //         print("[Meeting Status Stream] : " + status[0] + " - " + status[1]);
  //         if (_isMeetingEnded(status[0])) {
  //           print("[Meeting Status] :- Ended");
  //           timer.cancel();
  //         }
  //         if (status[0] == "MEETING_STATUS_INMEETING") {
  //           zoom.meetinDetails().then((meetingDetailsResult) {
  //             print("[MeetingDetailsResult] :- " +
  //                 meetingDetailsResult.toString());
  //           });
  //         }
  //       });
  //       zoom.startMeeting(meetingOptions).then((loginResult) {
  //         print("[LoginResult] :- " + loginResult[0] + " - " + loginResult[1]);
  //         if (loginResult[0] == "SDK ERROR") {
  //           //SDK INIT FAILED
  //           print((loginResult[1]).toString());
  //         } else if (loginResult[0] == "LOGIN ERROR") {
  //           //LOGIN FAILED - WITH ERROR CODES
  //           print((loginResult[1]).toString());
  //         } else {
  //           //LOGIN SUCCESS & MEETING STARTED - WITH SUCCESS CODE 200
  //           print((loginResult[0]).toString());
  //         }
  //       });
  //     }
  //   }).catchError((error) {
  //     print("[Error Generated] : " + error);
  //   });
  // }

  joinMeeting(BuildContext context) {
    bool _isMeetingEnded(String status) {
      var result = false;

      if (Platform.isAndroid) {
        result = status == "MEETING_STATUS_DISCONNECTING" ||
            status == "MEETING_STATUS_FAILED";
      } else {
        result = status == "MEETING_STATUS_IDLE";
      }
      print(result);
      return result;
    }

    if (meetingId!.isNotEmpty && meetingPassword!.isNotEmpty) {
      print(apiKey);
      ZoomOptions zoomOptions = ZoomOptions(
        domain: "zoom.us",
        appKey: apiKey, //API KEY FROM ZOOM
        appSecret: apiSecret, //API SECRET FROM ZOOM
      );
      var meetingOptions = ZoomMeetingOptions(
          userId: 'username',
          //pass username for join meeting only --- Any name eg:- EVILRATT.
          meetingId: meetingId,
          //pass meeting id for join meeting only
          meetingPassword: meetingPassword,
          //pass meeting password for join meeting only
          disableDialIn: "true",
          disableDrive: "true",
          disableInvite: "true",
          disableShare: "true",
          disableTitlebar: "false",
          viewOptions: "true",
          noAudio: "false",
          noDisconnectAudio: "false");

      var zoom = ZoomView();
      zoom.initZoom(zoomOptions).then((results) {
        if (results[0] == 0) {
          zoom.onMeetingStatus().listen((status) {
            print("[Meeting Status Stream] : " + status[0] + " - " + status[1]);
            if (_isMeetingEnded(status[0])) {
              print("[Meeting Status] :- Ended");
              timer.cancel();
            }
          });
          print("listen on event channel");
          zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
            timer = Timer.periodic(Duration(seconds: 2), (timer) {
              zoom.meetingStatus(meetingOptions.meetingId!).then((status) {
                print("[Meeting Status Polling] : " +
                    status[0] +
                    " - " +
                    status[1]);
              });
            });
          });
        }
      }).catchError((error) {
        print("[Error Generated] : " + error);
      });
    } else {
      if (meetingId!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Enter a valid meeting id to continue."),
        ));
      } else if (meetingPassword!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Enter a meeting password to start."),
        ));
      }
    }
  }

  joinMeetingWeb(BuildContext context) {
    print("here2");
    if (meetingId!.isNotEmpty &&
        meetingPassword!.isNotEmpty) {
      ZoomOptions zoomOptions = ZoomOptions(
          domain: "zoom.us",
          appKey: apiKey, //API KEY FROM ZOOM - Jwt API Key
          appSecret:
          apiSecret, //API SECRET FROM ZOOM - Jwt API Secret
          language: "en-US", // Optional - For Web
          showMeetingHeader: true, // Optional - For Web
          disableInvite: false, // Optional - For Web
          disableCallOut: false, // Optional - For Web
          disableRecord: false, // Optional - For Web
          disableJoinAudio: false, // Optional - For Web
          audioPanelAlwaysOpen: false, // Optional - For Web
          isSupportAV: true, // Optional - For Web
          isSupportChat: true, // Optional - For Web
          isSupportQA: true, // Optional - For Web
          isSupportCC: true, // Optional - For Web
          isSupportPolling: true, // Optional - For Web
          isSupportBreakout: true, // Optional - For Web
          screenShare: true, // Optional - For Web
          rwcBackup: '', // Optional - For Web
          videoDrag: true, // Optional - For Web
          sharingMode: 'both', // Optional - For Web
          videoHeader: true, // Optional - For Web
          isLockBottom: true, // Optional - For Web
          isSupportNonverbal: true, // Optional - For Web
          isShowJoiningErrorDialog: true, // Optional - For Web
          disablePreview: false, // Optional - For Web
          disableCORP: true, // Optional - For Web
          inviteUrlFormat: '', // Optional - For Web
          disableVOIP: false, // Optional - For Web
          disableReport: false, // Optional - For Web
          meetingInfo: const [
            // Optional - For Web
            'topic',
            'host',
            'mn',
            'pwd',
            'telPwd',
            'invite',
            'participant',
            'dc',
            'enctype',
            'report'
          ]);
      var meetingOptions = ZoomMeetingOptions(
        userId:
        'EvilRAT Technologies', //pass username for join meeting only --- Any name eg:- EVILRATT.
        meetingId:
        meetingId, //pass meeting id for join meeting only
        meetingPassword: meetingPassword, //pass meeting password for join meeting only
      );

      var zoom = ZoomViewWeb();
      zoom.initZoom(zoomOptions).then((results) {
        print("here1");
        if (results[0] == 0) {
          print("here3");
          var zr = window.document.getElementById("zmmtg-root");
          querySelector('body')?.append(zr!);
          zoom.onMeetingStatus().listen((status) {
            print("[Meeting Status Stream] : " + status[0] + " - " + status[1]);
          });
          final signature = zoom.generateSignature(
              zoomOptions.appKey.toString(),
              zoomOptions.appSecret.toString(),
              meetingId!,
              0);
          meetingOptions.jwtAPIKey = zoomOptions.appKey.toString();
          meetingOptions.jwtSignature = signature;
          zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
            print("here5");
            print("[Meeting Status Polling] : " + joinMeetingResult.toString());
            timer = Timer.periodic(new Duration(seconds: 2), (timer) {
              zoom.meetingStatus(meetingOptions.meetingId!).then((status) {
                print("[Meeting Status Polling] : " +
                    status[0] +
                    " - " +
                    status[1]);
              });
            });
          });
        }
      }).catchError((error) {
        print("[Error Generated] : " + error);
      });
    } else {
      if (meetingId!.isEmpty) {
        print("here7");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Enter a valid meeting id to continue."),
        ));
      } else if (meetingPassword!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Enter a meeting password to start."),
        ));
      }
    }
  }

}

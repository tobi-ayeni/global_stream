import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_stream/blocs/onboarding/onboarding_bloc.dart';
import 'package:global_stream/data/onboarding/local/category_response.dart';
import 'package:global_stream/data/onboarding/local/login_response.dart';
import 'package:global_stream/ui/onboarding/homepage/sub_category.dart';
import 'package:global_stream/ui/onboarding/signin.dart';
import 'package:global_stream/utils/constants.dart';
import 'package:global_stream/utils/strings.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final LogInResponseData data;

  const HomePage({Key? key, required this.data}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OnboardingBloc _bloc = OnboardingBloc();
  bool isLoading = false;
  List<GetCategoriesData> getCategories = [];
  String? warning;
  String? apiKey;
  String? apiSecret;
  final dateFormat = DateFormat('dd MMM yyyy');
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String? deviceId;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetCategoryEvent());

    // timer = Timer.periodic(
    //     const Duration(seconds: 2), (Timer t) => checkPlatforms());
  }

  // Future<String> checkPlatforms() async {
  //   var deviceIdentifier = 'unknown';
  //   var deviceInfo = DeviceInfoPlugin();
  //
  //   if (Platform.isAndroid) {
  //     var androidInfo = await deviceInfo.androidInfo;
  //     deviceIdentifier = androidInfo.androidId!;
  //     _bloc.add(CheckLoginEvent(deviceIdentifier));
  //   } else if (Platform.isIOS) {
  //     var iosInfo = await deviceInfo.iosInfo;
  //     deviceIdentifier = iosInfo.identifierForVendor!;
  //     _bloc.add(CheckLoginEvent(deviceIdentifier));
  //   } else if (Platform.isLinux) {
  //     var linuxInfo = await deviceInfo.linuxInfo;
  //     deviceIdentifier = linuxInfo.machineId!;
  //     _bloc.add(CheckLoginEvent(deviceIdentifier));
  //   } else if (kIsWeb) {
  //     var webInfo = await deviceInfo.webBrowserInfo;
  //     deviceIdentifier = webInfo.vendor! +
  //         webInfo.userAgent! +
  //         webInfo.hardwareConcurrency.toString();
  //     _bloc.add(CheckLoginEvent(deviceIdentifier));
  //   }
  //   return deviceIdentifier;
  // }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
    timer!.cancel();
  }



  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightBlue,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset("${imagePath}person.png"),
            const SizedBox(
              width: kSmallPadding,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.fullName!,
                  style: textTheme.bodyText1!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(widget.data.mobile!, style: textTheme.bodyText2),
              ],
            )
          ],
        ),
        actions: [
          Row(
            children: [
              Text(
                "Expires on ${dateFormat.format(widget.data.createdAt!.toLocal())}",
                style: textTheme.bodyText2!
                    .copyWith(color: kPrimaryLight, fontSize: 12),
              ),
              const SizedBox(
                width: kRegularPadding,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignIn(),
                      ),
                          (route) => false);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: kRegularPadding),
                  child: Icon(Icons.power_settings_new_outlined),
                ),
              ),
            ],
          )
        ],
      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (event, state) {
          if (state is Loading) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is CheckLogInSuccess) {
            print(state.response.message);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignIn(),
                ),
                (route) => false);
          }

          if (state is GetCategoriesSuccess) {
            setState(() {
              isLoading = false;
              warning = state.response.warning;
              apiKey = state.response.apiKey;
              apiSecret = state.response.apiSecret;
              state.response.data!.forEach((element) {
                getCategories.add(element);
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
              image: AssetImage("${imagePath}scaffold_background.png"),
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
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(kMediumPadding),
                        child: Column(
                            children: getCategories
                                .map(
                                  (e) => InkWell(
                                    onTap: e.meetingPassword == ""
                                        ? null
                                        : () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => SubCategory(
                                                  data: e,
                                                  apiKey: apiKey!,
                                                  apiSecret: apiSecret!,
                                                ),
                                              ),
                                            );
                                          },
                                    child: Container(
                                      padding:
                                          const EdgeInsets.all(kRegularPadding),
                                      margin: const EdgeInsets.only(
                                          bottom: kSmallPadding),
                                      decoration: BoxDecoration(
                                          color: kColorWhite,
                                          borderRadius:
                                              BorderRadius.circular(kPadding)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.categoryname!,
                                            style: textTheme.bodyText2!
                                                .copyWith(
                                                    color: kGreyColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                                color: e.categoryId == "10"
                                                    ? Colors.red
                                                    : kPrimaryDeepGreen,
                                                shape: BoxShape.circle),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kRegularPadding, vertical: kSmallPadding),
                      color: kGreenishYellow,
                      child: Text(
                        warning ?? "",
                        style:
                            textTheme.subtitle1!.copyWith(color: kGreenYellow),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  List notificationArgs;
  SplashScreen({Key? key, this.notificationArgs = const []}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  final SharedPrefManager sharedPrefManager = locator<SharedPrefManager>();
  final String rider = "rider";
  final String customer = "customer";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      switch (state) {
        case AppLifecycleState.inactive:
          debugPrint("Inactive");
          break;
        case AppLifecycleState.paused:
          debugPrint("Paused");
          break;
        case AppLifecycleState.resumed:
          var isValidUser_ = isValidUser();
          var loginDate = sharedPrefManager.getLoginDate();
          if (loginDate.isNotEmpty) {
            if (!isValidUser_) {
              forceLogoutAndNavigateToLogin();
            }
          }
          break;
        case AppLifecycleState.detached:
          break;
        default:
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initTimer();
  }

  void initTimer() async {
    if (await checkInternetConnection()) {
      _navigateAfterDelay();
    } else {
      showToast(Strings.no_internet_error, false);
      _navigateAfterDelay();
    }
  }

  void _navigateAfterDelay() {
    FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) {
      Timer(
        const Duration(seconds: 2),
        () {
          Navigator.pushReplacement(
            context,
            AnimScaleTransition(page: _handleNavigation(remoteMessage)),
          );
        },
      );
    });
  }

  Widget _handleNavigation(RemoteMessage? remoteMsg) {
    final SharedPrefManager sharedPrefManager = locator<SharedPrefManager>();
    final ApiClient apiClient = locator<ApiClient>();
    // var userId = sharedPrefManager.getUserId();
    // var loginDate = sharedPrefManager.getLoginDate();
    // var currentDate = getCurrentDate("");
    // var roleLabel = sharedPrefManager.getRoleLabel();
    var token = sharedPrefManager.getAccessToken();
    var isValidUser_ = isValidUser();
    var baseUrl = sharedPrefManager.getBaseUrl();
    if (!sharedPrefManager.getIsDeviceLinked() || baseUrl.isEmpty) {
      return const LinkDeviceScreen();
    }
    if (isValidUser_) {
      if (token != null) apiClient.updateAuthKeyInHeader(token);

      if (remoteMsg != null) {
        NotificationInfoModel? notificatioInfoModel =
            NotificationInfoModel.fromJson(remoteMsg.data);
        try {
          return NotificationNavigation().getApprovalScreen(
            model: notificatioInfoModel,
          );
        } on Exception catch (e) {
          return const DashboardCommonScreen();
        }
      }
      return const DashboardCommonScreen();
    } else {
      return const LoginScreen();
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width,
        height: size.height,
        color: const AppColors().white_ffffff,
        child: Stack(
          children: [
            Positioned(
              top: Dimens.spacing_0,
              bottom: Dimens.spacing_0,
              left: Dimens.spacing_0,
              right: Dimens.spacing_0,
              child: Padding(
                padding: const EdgeInsets.all(100),
                child: SvgPicture.asset(ImageConstants.IC_APP_LOGO,
                    height: 100, width: 56),
              ),
            ),
            Positioned(
                bottom: Dimens.spacing_16,
                left: Dimens.spacing_0,
                right: Dimens.spacing_0,
                child: Image.asset(
                  ImageConstants.IC_EVOLVE_LOGIN_LOGO,
                  width: Dimens.spacing_40,
                  height: Dimens.spacing_40,
                ))
          ],
        ));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}

Future<bool> isConnectedToInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      debugPrint('connected');
      return true;
    }
  } on SocketException catch (e) {
    debugPrint('not connected ${e.message}');
    return false;
  }
  return false;
}

int formatMonth(String month) {
  var newMonth = month.toLowerCase();
  return newMonth == "january"
      ? 1
      : newMonth == "february"
          ? 2
          : newMonth == "march"
              ? 3
              : newMonth == "april"
                  ? 4
                  : newMonth == "may"
                      ? 5
                      : newMonth == "june"
                          ? 6
                          : newMonth == "july"
                              ? 7
                              : newMonth == "august"
                                  ? 8
                                  : newMonth == "september"
                                      ? 9
                                      : newMonth == "october"
                                          ? 10
                                          : newMonth == "november"
                                              ? 11
                                              : newMonth == "december"
                                                  ? 12
                                                  : -1;
}

String getCurrentDate(String format) {
  return (format.isEmpty)
      ? DateFormat('yyyy-MM-dd').format(DateTime.now())
      : DateFormat(format).format(DateTime.now());
}

String getP3MDate() {
  String currentYear = DateFormat('yyyy').format(DateTime.now());
  String currentMoth = DateFormat('MM').format(DateTime.now());
  String currentDay = DateFormat('dd').format(DateTime.now());
  var date = DateTime(
      int.parse(currentYear), int.parse(currentMoth), int.parse(currentDay));
  return DateFormat('yyyy-MM-dd')
      .format(DateTime(date.year, date.month - 3, date.day));
}

String getP6MDate() {
  String currentYear = DateFormat('yyyy').format(DateTime.now());
  String currentMoth = DateFormat('MM').format(DateTime.now());
  String currentDay = DateFormat('dd').format(DateTime.now());
  var date = DateTime(
      int.parse(currentYear), int.parse(currentMoth), int.parse(currentDay));
  return DateFormat('yyyy-MM-dd')
      .format(DateTime(date.year, date.month - 6, date.day));
}

String getYTDDate() {
  final now = DateTime.now();
  var date = DateTime(now.year, 1, 1).toString();
  var dateParse = DateTime.parse(date);
  String returnDate = DateFormat('yyyy-MM-dd')
      .format(DateTime(dateParse.year, dateParse.month, dateParse.day));
  return returnDate;
}

String getMTDDate() {
  final now = DateTime.now();
  var date = DateTime(now.year, now.month, 1).toString();
  var dateParse = DateTime.parse(date);
  return DateFormat('yyyy-MM-dd')
      .format(DateTime(dateParse.year, dateParse.month, dateParse.day));
}

String formatSelectedDate(DateTime selectedDate) {
  return DateFormat('yyyy-MM-dd').format(selectedDate);
}

String getStartEndTime(DateTime dateTime) {
  var newDateTime = TimeOfDay.fromDateTime(dateTime);
  return '${newDateTime.hour}:${newDateTime.minute} ${newDateTime.period.name.toUpperCase()}';
}

void showToast(String title, bool status) {
  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor:
          (status) ? AppColors.green_rgba_0CCB6B : AppColors.red_rgba_ED3241,
      textColor: AppColors.white_rgba_ffffff,
      fontSize: 16);
}

String format2DigitDecimal(num value) {
  var newNum = value.toStringAsFixed(2);
  var nums = newNum.split(".");
  return (nums[1] == '00') ? nums[0] : newNum;
}

Future<bool> checkIfGpsEnabled() async {
  bool isEnabled = false;
  Location location = Location();
  isEnabled = await location.serviceEnabled();
  return isEnabled;
}

String naStringParser(String? st) {
  if (st.isNotNullOrEmpty()) {
    return st!;
  }
  return "N/A";
}

Future<void> requestService(Function(bool) callback) async {
  Location location = Location();
  bool isEnabled = await location.requestService();
  callback(isEnabled);
}

Widget OnClickWidget({required Function onClick, required Widget child}) {
  return InkWell(
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimens.spacing_16),
    ),
    splashColor: AppColors.grey_rgba_e0e7ff,
    onTap: () {
      onClick();
    },
    child: child,
  );
}

Widget shimmerLoading({required Widget child}) {
  return Shimmer.fromColors(
    baseColor: AppColors.grey_rgba_e0e7ff,
    highlightColor: AppColors.grey_rgba_bfc5d2,
    child: child,
  );
}

Widget horizontalProgressLoading(bool isLoading) {
  return Visibility(
      visible: isLoading,
      child: const LinearProgressIndicator(
        backgroundColor: AppColors.blue_rgba_2e5bff,
      ));
}

Logger getLogger() {
  Logger logger = Logger(
    filter: null,
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: true,
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
    ),
    output: null,
  );
  return logger;
}

Widget getEmptyDataComponent(String message) {
  return Center(
    child: Text(
      message,
      style: text_1F2024_14_Bold2_w400,
    ),
  );
}

SmartRefresher pullToRefresh(
    {required bool initialRefresh,
    required Function() onRefreshCallback,
    required Widget child}) {
  return SmartRefresher(
    controller: RefreshController(initialRefresh: initialRefresh),
    enablePullDown: true,
    onRefresh: onRefreshCallback,
    header: const ClassicHeader(),
    child: child,
  );
}

String getCurrentDateWithFormat(String format) {
  return DateFormat(format).format(DateTime.now());
}

const bool isReleaseMode = bool.fromEnvironment('dart.vm.product');
const bool isProfileMode = bool.fromEnvironment('dart.vm.profile');
const bool isDebugMode = !isReleaseMode && !isProfileMode;

Future<bool> android11AndAbove() async {
  var androidInfo = await DeviceInfoPlugin().androidInfo;
  return androidInfo.version.sdkInt >= 30;
}

Future<bool> android10() async {
  var androidInfo = await DeviceInfoPlugin().androidInfo;
  return androidInfo.version.sdkInt == 29;
}

Future<bool> android9AndBelow() async {
  var androidInfo = await DeviceInfoPlugin().androidInfo;
  return androidInfo.version.sdkInt <= 28;
}

Future<String> getDownloadPath() async {
  if (await android11AndAbove()) {
    final dir = await getExternalStorageDirectory();
    return dir?.path ?? '';
  }

  final extPath = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOADS);
  Directory appDocDirectory = Directory(extPath);
  return appDocDirectory.path;
}

String getRoleId(String name) {
  if (name == 'Area Sales Manager') {
    return 'ASM';
  } else if (name == 'Deputy Sales Manager') {
    return 'DSM';
  } else if (name == 'Direct Sales Representative') {
    return 'DSE';
  } else if (name == 'National Sales Manager') {
    return 'NSM';
  } else if (name == 'Regional Sales Manager') {
    return 'RSM';
  } else if (name == 'Sales Team Leader') {
    return 'STL';
  } else if (name == 'Teritory Sales Incharge') {
    return 'TSI';
  } else if (name == 'Admin') {
    return 'Admin';
  } else {
    return getInitials(name);
  }
}

String getInitials(String name) => name.isNotEmpty
    ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';

checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

String getQpsPercent(int target, int achieved) {
  if (target > 0) {
    num achievement = (achieved / target) * 100;
    return format2DigitDecimal(achievement);
  }
  return '0';
}

String enumName(String enumToString) {
  List<String> paths = enumToString.split(".");
  return paths[paths.length - 1];
}

String decryptAES(String scanData) {
  try {
    final key = encrypt.Key.fromUtf8(UtilConstants.ACTIVATION_DECRYPTION_KEY);
    final iv = encrypt.IV.fromUtf8(UtilConstants.ACTIVATION_DECRYPTION_IV);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    var decrypted = encrypter.decrypt64(scanData, iv: iv);
    debugPrint("DECRYPTED DATA:==================>$decrypted");
    return decrypted;
  } catch (e) {
    throw Exception("Invalid Decrypt Key!");
  }
}

String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

void navigateTo(BuildContext context, Widget newScreen) {
  Navigator.push(context, AnimScaleTransition(page: newScreen));
}

isNullOrEmpty(String? token) {
  return token == null || token.isEmpty;
}

forceLogoutAndNavigateToLogin() async {
  showToast("Relogin! Authorization Failed .", false);
  await forceLogout();
  replaceAllAndNavigateToLoginScreen();
}

Future<void> forceLogout() async {
  DashboardTodayViewModel viewModel = locator<DashboardTodayViewModel>();
  await viewModel.logout();
  // TODO Notification
  removeFirebaseToken();
}

replaceAllAndNavigateToLoginScreen() {
  NavigationService.navigateTo(ScreenPath.loginScreen, replace: true);
}

isValidUser() {
  final SharedPrefManager sharedPrefManager = locator<SharedPrefManager>();
  var userId = sharedPrefManager.getUserId();
  var loginDate = sharedPrefManager.getLoginDate();
  var currentDate = getCurrentDate("");
  var token = sharedPrefManager.getAccessToken();
  var hasToken = token != null && token != '';
  return userId != null &&
      userId > 0 &&
      loginDate == currentDate &&
      sharedPrefManager.getInitialDataSaved() &&
      hasToken;
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

String formatAmount(double? amount) {
  try {
    if (amount == null) return "-";
    final NumberFormat numberFormat = NumberFormat('#,##,##0.##');
    return numberFormat.format(amount);
  } on Exception {
    return "$amount";
  }
}

String formatNumber(double value) {
  if (value == value.toInt()) {
    return value.toInt().toString(); // Return as integer if whole number
  } else if ((value * 10).toInt() == (value * 10)) {
    return value.toStringAsFixed(
        1); // Return with one decimal if it's a whole number with one decimal
  } else {
    return value.toStringAsFixed(1); // Return with one decimal
  }
}

extension Extensions on String? {
  bool isNotNullOrEmpty() {
    return this != null && this != "";
  }

  bool isNullOrEmpty() {
    return this == null || this == '';
  }
}

parseToDate(dynamic date, {String? format}) {
  try {
    if (date is! DateTime) {
      if (isValidEpoch(date)) {
        return parseToDate(convertEpochToDateTime(date), format: format);
      } else {
        return DateTime.parse(date.toString());
      }
    } else {
      //  return DateFormat(format ?? "yyyy-MM-dd")
      // .format(DateTime.parse(date.toString()));
      return DateTime.parse(date.toString());
    }
  } on Exception catch (e) {
    // TODO
    return "Invalid Date";
  }
}

bool isValidEpoch(String? input) {
  if (input == null) return false;
  int? epoch = int.tryParse(input);

  if (epoch == null) {
    return false;
  }

  try {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(epoch * 1000, isUtc: true);

    return true;
  } catch (e) {
    // If an exception occurs, return false
    return false;
  }
}

DateTime convertEpochToDateTime(dynamic epoch) {
  if (epoch is int) {
    return DateTime.fromMillisecondsSinceEpoch(epoch);
  } else if (epoch is String) {
    int? epochInt = int.tryParse(epoch);
    if (epochInt != null) {
      return DateTime.fromMillisecondsSinceEpoch(epochInt);
    } else {
      throw const FormatException("Invalid epoch string format");
    }
  } else {
    throw ArgumentError("Input must be an int or a string");
  }
}

// Format the date to "July 30, 2024"
formatDateMMMdY(dynamic date) {
  try {
    return DateFormat('MMMM d, y').format(DateTime.parse(date));
  } catch (e) {
    return "";
  }
}

String toCapitalCase(String input) {
  if (input.isEmpty) return input;

  return input
      .split(' ') // Split the string by spaces
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : word) // Capitalize the first letter of each word
      .join(' '); // Join the words back into a single string
}

double? dynamicFontSize(value) {
  if (value.toString().length > 15) {
    return 12;
  } else if (value.toString().length > 14) {
    return 13;
  } else if (value.toString().length > 13) {
    return 13;
  }
  return null;
}

bool generateRandomBool() {
  final randomNumberGenerator = Random();
  return randomNumberGenerator.nextBool();
}

String parseHtmlToPlainText(String htmlText) {
  var document = parse(htmlText);
  String parsedString;
  try {
    parsedString = parse(document.body?.text).documentElement!.text;
  } catch (e) {
    parsedString = "";
  }

  return parsedString; // Get the plain text
}

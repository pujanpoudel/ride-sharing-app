import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sharedPrefManager = GetIt.instance;

class SharedPrefManager {
  static SharedPrefManager? _instance;
  static SharedPreferences? _sharedPref;
  static var flutterSecureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static Future<SharedPrefManager> getInstance() async {
    _sharedPref ??= await SharedPreferences.getInstance();
    return _instance ??= SharedPrefManager();
  }

  //user_id
  Future<void> setUserId(int userId) async {
    await _sharedPref?.setInt(PreferenceConstants.prefUserId, userId);
  }

  int? getUserId() {
    return _sharedPref?.getInt(PreferenceConstants.prefUserId);
  }

  //parent_id
  Future<void> setParentId(int parentId) async {
    await _sharedPref?.setInt(PreferenceConstants.prefParentId, parentId);
  }

  int? getParentId() {
    return _sharedPref?.getInt(PreferenceConstants.prefParentId);
  }

  //access_token
  Future<void> setAccessToken(String token) async {
    await _sharedPref?.setString(PreferenceConstants.prefAccessToken, token);
  }

  String? getAccessToken() {
    return _sharedPref?.getString(PreferenceConstants.prefAccessToken);
  }

  //full_name
  Future<void> setFullName(String name) async {
    await _sharedPref?.setString(PreferenceConstants.prefFullName, name);
  }

  String? getFullName() {
    return _sharedPref?.getString(PreferenceConstants.prefFullName);
  }

  //refresh_token
  Future<void> setRefreshToken(String token) async {
    await _sharedPref?.setString(PreferenceConstants.prefRefreshToken, token);
  }

  String? getRefreshToken() {
    return _sharedPref?.getString(PreferenceConstants.prefRefreshToken);
  }

  //pin
  Future<void> setPin(String pin) {
    return flutterSecureStorage.write(
        key: PreferenceConstants.prefPassword, value: pin);
  }

  Future<String?> getPin() async {
    try {
      return await flutterSecureStorage.read(
              key: PreferenceConstants.prefPassword) ??
          '';
    } on PlatformException {
      await flutterSecureStorage.deleteAll();
      return '';
    }
  }

  //role_id
  Future<void> setRoleId(int roleId) async {
    await _sharedPref?.setInt(PreferenceConstants.prefRoleId, roleId);
  }

  int? getRoleId() {
    return _sharedPref?.getInt(PreferenceConstants.prefRoleId);
  }

  //role
  Future<void> setRole(String role) async {
    await _sharedPref?.setString(PreferenceConstants.prefRole, role);
  }

  String? getRole() {
    return _sharedPref?.getString(PreferenceConstants.prefRole);
  }

  Future<void> setRoleLabel(String roleLabel) async {
    await _sharedPref?.setString(PreferenceConstants.prefRoleLabel, roleLabel);
  }

  String? getRoleLabel() {
    return _sharedPref?.getString(PreferenceConstants.prefRoleLabel);
  }

  //checked_in
  setCheckedIn(bool hasCheckedIn) async {
    await _sharedPref?.setBool(
        PreferenceConstants.prefHasCheckedIn, hasCheckedIn);
  }

  bool? getHasCheckedIn() {
    return _sharedPref?.getBool(PreferenceConstants.prefHasCheckedIn);
  }

  //attendance_id
  Future<void> setAttendanceId(int id) async {
    await _sharedPref?.setInt(PreferenceConstants.prefAttendanceId, id);
  }

  int? getAttendanceId() {
    return _sharedPref?.getInt(PreferenceConstants.prefAttendanceId);
  }

  //check_in_time
  setCheckInTime(String checkInTime) async {
    await _sharedPref?.setString(
        PreferenceConstants.prefCheckInTime, checkInTime);
  }

  String? getCheckInTime() {
    return _sharedPref?.getString(PreferenceConstants.prefCheckInTime);
  }

  //check_in_address
  Future<void> setCheckInAddress(String checkInTime) async {
    await _sharedPref?.setString(
        PreferenceConstants.prefCheckInAddress, checkInTime);
  }

  String? getCheckInAddress() {
    return _sharedPref?.getString(PreferenceConstants.prefCheckInAddress);
  }

  //check_in_image
  Future<void> setCheckInImage(String checkInTime) async {
    await _sharedPref?.setString(
        PreferenceConstants.prefCheckInImage, checkInTime);
  }

  String? getCheckInImage() {
    return _sharedPref?.getString(PreferenceConstants.prefCheckInImage);
  }

  //check_out_time
  Future<void> setCheckOutTime(String checkInTime) async {
    await _sharedPref?.setString(
        PreferenceConstants.prefCheckOutTime, checkInTime);
  }

  String? getCheckOutTime() {
    return _sharedPref?.getString(PreferenceConstants.prefCheckOutTime);
  }

  //check_out_address
  setCheckOutAddress(String checkInTime) async {
    await _sharedPref?.setString(
        PreferenceConstants.prefCheckOutAddress, checkInTime);
  }

  String? getCheckOutAddress() {
    return _sharedPref?.getString(PreferenceConstants.prefCheckOutAddress);
  }

  //check_out_image
  Future<void> setCheckOutImage(String checkInTime) async {
    await _sharedPref?.setString(
        PreferenceConstants.prefCheckOutImage, checkInTime);
  }

  String? getCheckOutImage() {
    return _sharedPref?.getString(PreferenceConstants.prefCheckOutImage);
  }

  //roster_id
  Future<void> setRosterId(int id) async {
    await _sharedPref?.setInt(PreferenceConstants.prefRosterId, id);
  }

  int? getRosterId() {
    return _sharedPref?.getInt(PreferenceConstants.prefRosterId);
  }

  Future<void> clear() async {
    await _sharedPref?.clear();
  }

  Future<void> setLoginDate(String date) async {
    await _sharedPref?.setString(PreferenceConstants.prefLoginDate, date);
  }

  String getLoginDate() {
    return _sharedPref?.getString(PreferenceConstants.prefLoginDate) ?? "";
  }

  Future<void> setBrandDistributionTarget(bool isEnabled) async {
    await _sharedPref?.setBool(
        PreferenceConstants.prefBrandDistributionTarget, isEnabled);
  }

  bool getBrandDistributionTarget() {
    return _sharedPref
            ?.getBool(PreferenceConstants.prefBrandDistributionTarget) ??
        false;
  }

  Future<void> setHasRouteStarted(bool isStarted) async {
    await _sharedPref?.setBool(PreferenceConstants.prefRouteStarted, isStarted);
  }

  bool? getHasRouteStarted() {
    return _sharedPref?.getBool(PreferenceConstants.prefRouteStarted) ?? false;
  }

  //current end-point
  Future<void> setCurrentUrl(String url) async {
    await _sharedPref?.setString(PreferenceConstants.prefCurrentUrl, url);
  }

  String? getCurrentUrl() {
    return _sharedPref?.getString(PreferenceConstants.prefCurrentUrl);
  }

  int? getSelectedRouteIndex() {
    return _sharedPref?.getInt(PreferenceConstants.prefSelectedRouteIndex) ??
        -1;
  }

  Future<void> setSelectedRouteIndex(int index) async {
    await _sharedPref?.setInt(
        PreferenceConstants.prefSelectedRouteIndex, index);
  }

  Future<void> setPhoneNumber(String phoneNumber) async {
    await _sharedPref?.setString(
        PreferenceConstants.prefPhoneNumber, phoneNumber);
  }

  Future<void> setPermissions(String permissions) async {
    debugPrint("PERMISSIONSSSSSSSSS --------------> $permissions");
    await _sharedPref?.setString(
        PreferenceConstants.prefPermissions, permissions);
  }

  List<PagePermission> getPermissions() {
    var pagePermissions =
        _sharedPref?.getString(PreferenceConstants.prefPermissions) ?? '[]';
    var pagePermissionList = <PagePermission>[];
    jsonDecode(pagePermissions).forEach((element) {
      pagePermissionList.add(PagePermission.fromJson(element));
    });
    return pagePermissionList;
  }

  String getPhoneNumber() {
    return _sharedPref?.getString(PreferenceConstants.prefPhoneNumber) ?? "";
  }

  Future<void> setFingerPrintStatus(int status) async {
    await _sharedPref?.setInt(
        PreferenceConstants.prefFingerPrintStatus, status);
  }

  int getFingerPrintStatus() {
    return _sharedPref?.getInt(PreferenceConstants.prefFingerPrintStatus) ??
        BiometricManager.STATUS_FINGERPRINT_NOT_SET;
  }

  Future<void> setOtpId(int otpId) async {
    await _sharedPref?.setInt(PreferenceConstants.prefOtpId, otpId);
  }

  int? getOtpId() {
    return _sharedPref?.getInt(PreferenceConstants.prefOtpId);
  }

  //checked_in
  Future<void> setInitialDataSaved(bool isInitialDataSaved) async {
    await _sharedPref?.setBool(
        PreferenceConstants.prefIsInitialDataSaved, isInitialDataSaved);
  }

  bool getInitialDataSaved() {
    return _sharedPref?.getBool(PreferenceConstants.prefIsInitialDataSaved) ??
        false;
  }

  //set admin
  Future<void> setIsAdmin(bool isInitialDataSaved) async {
    await _sharedPref?.setBool(PreferenceConstants.isAdmin, isInitialDataSaved);
  }

  bool getIsAdmin() {
    return _sharedPref?.getBool(PreferenceConstants.isAdmin) ?? false;
  }

  //current end-point
  Future<void> setCurrentCustomerId(int customerId) async {
    await _sharedPref?.setInt(
        PreferenceConstants.prefCurrentCustomerId, customerId);
  }

  int getCurrentCustomerId() {
    return _sharedPref?.getInt(PreferenceConstants.prefCurrentCustomerId) ?? -1;
  }

  //is_device_linked
  Future<void> setIsDeviceLinked(bool isDeviceLinked) async {
    await _sharedPref?.setBool(
        PreferenceConstants.prefIsDeviceLinked, isDeviceLinked);
  }

  bool getIsDeviceLinked() {
    return _sharedPref?.getBool(PreferenceConstants.prefIsDeviceLinked) ??
        false;
  }

  // base_url
  Future<void> setBaseUrl(String baseUrl) async {
    await _sharedPref?.setString(PreferenceConstants.prefBaseUrl, baseUrl);
  }

  String getBaseUrl() {
    return _sharedPref?.getString(PreferenceConstants.prefBaseUrl) ?? "";
  }

  bool showDeveloperMode() {
    try {
      var baseUrl = getBaseUrl();
      if (ApiConstants.checkUrlForInspector) {
        if (baseUrl == ApiConstants.devBaseUrl ||
            baseUrl == ApiConstants.qaBaseUrl ||
            baseUrl == ApiConstants.devTestDbsUrl ||
            baseUrl == ApiConstants.regressionDbsUrl ||
            ApiConstants.showForceInspector) {
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> setBranchId(int? branchId) async {
    await _sharedPref?.setInt(PreferenceConstants.prefBranchId, branchId ?? 0);
  }

  int? getBranchId() {
    return _sharedPref?.getInt(PreferenceConstants.prefBranchId);
  }

  Future<void> setSettings(String? setting) async {
    await _sharedPref?.setString(
        PreferenceConstants.prefSettings, setting ?? '{}');
  }

  dynamic getSettings() {
    var settings = _sharedPref?.getString(PreferenceConstants.prefSettings);
    return jsonDecode(settings ?? '{}');
  }
}

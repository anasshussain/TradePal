import '/auth/supabase_auth/auth_util.dart';
import '/repositories/api_requests/api_calls.dart';
import '/repositories/api_requests/api_manager.dart';
import '/repositories/backend.dart';
import '/utils/enums/enums.dart';
import '/models/structs/index.dart';
import '/repositories/supabase/supabase.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/utils/custom_code/actions/index.dart' as actions;
import '/core/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future toast(
  BuildContext context, {
  required String? message,
  required MessageType? type,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message!,
        style: TextStyle(
          color: AppTheme.of(context).messageText,
        ),
      ),
      duration: Duration(milliseconds: 2000),
      backgroundColor: () {
        if (type == MessageType.SUCCESS) {
          return AppTheme.of(context).success;
        } else if (type == MessageType.ERROR) {
          return AppTheme.of(context).error;
        } else if (type == MessageType.WARNING) {
          return AppTheme.of(context).warning;
        } else {
          return AppTheme.of(context).info;
        }
      }(),
    ),
  );
}

Future tapFeedback(BuildContext context) async {}

Future<UserInsuranceRecord?> getUserInsurance(BuildContext context) async {
  return null;
}

Future updateSupabaseUser(BuildContext context) async {
  List<UsersRow>? awd;

  await UsersTable().update(
    data: {
      'id': currentUserUid,
      'email': currentUserEmail,
    },
    matchingRows: (rows) => rows,
  );
}

Future profileState(BuildContext context) async {}

Future userSignUp(
  BuildContext context, {
  required String? email,
  required String? password,
  String? confirmPassword,
}) async {}

Future clearAppData(BuildContext context) async {
  AppState().jobSearches = [];
  AppState().recentlyViewedJobs = [];
  AppState().userProfileCache = UserStruct();
  AppState().jobCache = JobCacheStruct.fromSerializableMap(jsonDecode(
      '{\"jobs\":\"[]\",\"last_cursor\":\"0\",\"first_cursor\":\"0\",\"has_more\":\"true\"}'));
  AppState().submittedJobListCache = [];
  AppState().totalMessagesCount = 0;
  AppState().currentDeviceToken = '';
}

Future insertNotifications(
  BuildContext context, {
  /// Proposal Rejected
  required String? title,

  /// Try searching for another job
  required String? message,
  required String? type,
  required String? userId,
  required String? referenceId,
  required String? recieverid,
  required dynamic extraData,
}) async {
  ApiCallResponse? insertNotificationRes;

  insertNotificationRes = await SupabaseTablesGroup.insertNotificationCall.call(
    userId: userId,
    type: type,
    title: title,
    message: message,
    referenceId: referenceId,
    recieverId: recieverid,
    extraDataJson: extraData,
  );
}

Future getFcmToken(BuildContext context) async {
  String? fcmResult;
  ApiCallResponse? updateUserToken;

  fcmResult = await actions.getFCM(
    context,
  );
  updateUserToken = await SupabaseTablesGroup.addDeviceTokenCall.call(
    userId: currentUserUid,
    deviceToken: fcmResult,
  );
}

Future deleteFcmFromBackend(BuildContext context) async {
  ApiCallResponse? deleteFcmRes;

  deleteFcmRes = await SupabaseTablesGroup.addDeviceTokenCall.call(
    userId: currentUserUid,
    deviceToken: '',
  );
}

Future updateChoosePathOnboarding(
  BuildContext context, {
  UserRole? selectedRole,
}) async {
  ApiCallResponse? updateUserRowResult;

  updateUserRowResult = await SupabaseTablesGroup.updateUserOnboardingCall.call(
    userId: 'eq.${currentUserUid}',
    onboardingStep: 1,
    userRole: () {
      if (selectedRole == UserRole.customer) {
        return 1;
      } else if (selectedRole == UserRole.trades_person) {
        return 2;
      } else {
        return 0;
      }
    }(),
  );

  if ((updateUserRowResult?.succeeded ?? true)) {
    if (selectedRole == UserRole.customer) {
      context.goNamed(EditCustomerProfieWidget.routeName);
    } else {
      context.goNamed(EditTraderProfileWidget.routeName);
    }
  }
}

Future createJobActivity(
  BuildContext context, {
  String? jobid,
  String? userid,
  JobActivities? type,
  dynamic metadata,
}) async {
  ApiCallResponse? addJobActivityRes;

  addJobActivityRes = await SupabaseTablesGroup.insertJobActivityCall.call(
    jobId: jobid,
    userId: currentUserUid,
    type: type?.name,
    metadataJson: {},
    createdAt: getCurrentTimestamp.toString(),
  );
}

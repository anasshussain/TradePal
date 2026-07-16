import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
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
          color: FlutterFlowTheme.of(context).messageText,
        ),
      ),
      duration: Duration(milliseconds: 2000),
      backgroundColor: () {
        if (type == MessageType.SUCCESS) {
          return FlutterFlowTheme.of(context).success;
        } else if (type == MessageType.ERROR) {
          return FlutterFlowTheme.of(context).error;
        } else if (type == MessageType.WARNING) {
          return FlutterFlowTheme.of(context).warning;
        } else {
          return FlutterFlowTheme.of(context).info;
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
  FFAppState().jobSearches = [];
  FFAppState().recentlyViewedJobs = [];
  FFAppState().userProfileCache = UserStruct();
  FFAppState().jobCache = JobCacheStruct.fromSerializableMap(jsonDecode(
      '{\"jobs\":\"[]\",\"last_cursor\":\"0\",\"first_cursor\":\"0\",\"has_more\":\"true\"}'));
  FFAppState().submittedJobListCache = [];
  FFAppState().totalMessagesCount = 0;
  FFAppState().currentDeviceToken = '';
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

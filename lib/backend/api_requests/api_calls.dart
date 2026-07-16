import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start supabase edge functions Group Code

class SupabaseEdgeFunctionsGroup {
  static String getBaseUrl() =>
      'https://ykwdjdyhbujnqeytkbmk.supabase.co/functions/v1';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
    'apikey':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
  };
  static SendOtpCall sendOtpCall = SendOtpCall();
  static VerifyOtpCall verifyOtpCall = VerifyOtpCall();
  static GetBankAccDetailsCall getBankAccDetailsCall = GetBankAccDetailsCall();
  static DeleteBankAccountCall deleteBankAccountCall = DeleteBankAccountCall();
  static CreateDefaultAccountCall createDefaultAccountCall =
      CreateDefaultAccountCall();
  static SendPushNotificationCall sendPushNotificationCall =
      SendPushNotificationCall();
  static GetTotalUnreadCall getTotalUnreadCall = GetTotalUnreadCall();
  static OnboardingStripeConnectAccountCall onboardingStripeConnectAccountCall =
      OnboardingStripeConnectAccountCall();
}

class SendOtpCall {
  Future<ApiCallResponse> call({
    String? email = '',
  }) async {
    final baseUrl = SupabaseEdgeFunctionsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "${email}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'send otp',
      apiUrl: '${baseUrl}/send-otp',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class VerifyOtpCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? code = '',
  }) async {
    final baseUrl = SupabaseEdgeFunctionsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{"email":"${email}",
"otp":"${code}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'verify otp',
      apiUrl: '${baseUrl}/verify-otp',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class GetBankAccDetailsCall {
  Future<ApiCallResponse> call({
    String? accountId = '',
  }) async {
    final baseUrl = SupabaseEdgeFunctionsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "stripeAccountId": "${escapeStringForJson(accountId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'get bank acc details',
      apiUrl: '${baseUrl}/get-bankAccounts',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteBankAccountCall {
  Future<ApiCallResponse> call({
    String? accountId = '',
    String? bankAccountId = '',
  }) async {
    final baseUrl = SupabaseEdgeFunctionsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "stripeAccountId": "${escapeStringForJson(accountId)}",
  "bankAccountId": "${escapeStringForJson(bankAccountId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'delete bank account',
      apiUrl: '${baseUrl}/delete-bankAccount',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateDefaultAccountCall {
  Future<ApiCallResponse> call({
    String? accountId = '',
    String? bankAccountId = '',
  }) async {
    final baseUrl = SupabaseEdgeFunctionsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "acctId": "${escapeStringForJson(accountId)}",
  "externalAccountId": "${escapeStringForJson(bankAccountId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'create default account',
      apiUrl: '${baseUrl}/create-default-account',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SendPushNotificationCall {
  Future<ApiCallResponse> call({
    String? deviceToken = '',
    String? title = '',
    String? body = '',
    dynamic? dataJson,
  }) async {
    final baseUrl = SupabaseEdgeFunctionsGroup.getBaseUrl();

    final data = _serializeJson(dataJson);
    final ffApiRequestBody = '''
{
  "fcm_token": "${escapeStringForJson(deviceToken)}",
  "title": "${escapeStringForJson(title)}",
  "body": "${escapeStringForJson(body)}",
  "data": ${data}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'send push notification',
      apiUrl: '${baseUrl}/send-push-notifications',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTotalUnreadCall {
  Future<ApiCallResponse> call({
    String? authtoken = '',
  }) async {
    final baseUrl = SupabaseEdgeFunctionsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get total unread',
      apiUrl: '${baseUrl}get_total_unread',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OnboardingStripeConnectAccountCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? email = '',
  }) async {
    final baseUrl = SupabaseEdgeFunctionsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": "${escapeStringForJson(userId)}",
  "email": "${escapeStringForJson(email)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'onboarding stripe connect account',
      apiUrl: '${baseUrl}/create-connect-account',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrd2RqZHloYnVqbnFleXRrYm1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5MTQ2OTUsImV4cCI6MjA4NzQ5MDY5NX0.rZ31XNG9-SVgP8zeq_d7k6w99PdxvkGpVBlDH0j35TY',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
}

/// End supabase edge functions Group Code

/// Start supbase rpc Group Code

class SupbaseRpcGroup {
  static String getBaseUrl({
    String? token,
  }) {
    token ??= FFDevEnvironmentValues().authToken;
    return 'https://ykwdjdyhbujnqeytkbmk.supabase.co/rest/v1/rpc/';
  }

  static Map<String, String> headers = {
    'Authorization': 'Bearer [token]',
    'Prefer': 'return=representation',
    'apikey': '[token]',
  };
  static AddJobCall addJobCall = AddJobCall();
  static UpdateJobRpcCall updateJobRpcCall = UpdateJobRpcCall();
  static SendMessageCall sendMessageCall = SendMessageCall();
  static GetConversationBetweenUsersCall getConversationBetweenUsersCall =
      GetConversationBetweenUsersCall();
  static MarkConversationReadCall markConversationReadCall =
      MarkConversationReadCall();
  static UpdateTradePersonRatingCall updateTradePersonRatingCall =
      UpdateTradePersonRatingCall();
  static SearchConversationsCall searchConversationsCall =
      SearchConversationsCall();
}

class AddJobCall {
  Future<ApiCallResponse> call({
    String? title = '',
    double? lat,
    double? lng,
    String? city = '',
    String? state = '',
    String? zipCode = '',
    String? country = '',
    String? userid = '',
    String? description = '',
    int? budget,
    String? category = '',
    int? totalQuotes,
    List<String>? imagesList,
    String? address = '',
    String? name = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupbaseRpcGroup.getBaseUrl(
      token: token,
    );
    final images = _serializeList(imagesList);

    final ffApiRequestBody = '''
{
  "job_title": "${escapeStringForJson(title)}",
  "lat": ${lat},
  "lng": ${lng},
  "city": "${escapeStringForJson(city)}",
  "state": "${escapeStringForJson(state)}",
  "zipcode": "${escapeStringForJson(zipCode)}",
  "country": "${escapeStringForJson(country)}",
  "user_id": "${escapeStringForJson(userid)}",
  "description": "${escapeStringForJson(description)}",
  "budget_min": ${budget},
  "category": "${escapeStringForJson(category)}",
  "total_quotes": ${totalQuotes},
  "images": ${images},
  "address": "${escapeStringForJson(address)}",
  "name": "${escapeStringForJson(name)}",
  "location_type": "JOB"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addJob',
      apiUrl: '${baseUrl}create_job_with_location',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Prefer': 'return=representation',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateJobRpcCall {
  Future<ApiCallResponse> call({
    String? jobId = '',
    String? userId = '',
    String? title = '',
    String? description = '',
    int? budget,
    double? lat,
    double? lng,
    String? city = '',
    String? state = '',
    String? zipCode = '',
    String? country = '',
    String? category = '',
    String? totalQuotes = '',
    List<String>? imagesList,
    String? address = '',
    String? name = '',
    String? assignedTradespersonId = '',
    String? status = 'ACTIVE',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupbaseRpcGroup.getBaseUrl(
      token: token,
    );
    final images = _serializeList(imagesList);

    final ffApiRequestBody = '''
{
  "p_job_id": "${escapeStringForJson(jobId)}",
  "p_user_id": "${escapeStringForJson(userId)}",
  "p_job_title": "${escapeStringForJson(title)}",
  "p_description": "${escapeStringForJson(description)}",
  "p_budget_min": ${budget},
  "p_lat": ${lat},
  "p_lng": ${lng},
  "p_city": "${escapeStringForJson(city)}",
  "p_state": "${escapeStringForJson(state)}",
  "p_zipcode": "${escapeStringForJson(zipCode)}",
  "p_country": "${escapeStringForJson(country)}",
  "p_category": "${escapeStringForJson(category)}",
  "p_total_quotes": "${escapeStringForJson(totalQuotes)}",
  "p_images": ${images},
  "p_address": "${escapeStringForJson(address)}",
  "p_name": "${escapeStringForJson(name)}",
  "p_location_type": "JOB"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'update job rpc',
      apiUrl: '${baseUrl}update_job',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Prefer': 'return=representation',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SendMessageCall {
  Future<ApiCallResponse> call({
    String? conversationId = '',
    String? senderId = '',
    String? content = '',
    String? messageType = '',
    String? imageUrl = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupbaseRpcGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "p_conversation_id": "${escapeStringForJson(conversationId)}",
  "p_sender_id": "${escapeStringForJson(senderId)}",
  "p_content": "${escapeStringForJson(content)}",
  "p_message_type": "${escapeStringForJson(messageType)}",
  "p_image_url": "${escapeStringForJson(imageUrl)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'send message',
      apiUrl: '${baseUrl}send_message',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Prefer': 'return=representation',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetConversationBetweenUsersCall {
  Future<ApiCallResponse> call({
    String? userA = '',
    String? userB = '',
    String? jobId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupbaseRpcGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "user_a": "${escapeStringForJson(userA)}",
  "user_b": "${escapeStringForJson(userB)}",
  "p_job_id": "${escapeStringForJson(jobId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'get conversation between users',
      apiUrl: '${baseUrl}get_or_create_conversation',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Prefer': 'return=representation',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MarkConversationReadCall {
  Future<ApiCallResponse> call({
    String? conversationId = '',
    String? authtoken = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupbaseRpcGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "p_conversation_id": "${escapeStringForJson(conversationId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'mark conversation read',
      apiUrl: '${baseUrl}mark_conversation_read',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Prefer': 'return=representation',
        'apikey': '${token}',
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateTradePersonRatingCall {
  Future<ApiCallResponse> call({
    String? pTradepersonId = '',
    String? authtoken = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupbaseRpcGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "p_tradeperson_id": "${escapeStringForJson(pTradepersonId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'update trade person rating',
      apiUrl: '${baseUrl}update_tradeperson_rating',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Prefer': 'return=representation',
        'apikey': '${token}',
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SearchConversationsCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? searchText = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupbaseRpcGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "p_user_id": "${escapeStringForJson(userId)}",
  "p_search": "${escapeStringForJson(searchText)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'search conversations',
      apiUrl: '${baseUrl}/search_conversations',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Prefer': 'return=representation',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End supbase rpc Group Code

/// Start supabase tables Group Code

class SupabaseTablesGroup {
  static String getBaseUrl({
    String? token,
  }) {
    token ??= FFDevEnvironmentValues().authToken;
    return 'https://ykwdjdyhbujnqeytkbmk.supabase.co/rest/v1';
  }

  static Map<String, String> headers = {
    'Authorization': 'Bearer [token]',
    'apikey': '[token]',
    'Prefer': 'return=representation',
  };
  static GetJobsListCall getJobsListCall = GetJobsListCall();
  static GetUserCall getUserCall = GetUserCall();
  static AddNewUserCall addNewUserCall = AddNewUserCall();
  static UpdateUserOnboardingCall updateUserOnboardingCall =
      UpdateUserOnboardingCall();
  static UpdateUserCall updateUserCall = UpdateUserCall();
  static GetJobDetailsCall getJobDetailsCall = GetJobDetailsCall();
  static GetJobLocationCall getJobLocationCall = GetJobLocationCall();
  static SubmitProposalCall submitProposalCall = SubmitProposalCall();
  static GetSubmittedProposalsCall getSubmittedProposalsCall =
      GetSubmittedProposalsCall();
  static GetSubmittedJobsListCall getSubmittedJobsListCall =
      GetSubmittedJobsListCall();
  static GetConversationsCall getConversationsCall = GetConversationsCall();
  static GetMessagesCall getMessagesCall = GetMessagesCall();
  static TestCall testCall = TestCall();
  static UpdateProposalStatusCall updateProposalStatusCall =
      UpdateProposalStatusCall();
  static UpdateJobStatusCall updateJobStatusCall = UpdateJobStatusCall();
  static GetStripeRowCall getStripeRowCall = GetStripeRowCall();
  static UpdateUserSkillsCall updateUserSkillsCall = UpdateUserSkillsCall();
  static GetNotificationsCall getNotificationsCall = GetNotificationsCall();
  static AddReviewCall addReviewCall = AddReviewCall();
  static InsertNotificationCall insertNotificationCall =
      InsertNotificationCall();
  static AddDeviceTokenCall addDeviceTokenCall = AddDeviceTokenCall();
  static InsertJobActivityCall insertJobActivityCall = InsertJobActivityCall();
  static GetProposalPaymentCall getProposalPaymentCall =
      GetProposalPaymentCall();
}

class GetJobsListCall {
  Future<ApiCallResponse> call({
    String? params = '',
    String? range = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'get jobs list',
      apiUrl:
          '${baseUrl}/jobs?select=id,title,budget_min,category,created_at,applications(count)${params}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
        'Range': '${range}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? title(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].title''',
      ));
  List? list(dynamic response) => getJsonField(
        response,
        r'''$[:]''',
        true,
      ) as List?;
  List? list2(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class GetUserCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'get user',
      apiUrl: '${baseUrl}/users?id=eq.${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].name''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].email''',
      ));
  String? accountStatus(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].account_status''',
      ));
  bool? emailVerified(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].email_verified''',
      ));
  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].id''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].created_at''',
      ));
  bool? insuranceVerified(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].insurance_verified''',
      ));
  String? authenticatedUserId(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].user_key''',
      ));
  int? onboardingSteps(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].onboarding_step''',
      ));
  int? userRole(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].user_role''',
      ));
  String? phone(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].phone''',
      ));
}

class AddNewUserCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? email = '',
    String? phoneNumber = '',
    String? fullName = '',
    String? deviceToken = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "id": "${escapeStringForJson(userId)}",
  "email": "${escapeStringForJson(email)}",
  "email_verified": false,
  "onboarding_step": 0,
  "user_role": 0,
  "phone": "${escapeStringForJson(phoneNumber)}",
  "name": "${escapeStringForJson(fullName)}",
  "user_key": "${escapeStringForJson(userId)}",
  "device_token": "${escapeStringForJson(deviceToken)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'add new user',
      apiUrl: '${baseUrl}/users',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateUserOnboardingCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    int? onboardingStep,
    int? userRole,
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{"onboarding_step":${onboardingStep}, "user_role":${userRole}}''';
    return ApiManager.instance.makeApiCall(
      callName: 'update user onboarding',
      apiUrl: '${baseUrl}/users?id=${userId}',
      callType: ApiCallType.PATCH,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateUserCall {
  Future<ApiCallResponse> call({
    String? profileImage = '',
    String? name = '',
    String? userId = '',
    String? phone = '',
    String? street = '',
    String? zipcode = '',
    String? streetAddress = '',
    String? regNo = '',
    String? serviceArea = '',
    String? profession = '',
    String? insuranceAmount = '',
    String? insuranceExpiry = '',
    String? insuranceCompany = '',
    List<String>? skillsList,
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );
    final skills = _serializeList(skillsList);

    final ffApiRequestBody = '''
{
  "avatar_url": "${escapeStringForJson(profileImage)}",
  "name": "${escapeStringForJson(name)}",
  "phone": "${escapeStringForJson(phone)}",
  "street": "${escapeStringForJson(street)}",
  "zipcode": "${escapeStringForJson(zipcode)}",
  "streetaddress": "${escapeStringForJson(streetAddress)}",
  "user_key": "${escapeStringForJson(userId)}",
  "registration_number": "${escapeStringForJson(regNo)}",
  "service_area": "${escapeStringForJson(serviceArea)}",
  "profession": "${escapeStringForJson(profession)}",
  "insurance_company": "${escapeStringForJson(insuranceCompany)}",
  "insurance_expiry": "${escapeStringForJson(insuranceExpiry)}",
  "insurance_amount": "${escapeStringForJson(insuranceAmount)}",
  "skills": ${skills}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'update user ',
      apiUrl: '${baseUrl}/users?id=eq.${userId}',
      callType: ApiCallType.PATCH,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetJobDetailsCall {
  Future<ApiCallResponse> call({
    String? jobId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'get job details',
      apiUrl:
          '${baseUrl}/jobs?id=eq.${jobId}&select=id,customer_id,location_id,title,description,budget_min,budget_max,assigned_tradesperson_id,created_at,updated_at,total_quotes,category,images,status,customer:users!jobs_customer_id_fkey(id,name,device_token),tradesperson:users!jobs_assigned_tradesperson_id_fkey(id,name,device_token),review:reviews(   id,   overall_rating,   communication_rating,   quality_rating,   comment,   image_urls,   created_at )',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? title(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].title''',
      ));
  List? list(dynamic response) => getJsonField(
        response,
        r'''$[:]''',
        true,
      ) as List?;
  List? list2(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class GetJobLocationCall {
  Future<ApiCallResponse> call({
    String? locationId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getJobLocation',
      apiUrl: '${baseUrl}/locations?id=eq.${locationId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SubmitProposalCall {
  Future<ApiCallResponse> call({
    String? jobId = '',
    String? tradespersonId = '',
    String? message = '',
    int? quoteAmount,
    String? duration = '',
    String? status = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "job_id": "${escapeStringForJson(jobId)}",
  "status": "${escapeStringForJson(status)}",
  "tradesperson_id": "${escapeStringForJson(tradespersonId)}",
  "message": "${escapeStringForJson(message)}",
  "quote_amount": ${quoteAmount},
  "duration": "${escapeStringForJson(duration)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'submit proposal',
      apiUrl: '${baseUrl}/applications',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSubmittedProposalsCall {
  Future<ApiCallResponse> call({
    String? params = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'get submitted proposals',
      apiUrl: '${baseUrl}/applications?${params}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSubmittedJobsListCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? status = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'get submitted jobs List',
      apiUrl:
          '${baseUrl}/applications?select=jobs!inner(*)&tradesperson_id=eq.${userId}&jobs.status=eq.${status}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetConversationsCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'get conversations',
      apiUrl:
          '${baseUrl}/conversation_participants?user_id=eq.${userId}&select=conversation_id, conversations(id,job_id,last_message,last_message_at,conversation_participants(members:users(id,name,avatar_url,device_token)))',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetMessagesCall {
  Future<ApiCallResponse> call({
    String? conversationId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'get messages',
      apiUrl:
          '${baseUrl}/messages?conversation_id=eq.${conversationId}&order=created_at.desc',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TestCall {
  Future<ApiCallResponse> call({
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'test',
      apiUrl: '${baseUrl}/jobs?select=title,category',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateProposalStatusCall {
  Future<ApiCallResponse> call({
    String? status = '',
    String? applicationId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "status": "${escapeStringForJson(status)}" 
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'update proposal status',
      apiUrl: '${baseUrl}/applications?id=eq.${applicationId}',
      callType: ApiCallType.PATCH,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateJobStatusCall {
  Future<ApiCallResponse> call({
    dynamic? payloadJson,
    String? params = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    final payload = _serializeJson(payloadJson);
    final ffApiRequestBody = '''
${payload}''';
    return ApiManager.instance.makeApiCall(
      callName: 'update job  status',
      apiUrl: '${baseUrl}/jobs?${params}',
      callType: ApiCallType.PATCH,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetStripeRowCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'get stripe row',
      apiUrl: '${baseUrl}/stripe_accounts',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {
        'user_id': userId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateUserSkillsCall {
  Future<ApiCallResponse> call({
    List<String>? skillsList,
    String? userId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );
    final skills = _serializeList(skillsList);

    final ffApiRequestBody = '''
{
 "skills":${skills} 
 }''';
    return ApiManager.instance.makeApiCall(
      callName: 'update user  skills',
      apiUrl: '${baseUrl}/users?id=eq.${userId}',
      callType: ApiCallType.PATCH,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetNotificationsCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'get notifications',
      apiUrl:
          '${baseUrl}/notifications?receiver_id=eq.${userId}&order=created_at.desc',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].name''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].email''',
      ));
  String? accountStatus(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].account_status''',
      ));
  bool? emailVerified(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].email_verified''',
      ));
  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].id''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].created_at''',
      ));
  bool? insuranceVerified(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$[:].insurance_verified''',
      ));
  String? authenticatedUserId(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].user_key''',
      ));
  int? onboardingSteps(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].onboarding_step''',
      ));
  int? userRole(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].user_role''',
      ));
  String? phone(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].phone''',
      ));
}

class AddReviewCall {
  Future<ApiCallResponse> call({
    String? jobid = '',
    String? reviewerId = '',
    String? reviewedUserId = '',
    String? comment = '',
    int? overallRating,
    int? qualityRating,
    int? communicationRating,
    int? punctualityRating,
    List<String>? imageUrlList,
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );
    final imageUrl = _serializeList(imageUrlList);

    final ffApiRequestBody = '''
{
  "job_id": "${escapeStringForJson(jobid)}",
  "reviewer_id": "${escapeStringForJson(reviewerId)}",
  "reviewed_user_id": "${escapeStringForJson(reviewedUserId)}",
  "comment": "${escapeStringForJson(comment)}",
  "quality_rating": ${qualityRating},
  "overall_rating": ${overallRating},
  "communication_rating": ${communicationRating},
  "punctuality_rating": "${punctualityRating}",
  "image_urls": ${imageUrl}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'add review',
      apiUrl: '${baseUrl}/reviews',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class InsertNotificationCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? type = '',
    String? title = '',
    String? message = '',
    String? referenceId = '',
    String? recieverId = '',
    dynamic? extraDataJson,
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    final extraData = _serializeJson(extraDataJson);
    final ffApiRequestBody = '''
{
  "user_id": "${escapeStringForJson(userId)}",
  "type": "${escapeStringForJson(type)}",
  "reference_id": "${escapeStringForJson(referenceId)}",
  "message": "${escapeStringForJson(message)}",
  "title": "${escapeStringForJson(title)}",
  "receiver_id": "${escapeStringForJson(recieverId)}",
  "extra_data": ${extraData}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'insert notification',
      apiUrl: '${baseUrl}/notifications',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddDeviceTokenCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? deviceToken = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "device_token": "${escapeStringForJson(deviceToken)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'add device token',
      apiUrl: '${baseUrl}/users?id=eq.${userId}',
      callType: ApiCallType.PATCH,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class InsertJobActivityCall {
  Future<ApiCallResponse> call({
    String? jobId = '',
    String? userId = '',
    String? type = '',
    dynamic? metadataJson,
    String? createdAt = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    final metadata = _serializeJson(metadataJson);
    final ffApiRequestBody = '''
{
  "job_id": "${escapeStringForJson(jobId)}",
  "actor_id": "${escapeStringForJson(userId)}",
  "type": "${escapeStringForJson(type)}",
  "metadata": ${metadata},
  "created_at": "${escapeStringForJson(createdAt)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'insert job activity',
      apiUrl: '${baseUrl}/job_activity',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetProposalPaymentCall {
  Future<ApiCallResponse> call({
    String? jobId = '',
    String? tradepersonId = '',
    String? token,
  }) async {
    token ??= FFDevEnvironmentValues().authToken;
    final baseUrl = SupabaseTablesGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'get proposal payment',
      apiUrl:
          '${baseUrl}/proposal_payments?job_id=eq.${jobId}&tradeperson_id=eq.${tradepersonId}&select=payment_status,stripe_payment_intent_id',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Prefer': 'return=representation',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? paymentStatus(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].payment_status''',
      ));
  String? stripepaymentintentid(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].stripe_payment_intent_id''',
      ));
}

/// End supabase tables Group Code

class CreatePaymentFeeCall {
  static Future<ApiCallResponse> call({
    String? jobId = '',
    String? token = '',
  }) async {
    final ffApiRequestBody = '''
{
  "job_id": "${escapeStringForJson(jobId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'create payment fee',
      apiUrl:
          'https://ykwdjdyhbujnqeytkbmk.supabase.co/functions/v1/create-proposal-payment',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  static String? clientsecret(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.client_secret''',
      ));
  static String? paymentIntentId(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.payment_intent_id''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}

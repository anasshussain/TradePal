// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/util/firestore_util.dart';
import '/models/util/schema_util.dart';
import '/utils/enums/enums.dart';

import '/models/structs/index.dart';
import '/utils/util.dart';

class MemberStruct extends AppFirebaseStruct {
  MemberStruct({
    String? jobid,
    String? username,
    String? avatarurl,
    String? memberId,
    String? memberName,
    String? memberAvatar,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _jobid = jobid,
        _username = username,
        _avatarurl = avatarurl,
        _memberId = memberId,
        _memberName = memberName,
        _memberAvatar = memberAvatar,
        super(firestoreUtilData);

  // "jobid" field.
  String? _jobid;
  String get jobid => _jobid ?? '';
  set jobid(String? val) => _jobid = val;

  bool hasJobid() => _jobid != null;

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  set username(String? val) => _username = val;

  bool hasUsername() => _username != null;

  // "avatarurl" field.
  String? _avatarurl;
  String get avatarurl => _avatarurl ?? '';
  set avatarurl(String? val) => _avatarurl = val;

  bool hasAvatarurl() => _avatarurl != null;

  // "member_id" field.
  String? _memberId;
  String get memberId => _memberId ?? '';
  set memberId(String? val) => _memberId = val;

  bool hasMemberId() => _memberId != null;

  // "member_name" field.
  String? _memberName;
  String get memberName => _memberName ?? '';
  set memberName(String? val) => _memberName = val;

  bool hasMemberName() => _memberName != null;

  // "member_avatar" field.
  String? _memberAvatar;
  String get memberAvatar => _memberAvatar ?? '';
  set memberAvatar(String? val) => _memberAvatar = val;

  bool hasMemberAvatar() => _memberAvatar != null;

  static MemberStruct fromMap(Map<String, dynamic> data) => MemberStruct(
        jobid: data['jobid'] as String?,
        username: data['username'] as String?,
        avatarurl: data['avatarurl'] as String?,
        memberId: data['member_id'] as String?,
        memberName: data['member_name'] as String?,
        memberAvatar: data['member_avatar'] as String?,
      );

  static MemberStruct? maybeFromMap(dynamic data) =>
      data is Map ? MemberStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'jobid': _jobid,
        'username': _username,
        'avatarurl': _avatarurl,
        'member_id': _memberId,
        'member_name': _memberName,
        'member_avatar': _memberAvatar,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'jobid': serializeParam(
          _jobid,
          ParamType.String,
        ),
        'username': serializeParam(
          _username,
          ParamType.String,
        ),
        'avatarurl': serializeParam(
          _avatarurl,
          ParamType.String,
        ),
        'member_id': serializeParam(
          _memberId,
          ParamType.String,
        ),
        'member_name': serializeParam(
          _memberName,
          ParamType.String,
        ),
        'member_avatar': serializeParam(
          _memberAvatar,
          ParamType.String,
        ),
      }.withoutNulls;

  static MemberStruct fromSerializableMap(Map<String, dynamic> data) =>
      MemberStruct(
        jobid: deserializeParam(
          data['jobid'],
          ParamType.String,
          false,
        ),
        username: deserializeParam(
          data['username'],
          ParamType.String,
          false,
        ),
        avatarurl: deserializeParam(
          data['avatarurl'],
          ParamType.String,
          false,
        ),
        memberId: deserializeParam(
          data['member_id'],
          ParamType.String,
          false,
        ),
        memberName: deserializeParam(
          data['member_name'],
          ParamType.String,
          false,
        ),
        memberAvatar: deserializeParam(
          data['member_avatar'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MemberStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MemberStruct &&
        jobid == other.jobid &&
        username == other.username &&
        avatarurl == other.avatarurl &&
        memberId == other.memberId &&
        memberName == other.memberName &&
        memberAvatar == other.memberAvatar;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([jobid, username, avatarurl, memberId, memberName, memberAvatar]);
}

MemberStruct createMemberStruct({
  String? jobid,
  String? username,
  String? avatarurl,
  String? memberId,
  String? memberName,
  String? memberAvatar,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MemberStruct(
      jobid: jobid,
      username: username,
      avatarurl: avatarurl,
      memberId: memberId,
      memberName: memberName,
      memberAvatar: memberAvatar,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MemberStruct? updateMemberStruct(
  MemberStruct? member, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    member
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMemberStructData(
  Map<String, dynamic> firestoreData,
  MemberStruct? member,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (member == null) {
    return;
  }
  if (member.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && member.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final memberData = getMemberFirestoreData(member, forFieldValue);
  final nestedData = memberData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = member.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMemberFirestoreData(
  MemberStruct? member, [
  bool forFieldValue = false,
]) {
  if (member == null) {
    return {};
  }
  final firestoreData = mapToFirestore(member.toMap());

  // Add any Firestore field values
  mapToFirestore(member.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMemberListFirestoreData(
  List<MemberStruct>? members,
) =>
    members?.map((e) => getMemberFirestoreData(e, true)).toList() ?? [];

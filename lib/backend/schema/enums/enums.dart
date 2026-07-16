import 'package:collection/collection.dart';

enum UserRole {
  customer,
  trades_person,
}

enum MessageType {
  SUCCESS,
  ERROR,
  WARNING,
  INFO,
}

enum SystemRole {
  USER,
  ADMIN,
}

enum JobsViewType {
  DASHBOARD,
  BROWSE,
  MY_JOBS,
}

enum LocationType {
  USER,
  JOB,
}

enum JobDetailsView {
  chat,
  general,
}

enum Status {
  ACTIVE,
  IN_ACTIVE,
  SUSPENDED,
  BLOCKED,
  DELETED,
  COMPLETED,
  PAID,
  IN_PROGRESS,
  DISPUTED,
  ACCEPTED,
  REJECTED,
  PENDING,
}

enum NotificationType {
  PROPOSAL,
  CHAT,
  APPLICATION,
}

enum JobActivities {
  JOB_CREATED,
  JOB_UPDATED,
  PROPOSAL_SUBMITTED,
  PROPOSAL_ACCEPTED,
  PROPOSAL_REJECTED,
  TRADEPERSON_ASSIGNED,
  CONVERSATION_STARTED,
  JOB_COMPLETED,
}

enum PaymentStatus {
  pending,
  paid,
  failed,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (UserRole):
      return UserRole.values.deserialize(value) as T?;
    case (MessageType):
      return MessageType.values.deserialize(value) as T?;
    case (SystemRole):
      return SystemRole.values.deserialize(value) as T?;
    case (JobsViewType):
      return JobsViewType.values.deserialize(value) as T?;
    case (LocationType):
      return LocationType.values.deserialize(value) as T?;
    case (JobDetailsView):
      return JobDetailsView.values.deserialize(value) as T?;
    case (Status):
      return Status.values.deserialize(value) as T?;
    case (NotificationType):
      return NotificationType.values.deserialize(value) as T?;
    case (JobActivities):
      return JobActivities.values.deserialize(value) as T?;
    case (PaymentStatus):
      return PaymentStatus.values.deserialize(value) as T?;
    default:
      return null;
  }
}

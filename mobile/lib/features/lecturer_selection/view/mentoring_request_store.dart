import 'package:flutter/foundation.dart';

class MentoringRequestStore {
  static final ValueNotifier<RequestedLecturer?> currentRequest =
      ValueNotifier<RequestedLecturer?>(null);

  static void request(RequestedLecturer lecturer) {
    currentRequest.value = lecturer;
  }

  static void cancel() {
    currentRequest.value = null;
  }

  static bool isRequested(String lecturerId) {
    return currentRequest.value?.id == lecturerId;
  }
}

class RequestedLecturer {
  const RequestedLecturer({
    required this.id,
    required this.name,
    required this.major,
    required this.imageUrl,
    required this.nid,
    required this.guidanceQuotaLeft,
  });

  final String id;
  final String name;
  final String major;
  final String imageUrl;
  final String nid;
  final int guidanceQuotaLeft;
}
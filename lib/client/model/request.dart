import 'package:equatable/equatable.dart';

// This is the URL codes for every base url we have.
enum ApiOf { internal, external, assets }

// Types of request
enum RequestType { get, post, delete, update, put, patch }

class RequestModel extends Equatable {
  final ApiOf url;
  final String endpoint;
  final RequestType type;
  final Map? data;

  const RequestModel({
    required this.url,
    required this.endpoint,
    required this.type,
    this.data,
  });

  @override
  List<Object> get props {
    return [
      url,
      endpoint,
      type,
    ];
  }

  @override
  bool get stringify => false;
}

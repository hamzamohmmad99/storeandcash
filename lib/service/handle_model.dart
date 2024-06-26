// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResulModel {}

class ExceptionModel extends ResulModel {
  String message;
  ExceptionModel({
    required this.message,
  });
}
class ErrorModel extends ResulModel {
  String message;
  ErrorModel({
    required this.message,
  });
}

class ListOf<T>extends ResulModel{
  List<T>modelList;
  ListOf({
    required this.modelList,
  });
}
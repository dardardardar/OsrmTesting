import 'package:dio/dio.dart';

abstract class BaseState<T> {
  final T? data;
  final DioException? exception;
  const BaseState({this.data, this.exception});
}

class SuccessState<T> extends BaseState<T> {
  const SuccessState(T data) : super(data: data);
}

class ErrorState<T> extends BaseState<T> {
  const ErrorState(DioException ex) : super(exception: ex);
}

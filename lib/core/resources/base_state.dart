import 'package:dio/dio.dart';

abstract class BaseState<T> {
  final T? data;
  final DioException? dioException;
  final Exception? exception;
  const BaseState({this.data, this.dioException, this.exception});
}

class InitialState<T> extends BaseState<T> {
  const InitialState();
}

class SuccessState<T> extends BaseState<T> {
  const SuccessState({required T data, String? message}) : super(data: data);
}

class HttpErrorState<T> extends BaseState<T> {
  const HttpErrorState({required DioException ex, T? data})
      : super(dioException: ex);
}

class GeneralErrorState<T> extends BaseState<T> {
  const GeneralErrorState(Exception ex) : super(exception: ex);
}

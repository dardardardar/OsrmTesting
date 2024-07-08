import 'package:dio/dio.dart';

abstract class BaseState<T> {
  final T? data;
  final DioException? dioException;
  final Exception? exception;
  const BaseState({this.data, this.dioException, this.exception});
}

class SuccessState<T> extends BaseState<T> {
  const SuccessState(T data) : super(data: data);
}

class HttpErrorState<T> extends BaseState<T> {
  const HttpErrorState(DioException ex) : super(dioException: ex);
}

class GeneralErrorState<T> extends BaseState<T> {
  const GeneralErrorState(Exception ex) : super(exception: ex);
}

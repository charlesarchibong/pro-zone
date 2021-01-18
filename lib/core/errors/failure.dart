import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();
}

class NoInternetFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NullFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UnknownFailure extends Failure {
  @override
  List<Object> get props => [];
}

class FailureToMessage {
  static String mapFailureToMessage(Failure failure) {
    String message = 'An Error occurred, please try again';
    if (failure is NoInternetFailure) {
      message = 'Please check your internet connection and try again';
    } else if (failure is ServerFailure) {
      message = failure.message;
    } else if (failure is CacheFailure) {
      message = 'Entity no found, please try again';
    }
    return message;
  }
}

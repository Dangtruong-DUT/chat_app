import 'package:chat_app/src/core/utils/error/base/error.exception.dart';
import 'package:dartz/dartz.dart';

typedef Result<T> = Either<ErrorException, T>;

Result<T> success<T>(T value) => Right(value);

Result<T> failure<T>(ErrorException error) => Left(error);

import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultFutureVoid = ResultFuture<void>;

typedef DataMap = Map<String, dynamic>;

import 'package:dartz/dartz.dart';

import '../error/failure.dart';

typedef MapJson = Map<String, dynamic>;
typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<Unit>;

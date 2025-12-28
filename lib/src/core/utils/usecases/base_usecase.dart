import 'package:chat_app/src/core/utils/result/result.dart';

class NoParams {
  const NoParams();
}

abstract class BaseUseCase<Response, Params> {
  Future<Result<Response>> call(Params params);
}

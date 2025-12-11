abstract class BaseUseCase<Response, Params> {
  Future<Response> call({required Params params});
}

abstract class UseCase<Response, Params> {
  Future<Response> call({required Params params});
}

import 'package:chat_app/src/core/utils/error/base/error.exception.dart';

class EntityException extends ErrorException {
  final List<EntityError> errors;

  const EntityException({
    this.errors = const [],
    super.message = 'Entity Exception',
    super.code = 'ENTITY_EXCEPTION',
  });
}

class EntityError {
  final String field;
  final String message;
  const EntityError({required this.field, required this.message});
}

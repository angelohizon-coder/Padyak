class SameLocationException implements Exception {
  String cause;
  SameLocationException(this.cause);
}

class InvalidOriginLocationException implements Exception {
  String cause;
  InvalidOriginLocationException(this.cause);
}

class InvalidDestinationLocationException implements Exception {
  String cause;
  InvalidDestinationLocationException(this.cause);
}

class NoDestinationException implements Exception {
  String cause;
  NoDestinationException(this.cause);
}

class NoInputException implements Exception {
  String cause;
  NoInputException(this.cause);
}

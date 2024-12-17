sealed class Either<L, R> {
  bool get isLeft => this is L;

  bool get isRight => this is R;

  T fold<T>(T Function(L) error, T Function(R) data) => switch (this) {
        Left(:final value) => error(value),
        Right(:final value) => data(value),
      };
}

final class Left<L, R> extends Either<L, R> {
  final L _left;

  Left(this._left);

  L get value => _left;
}

final class Right<L, R> extends Either<L, R> {
  final R _right;

  Right(this._right);

  R get value => _right;
}

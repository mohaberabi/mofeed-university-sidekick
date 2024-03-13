class Pair<F, S> {
  final F first;

  final S second;

  const Pair(this.first, this.second);

  Pair copyWith({
    F? first,
    S? second,
  }) {
    return Pair(
      first ?? this.first,
      second ?? this.second,
    );
  }
}

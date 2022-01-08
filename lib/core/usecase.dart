abstract class UseCase<Type, Params> {
  Type call(Params params);
}

class NoParams {
  @override
  List<Object> get props => [];
}

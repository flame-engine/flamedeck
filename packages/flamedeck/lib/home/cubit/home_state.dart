part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.selected,
  });

  const HomeState.empty() : this(selected: -1);

  final int selected;

  @override
  List<Object?> get props => [selected];
}

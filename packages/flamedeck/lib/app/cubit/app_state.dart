part of 'app_cubit.dart';

class AppState extends Equatable {

  const AppState({
    required this.shellColor,
  });

  const AppState.initial() : this(
    shellColor: const Color(0xffd6a63e),
  );


  final Color shellColor;

  AppState copyWith({
    Color? shellColor,
  }) {
    return AppState(
      shellColor: shellColor ?? this.shellColor,
    );
  }

  @override
  List<Object?> get props => [shellColor];
}

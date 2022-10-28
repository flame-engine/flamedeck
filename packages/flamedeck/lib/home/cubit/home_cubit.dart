import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.empty());

  void selectGame(int i) {
    emit(HomeState(selected: i));
  }

  void unselectGame() {
    emit(const HomeState.empty());
  }
}

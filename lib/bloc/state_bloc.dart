import 'package:flutter_9lb_aruka/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state_state.dart';
import 'state_event.dart';

class WorkBloc extends Bloc<WorkEvent, WorkState> {
  final Repository repository;

  WorkBloc({required this.repository}) : super(WorkInitialState()) {
    on<FetchTodosEvent>(_onFetchTodos);
  }

  Future<void> _onFetchTodos(
      FetchTodosEvent event, Emitter<WorkState> emit) async {
    emit(WorkLoadingState());
    try {
      final todos = await repository.fetchTodos();
      emit(WorkLoadedState(todos));
    } catch (e) {
      emit(WorkErrorState(e.toString()));
    }
  }
}

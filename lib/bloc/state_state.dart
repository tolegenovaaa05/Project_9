abstract class WorkState {}

class WorkInitialState extends WorkState {}

class WorkLoadingState extends WorkState {}

class WorkLoadedState extends WorkState {
  final List<Map<String, dynamic>> todos;

  WorkLoadedState(this.todos);
}

class WorkErrorState extends WorkState {
  final String message;

  WorkErrorState(this.message);
}

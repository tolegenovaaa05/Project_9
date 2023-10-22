import 'package:flutter/material.dart';
import 'package:flutter_9lb_aruka/bloc/state_bloc.dart';
import 'package:flutter_9lb_aruka/bloc/state_event.dart';
import 'package:flutter_9lb_aruka/bloc/state_state.dart';
import 'package:flutter_9lb_aruka/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    WorkScreen(),
    GamesScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Моя Bottom Bar App"),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.yellow,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: "Job",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apple),
            label: "Game",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animatefirst.json'),
            SizedBox(height: 20.0),
            Lottie.asset('assets/animatesecond.json'),
          ],
        ),
      ),
    );
  }
}

class WorkScreen extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkScreen> {
  late WorkBloc _workBloc;

  @override
  void initState() {
    super.initState();
    _workBloc = WorkBloc(repository: Repository());
    _workBloc.add(FetchTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WorkBloc, WorkState>(
        bloc: _workBloc,
        builder: (context, state) {
          if (state is WorkLoadingState) {
            return CircularProgressIndicator();
          } else if (state is WorkLoadedState) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text('userId: ${todo['userId']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('id: ${todo['id']}'),
                      Text('title: ${todo['title']}'),
                      Text('completed: ${todo['completed']}'),
                    ],
                  ),
                );
              },
            );
          } else if (state is WorkErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  @override
  void dispose() {
    _workBloc.close();
    super.dispose();
  }
}

class GamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Это страница "Приложения"',
            style: TextStyle(color: Colors.black, fontSize: 24.0)),
      ),
    );
  }
}

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Это страница "Аккаунт"',
            style: TextStyle(color: Colors.black, fontSize: 24.0)),
      ),
    );
  }
}

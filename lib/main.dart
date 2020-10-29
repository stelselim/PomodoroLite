import 'package:flutter/material.dart';
import 'package:pomodorolite/provider/appstate.dart';
import 'package:pomodorolite/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
          create: (context) => AppState(),
        ),
      ],
      child: MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => HomePage(),
        },
      ),
    );
  }
}

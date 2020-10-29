import 'package:flutter/material.dart';
import 'package:pomodorolite/provider/appstate.dart';
import 'package:pomodorolite/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'notifications/notifications_config.dart';

void main() {
  try {
    if (!kIsWeb) {
      WidgetsFlutterBinding.ensureInitialized();
      initNotification(); // Initialize Notifications
    }
  } catch (e) {
    print(e);
  }

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
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

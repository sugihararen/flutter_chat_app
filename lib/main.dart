import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/repositories/auth_repository.dart';
import 'package:flutter_chat_app/screens/auth/sign_in_screen.dart';
import 'package:flutter_chat_app/screens/auth/sign_up_screen.dart';
import 'package:flutter_chat_app/screens/chat/chat_room_screen.dart';
import 'package:flutter_chat_app/screens/chat/chat_rooms_screen.dart';
import 'package:flutter_chat_app/screens/chat/user_search_screen.dart';
import 'package:flutter_chat_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'models/main_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthRepository()),
      ],
      child: MaterialApp(
        title: 'Flutter Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff145C9E),
          scaffoldBackgroundColor: Color(0xff1F1F1F),
          accentColor: Color(0xff007EF4),
          fontFamily: "OverpassRegular",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
        routes: <String, WidgetBuilder>{
          '/sign_in': (_) => SignInScreen(),
          '/sign_up': (_) => SignUpScreen(),
          '/chat_rooms': (_) => ChatRoomsScreen(),
          '/user_search': (_) => UserSearchScreen(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/chat_room':
              return MaterialPageRoute(
                builder: (context) => ChatRoomScreen(settings.arguments),
              );
              break;
            default:
              return null;
          }
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..load(context),
      child: Consumer<MainModel>(
        builder: (
          BuildContext context,
          MainModel mainModel,
          Widget child,
        ) {
          if (mainModel.loading) {
            return SplashScreen();
          }

          if (mainModel.currentUser != null) {
            return ChatRoomsScreen();
          }

          return SignInScreen();
        },
      ),
    );
  }
}

import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( 
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> UserProvider())
    ],child: const MyApp(),
    )
      
  );
}
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  build(context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child:  MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        //home: const SelectLogin(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

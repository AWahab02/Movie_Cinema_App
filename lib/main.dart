import 'package:flutter/material.dart';
import 'package:movies_tickets_task/provider/movie_provider.dart';
import 'package:movies_tickets_task/provider/seats_provider.dart';
import 'package:movies_tickets_task/routes/navigation_routes.dart';
import 'package:movies_tickets_task/user%20interface/screens/watch_screen.dart';
import 'package:movies_tickets_task/user%20interface/screens/welcome_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => seatsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Poppins"),
        // home: WelcomeScreen(),
        initialRoute: Routes.welcomePage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

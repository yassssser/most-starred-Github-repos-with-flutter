import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:github_repo/app/home/home.page.dart';
import 'package:github_repo/bloc/repository/repository_bloc.dart';
import 'package:github_repo/enum/stateStatus.enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo/services/github.serice.dart';

void setUpServices() {
  GetIt.I.registerLazySingleton(() => GithubService());
}

void main() {
  setUpServices();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RepositoryBloc(RepositoryState(requestState: StateStatus.NONE)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Github Repo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          duration: 100,
          splash: Image.asset("assets/images/github.png"),
          nextScreen: HomePage(),
          splashTransition: SplashTransition.rotationTransition,
        ),
      ),
    );
  }
}

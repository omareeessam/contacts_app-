import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/business_logic/app_cubit.dart';
import 'package:my_contacts_app/presentaion/router/app_router.dart';
import 'package:sizer/sizer.dart';

import 'constants/block_observer.dart';

void main() {
  runApp(MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return BlocProvider(
            create: (context) => AppCubit()..createDatabase(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              onGenerateRoute: appRouter.onGenerateRoute,
            ),
          );
        }
    );
  }
}


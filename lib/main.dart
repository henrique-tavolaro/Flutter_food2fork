import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food2fork/Network/NetworkService.dart';
import 'package:food2fork/SearchBloc.dart';

import 'Screen/HomeSearch.dart';
import 'Screen/RecipeDetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food 2 Fork',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<RecipeBloc>(
        create: (BuildContext context) {
          return RecipeBloc(NetworkService(Dio()));
        },
      child: HomeSearch()
      // ,
      )
    );
  }
}

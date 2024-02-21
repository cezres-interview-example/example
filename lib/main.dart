import 'package:example/routes/human_resources_metrics/bloc/human_resources_metrics_bloc.dart';
import 'package:example/routes/human_resources_metrics/human_resources_metrics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => HumanResourcesMetricsBloc(
          HumanResourcesMetricsState.example(),
        ),
        child: const HumanResourcesMetricsPage(),
      ),
    );

    if (kIsWeb) {
      return Container(
        color: Colors.grey[100],
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 375,
            height: 812,
            child: app,
          ),
        ),
      );
    } else {
      return app;
    }
  }
}

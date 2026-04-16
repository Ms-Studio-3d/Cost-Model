import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';

class CostModelApp extends StatelessWidget {
  const CostModelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cost Model',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

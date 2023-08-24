import 'package:campus_app/app.dart';
import 'package:campus_app/core/utils/injector.dart' as di;
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  di.init();
  runApp(const App());
}

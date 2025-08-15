import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_giphy_search/app.dart';

void main() async {
  await dotenv.load();
  
  runApp(const App());
}

import 'package:flutter/material.dart';
import 'package:petadaptionapp/screens/details_page.dart';
import 'package:petadaptionapp/screens/history_page.dart';
import 'package:petadaptionapp/screens/home_page.dart';

import 'models/pet_model.dart';

class AppRoutes {
  static const String home = '/';
  static const String details = '/details';
  static const String history = '/history';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());

      case details:
        // Extract the arguments passed to this route
        if (settings.arguments is Pet) {
          final pet = settings.arguments as Pet;
          return MaterialPageRoute(builder: (_) => DetailsPage(pet: pet));
        }
        return _errorRoute();

      case history:
        return MaterialPageRoute(builder: (_) => HistoryPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Page not found!')),
      ),
    );
  }
}

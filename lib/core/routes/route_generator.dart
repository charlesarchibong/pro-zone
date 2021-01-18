import 'package:flutter/material.dart';
import 'package:prozone_app/features/provider/presentation/pages/list_providers_page.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(
          builder: (_) => ListProvidersPage(),
        );
    }
  }
}

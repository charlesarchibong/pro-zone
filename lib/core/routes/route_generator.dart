import 'package:flutter/material.dart';
import 'package:prozone_app/core/constants/route_names.dart';
import 'package:prozone_app/features/provider/presentation/pages/add_provider_images_page.dart';
import 'package:prozone_app/features/provider/presentation/pages/edit_provider_details_page.dart';
import 'package:prozone_app/features/provider/presentation/pages/list_providers_page.dart';
import 'package:prozone_app/features/provider/presentation/pages/provider_detail_page.dart';
import 'package:prozone_app/features/provider/presentation/pages/view_provider_image_page.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case VIEW_PROVIDER_DETAIL_PAGE:
        return MaterialPageRoute(
          builder: (_) => ProviderDetailPage(
            providerEntity: settings.arguments,
          ),
        );
      case EDIT_PROVIDER_DETAILS_PAGE:
        return MaterialPageRoute(
          builder: (_) => EditProviderDetailsPage(
            providerEntity: settings.arguments,
          ),
        );
      case VIEW_PROVIDER_IMAGE_PAGE:
        return MaterialPageRoute(
          builder: (_) => ViewProviderImagesPage(
            providerEntity: settings.arguments,
          ),
        );
      case ADD_PROVIDER_IMAGES_PAGE:
        return MaterialPageRoute(
          builder: (_) => AddProviderImagePage(
            providerEntity: settings.arguments,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => ListProvidersPage(),
        );
    }
  }
}

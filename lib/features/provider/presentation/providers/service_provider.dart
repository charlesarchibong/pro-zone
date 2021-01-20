import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/domain/use_cases/create_provider_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_all_providers_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_provider_types_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_states_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/upload_provider_images.dart';

class ServiceProvider extends ChangeNotifier {
  final CreateProviderUseCase createProviderUseCase;
  final GetAllProvidersUsecase getAllProvidersUsecase;
  final GetProviderTypesUsecase getProviderTypesUsecase;
  final GetStatesUsecase getStatesUsecase;
  final UploadProviderImagesUsecase uploadProviderImagesUsecase;

  ServiceProvider({
    @required this.createProviderUseCase,
    @required this.getAllProvidersUsecase,
    @required this.getProviderTypesUsecase,
    @required this.getStatesUsecase,
    @required this.uploadProviderImagesUsecase,
  });

  bool _isHome = true;
  bool get isHome => _isHome;

  List<ProviderEntity> _providers = List();
  List<ProviderEntity> get providers => _providers;

  void toggleHome() {
    _isHome = !_isHome;
    notifyListeners();
  }

  Future<Either<Failure, List<ProviderEntity>>> getProvidersList() async {
    final providers = await getAllProvidersUsecase();
    providers.fold((l) => print(l), (r) => _providers = r);
    notifyListeners();
    return providers;
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_type_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/state_entity.dart';
import 'package:prozone_app/features/provider/domain/use_cases/create_provider_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/edit_provider_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_all_providers_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_provider_types_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_states_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/upload_provider_images.dart';

class ServiceProvider extends ChangeNotifier {
  final CreateProviderUseCase createProviderUseCase;
  final GetAllProvidersUsecase getAllProvidersUsecase;
  final GetProviderTypesUsecase getProviderTypesUsecase;
  final GetStatesUsecase getStatesUsecase;
  final EditProviderUseCase editProviderUseCase;
  final UploadProviderImagesUsecase uploadProviderImagesUsecase;

  ServiceProvider({
    @required this.createProviderUseCase,
    @required this.getAllProvidersUsecase,
    @required this.getProviderTypesUsecase,
    @required this.getStatesUsecase,
    @required this.uploadProviderImagesUsecase,
    @required this.editProviderUseCase,
  });

  bool _isHome = true;
  bool get isHome => _isHome;

  List<ProviderEntity> _providers = List();
  List<ProviderEntity> get providers => _providers;

  List<StateEntity> _states = List();
  List<StateEntity> get states => _states;

  List<ProviderTypeEntity> _providerTypes = List();
  List<ProviderTypeEntity> get providerTypes => _providerTypes;

  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  void toggleHome() {
    _isHome = !_isHome;
    notifyListeners();
  }

  Future<Either<Failure, List<ProviderEntity>>> getProvidersList() async {
    _loading.value = true;
    final providers = await getAllProvidersUsecase();
    providers.fold((l) => print(l), (r) => _providers = r);
    notifyListeners();
    _loading.value = false;
    return providers;
  }

  Future<Either<Failure, ProviderEntity>> editProvider(
      ProviderEntity providerEntity) async {
    _loading.value = true;
    final provider = await editProviderUseCase(providerEntity);
    _loading.value = false;
    return provider;
  }

  Future<Either<Failure, ProviderEntity>> addProvider(
      ProviderEntity providerEntity) async {
    _loading.value = true;
    final provider = await createProviderUseCase(providerEntity);
    _loading.value = false;
    return provider;
  }

  Future<Either<Failure, List<ProviderTypeEntity>>>
      getProviderTypeList() async {
    _loading.value = true;
    final providerTypes = await getProviderTypesUsecase();
    providerTypes.fold((l) => print(l), (r) => _providerTypes = r);
    notifyListeners();
    _loading.value = false;
    return providerTypes;
  }

  Either<Failure, bool> validateAddProviderForm({
    String name,
    String description,
    String address,
    ProviderTypeEntity providerTypeEntity,
    StateEntity stateEntity,
  }) {
    if (name == null || name.isEmpty) {
      return Left(
        FormValidationFailure(
          message: 'Provider name can not be empty',
        ),
      );
    }
    if (description == null || description.isEmpty) {
      return Left(
        FormValidationFailure(
          message: 'Provider description can not be empty',
        ),
      );
    }
    if (description == null || description.isEmpty) {
      return Left(
        FormValidationFailure(
          message: 'Provider address can not be empty',
        ),
      );
    }
    if (providerTypeEntity == null) {
      return Left(
        FormValidationFailure(
          message: 'please select a provider type',
        ),
      );
    }
    if (stateEntity == null) {
      return Left(
        FormValidationFailure(
          message: 'please select a provider state',
        ),
      );
    }
    return Right(true);
  }

  Future<Either<Failure, List<StateEntity>>> getStateList() async {
    _loading.value = true;
    final states = await getStatesUsecase();
    states.fold((l) => print(l), (r) => _states = r);
    notifyListeners();
    _loading.value = false;
    return states;
  }
}

import 'package:meta/meta.dart';
import 'package:prozone_app/core/constants/endpoint_constants.dart';
import 'package:prozone_app/core/errors/error.dart';
import 'package:prozone_app/core/network/http_requester.dart';
import 'package:prozone_app/core/network/network_info.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';
import 'package:prozone_app/features/provider/data/models/provider_type_model.dart';
import 'package:prozone_app/features/provider/data/models/state_model.dart';

abstract class RemoteDataSource {
  Future<List<ProviderModel>> getProviders();
  Future<List<StateModel>> getStates();
  Future<List<ProviderTypeModel>> getProviderTypes();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final NetworkInfo networkInfo;
  final HttpServiceRequester httpServiceRequester;

  RemoteDataSourceImpl({
    @required this.networkInfo,
    @required this.httpServiceRequester,
  });

  @override
  Future<List<ProviderModel>> getProviders() async {
    if (await networkInfo.isConnected) {
      final response = await httpServiceRequester.getRequest(
        url: GET_PROVIDERS_ENDPOINT,
      );
      return ProviderModelList.fromJson(response.data).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<StateModel>> getStates() async {
    if (await networkInfo.isConnected) {
      final response = await httpServiceRequester.getRequest(
        url: GET_STATES_ENDPOINT,
      );
      return StateModelList.fromJson(response.data).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<ProviderTypeModel>> getProviderTypes() async {
    if (await networkInfo.isConnected) {
      final response = await httpServiceRequester.getRequest(
        url: GET_PROVIDER_TYPE_ENDPOINT,
      );
      return ProviderTypeModelList.fromJson(response.data).list;
    } else {
      throw NoInternetException();
    }
  }
}

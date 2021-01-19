import 'package:meta/meta.dart';
import 'package:prozone_app/core/constants/endpoint_constants.dart';
import 'package:prozone_app/core/errors/error.dart';
import 'package:prozone_app/core/network/http_requester.dart';
import 'package:prozone_app/core/network/network_info.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';

abstract class RemoteDataSource {
  Future<List<ProviderModel>> getProviders();
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
}

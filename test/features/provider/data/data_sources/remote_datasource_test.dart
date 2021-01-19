import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prozone_app/core/constants/endpoint_constants.dart';
import 'package:prozone_app/core/network/http_requester.dart';
import 'package:prozone_app/core/network/network_info.dart';
import 'package:prozone_app/features/provider/data/data_sources/remote_datasource.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';

import '../../../../fixtures/fixture.dart';

class MockHttpServerRequester extends Mock implements HttpServiceRequester {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

main() {
  MockHttpServerRequester mockHttpServerRequester;
  MockNetworkInfo mockNetworkInfo;
  RemoteDataSourceImpl remoteDataSourceImpl;
  setUp(() {
    mockHttpServerRequester = MockHttpServerRequester();
    mockNetworkInfo = MockNetworkInfo();
    remoteDataSourceImpl = RemoteDataSourceImpl(
      httpServiceRequester: mockHttpServerRequester,
      networkInfo: mockNetworkInfo,
    );
  });

  test('should request list of providers from server', () async {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(
      mockHttpServerRequester.getRequest(
        url: GET_PROVIDERS_ENDPOINT,
      ),
    ).thenAnswer(
      (_) async => Response(
        data: [
          json.decode(
            fixture(
              'provider_fixture',
            ),
          ),
        ].toList(),
        statusCode: 200,
      ),
    );
    final result = await remoteDataSourceImpl.getProviders();
    expect(
        result,
        [
          ProviderModel.fromMap(
            json.decode(
              fixture(
                'provider_fixture',
              ),
            ),
          )
        ].toList());
  });
}

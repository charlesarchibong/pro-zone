import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prozone_app/core/constants/endpoint_constants.dart';
import 'package:prozone_app/core/network/http_requester.dart';
import 'package:prozone_app/core/network/network_info.dart';
import 'package:prozone_app/features/provider/data/data_sources/remote_datasource.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';
import 'package:prozone_app/features/provider/data/models/provider_type_model.dart';
import 'package:prozone_app/features/provider/data/models/state_model.dart';

import '../../../../fixtures/fixture.dart';

class MockHttpServerRequester extends Mock implements HttpServiceRequester {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

ProviderModel providerModel = ProviderModel.fromMap(
  json.decode(
    fixture(
      'provider_fixture',
    ),
  ),
);
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

  group('providers', () {
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

    test('should request list of provider types from server', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockHttpServerRequester.getRequest(
          url: GET_PROVIDER_TYPE_ENDPOINT,
        ),
      ).thenAnswer(
        (_) async => Response(
          data: [
            json.decode(
              fixture(
                'provider_type_fixture',
              ),
            ),
          ].toList(),
          statusCode: 200,
        ),
      );
      final result = await remoteDataSourceImpl.getProviderTypes();
      expect(
          result,
          [
            ProviderTypeModel.fromMap(
              json.decode(
                fixture(
                  'provider_type_fixture',
                ),
              ),
            )
          ].toList());
    });

    test('should add new provider to the server', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockHttpServerRequester.post(
          url: GET_PROVIDERS_ENDPOINT,
          contentType: 'application/json',
          body: providerModel.toMap(),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: json.decode(
            fixture(
              'provider_fixture',
            ),
          ),
          statusCode: 200,
        ),
      );
      final result = await remoteDataSourceImpl.createProvider(providerModel);
      expect(
          result,
          ProviderModel.fromMap(
            json.decode(
              fixture(
                'provider_fixture',
              ),
            ),
          ));
    });

    test('should update provider information to the server', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockHttpServerRequester.put(
          url: GET_PROVIDERS_ENDPOINT + '/${providerModel.id}',
          contentType: 'application/json',
          data: providerModel.toMap(),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: json.decode(
            fixture(
              'provider_fixture',
            ),
          ),
          statusCode: 200,
        ),
      );
      final result = await remoteDataSourceImpl.updateProvider(providerModel);
      expect(
          result,
          ProviderModel.fromMap(
            json.decode(
              fixture(
                'provider_fixture',
              ),
            ),
          ));
    });

    // test('should upload provider images to the serser', () async {
    //   when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   when(
    //     mockHttpServerRequester.post(
    //         url: UPLOAD_PROVIDER_IMAGES,
    //         contentType: 'multipart/form-data',
    //         body: FormData.fromMap({
    //           "ref": "provider",
    //           "refId": 'any',
    //           "files": await getMultipartFromFiles([])
    //         })),
    //   ).thenAnswer(
    //     (_) async => Response(
    //       data: json.decode(
    //         fixture(
    //           'image_fixture',
    //         ),
    //       ),
    //       statusCode: 200,
    //     ),
    //   );
    //   final result = await remoteDataSourceImpl.uploadProviderImages(
    //     images: [],
    //     providerId: 'any',
    //   );
    //   expect(
    //       result,
    //       ImageModel.fromMap(
    //         json.decode(
    //           fixture(
    //             'image_fixture',
    //           ),
    //         ),
    //       ));
    // });
  });
  group('states', () {
    test('should request list of states from server', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockHttpServerRequester.getRequest(
          url: GET_STATES_ENDPOINT,
        ),
      ).thenAnswer(
        (_) async => Response(
          data: [
            json.decode(
              fixture(
                'state_fixture',
              ),
            ),
          ].toList(),
          statusCode: 200,
        ),
      );
      final result = await remoteDataSourceImpl.getStates();
      expect(
          result,
          [
            StateModel.fromMap(
              json.decode(
                fixture(
                  'state_fixture',
                ),
              ),
            )
          ].toList());
    });
  });
}

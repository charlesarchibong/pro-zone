import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prozone_app/core/constants/endpoint_constants.dart';
import 'package:prozone_app/core/errors/error.dart';
import 'package:prozone_app/core/network/http_requester.dart';
import 'package:prozone_app/core/network/network_info.dart';
import 'package:prozone_app/features/provider/data/models/image_model.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';
import 'package:prozone_app/features/provider/data/models/provider_type_model.dart';
import 'package:prozone_app/features/provider/data/models/state_model.dart';

abstract class RemoteDataSource {
  Future<List<ProviderModel>> getProviders();
  Future<List<StateModel>> getStates();
  Future<List<ProviderTypeModel>> getProviderTypes();
  Future<ImageModel> uploadProviderImages({
    String providerId,
    List<Asset> images,
  });
  Future<ProviderModel> createProvider(ProviderModel providerModel);
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

  @override
  Future<ProviderModel> createProvider(ProviderModel providerModel) async {
    if (await networkInfo.isConnected) {
      final response = await httpServiceRequester.post(
        url: GET_PROVIDERS_ENDPOINT,
        contentType: 'application/json',
        body: providerModel.toMap(),
      );
      return ProviderModel.fromMap(response.data);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<ImageModel> uploadProviderImages(
      {String providerId, List<Asset> images}) async {
    if (await networkInfo.isConnected) {
      final response = await httpServiceRequester.post(
        url: UPLOAD_PROVIDER_IMAGES,
        contentType: 'multipart/form-data',
        body: FormData.fromMap({
          "ref": "provider",
          "refId": providerId,
          "files": await getMultipartFromFiles(images)
        }),
      );
      return ImageModel.fromMap(response.data);
    } else {
      throw NoInternetException();
    }
  }
}

Future<List<MultipartFile>> getMultipartFromFiles(List<Asset> images) async {
  List<MultipartFile> imageList = List();
  images.forEach((e) async {
    ByteData data = await e.getByteData(quality: 100);
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath +
        '/${e.name}.tmp'; // file_01.tmp is dump file, can be anything
    File image = await File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

    imageList.add(await MultipartFile.fromFile(image.path));
  });
  return imageList;
}

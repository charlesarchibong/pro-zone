import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/core/notice/flush_bar_notice.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/presentation/providers/service_provider.dart';
import 'package:prozone_app/features/provider/presentation/widgets/custom_button_widget.dart';

class AddProviderImagePage extends StatefulWidget {
  final ProviderEntity providerEntity;
  const AddProviderImagePage({
    Key key,
    @required this.providerEntity,
  }) : super(key: key);
  @override
  _AddProviderImagePageState createState() => _AddProviderImagePageState();
}

class _AddProviderImagePageState extends State<AddProviderImagePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(
      builder: (context, serviceProvider, child) {
        return Scaffold(
          backgroundColor: Color(0xffFAFAFA),
          appBar: AppBar(
            title: Text(
              "Add Images",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: ValueListenableBuilder(
                valueListenable: serviceProvider.loading,
                builder: (context, loading, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      serviceProvider.images.length > 0
                          ? Expanded(
                              child: buildGridView(serviceProvider),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Center(
                                child: Text(
                                  'No image selected yet',
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButtonWidget(
                        buttonText: 'Select Photos',
                        onTap: loading
                            ? null
                            : () {
                                _loadAssets();
                              },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButtonWidget(
                        buttonText: loading ? 'Loading' : 'Submit',
                        onTap: loading
                            ? null
                            : serviceProvider.images.length > 0
                                ? () {
                                    _submit();
                                  }
                                : null,
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  );
                }),
          ),
        );
      },
    );
  }

  void _loadAssets() async {
    final loaded =
        await Provider.of<ServiceProvider>(context, listen: false).loadAssets();
    loaded.fold((l) {
      FlushBarNotification.showErrorMessage(
        context: context,
        message: FailureToMessage.mapFailureToMessage(l),
        title: "Error",
      );
    }, (r) {
      FlushBarNotification.showSuccessMessage(
        context: context,
        message: 'Image selected successfully, please click submit to upload',
        title: "Success",
      );
    });
  }

  Widget buildGridView(ServiceProvider serviceProvider) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(serviceProvider.images.length, (index) {
        Asset asset = serviceProvider.images[index];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          ),
        );
      }),
    );
  }

  void _submit() async {
    final added = await Provider.of<ServiceProvider>(context, listen: false)
        .uploadProviderImage(
      widget.providerEntity.id.toString(),
    );
    added.fold((l) {
      FlushBarNotification.showErrorMessage(
        context: context,
        message: FailureToMessage.mapFailureToMessage(l),
        title: "Error",
      );
    }, (r) {
      FlushBarNotification.showSuccessMessage(
        context: context,
        message: 'Provider images was added successfully',
        title: "Success",
      );
    });
  }
}

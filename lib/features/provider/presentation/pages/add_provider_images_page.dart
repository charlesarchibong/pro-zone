import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prozone_app/features/provider/presentation/providers/service_provider.dart';
import 'package:prozone_app/features/provider/presentation/widgets/custom_button_widget.dart';

class AddProviderImagePage extends StatefulWidget {
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
            child: SingleChildScrollView(
              child: ValueListenableBuilder(
                  valueListenable: serviceProvider.loading,
                  builder: (context, loading, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CustomButtonWidget(
                          buttonText: 'Submit',
                          onTap: loading
                              ? null
                              : () {
                                  _submit();
                                },
                        ),
                        SizedBox(
                          height: 70,
                        ),
                      ],
                    );
                  }),
            ),
          ),
        );
      },
    );
  }

  void _submit() {}
}

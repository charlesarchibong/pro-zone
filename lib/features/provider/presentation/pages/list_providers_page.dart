import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prozone_app/core/constants/colors_constant.dart';
import 'package:prozone_app/features/provider/presentation/providers/service_provider.dart';
import 'package:prozone_app/features/provider/presentation/widgets/add_provider_widget.dart';
import 'package:prozone_app/features/provider/presentation/widgets/list_providers_widget.dart';

class ListProvidersPage extends StatefulWidget {
  const ListProvidersPage({
    Key key,
  }) : super(key: key);
  @override
  _ListProvidersPageState createState() => _ListProvidersPageState();
}

class _ListProvidersPageState extends State<ListProvidersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    return Consumer<ServiceProvider>(
        builder: (context, serviceProvider, child) {
      return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        appBar: AppBar(
          leading: Text(''),
          title: Text(
            serviceProvider.isHome ? "Home" : "Add Provider",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Container(
                  height: 38,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xffF0F0F0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: serviceProvider.toggleHome,
                        child: Container(
                          width: width / 2,
                          decoration: BoxDecoration(
                            color: serviceProvider.isHome
                                ? ColorConstant.PRIMARY_COLOR
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Providers",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: serviceProvider.isHome
                                    ? Colors.white
                                    : ColorConstant.TEXTCOLOR2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: serviceProvider.toggleHome,
                        child: Container(
                          width: width / 2,
                          decoration: BoxDecoration(
                            color: !serviceProvider.isHome
                                ? ColorConstant.PRIMARY_COLOR
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Add Provider",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: !serviceProvider.isHome
                                    ? Colors.white
                                    : ColorConstant.TEXTCOLOR2,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: serviceProvider.isHome
                    ? ListProvidersWidget(
                        serviceProvider: serviceProvider,
                      )
                    : AddProviderWidget(
                        serviceProvider: serviceProvider,
                      ),
              )
            ],
          ),
        ),
      );
    });
  }
}

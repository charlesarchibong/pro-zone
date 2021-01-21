import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prozone_app/core/constants/route_names.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/core/notice/flush_bar_notice.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/presentation/providers/service_provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListProvidersWidget extends StatefulWidget {
  final ServiceProvider serviceProvider;
  ListProvidersWidget({
    Key key,
    @required this.serviceProvider,
  }) : super(key: key);

  @override
  _ListProvidersWidgetState createState() => _ListProvidersWidgetState();
}

class _ListProvidersWidgetState extends State<ListProvidersWidget> {
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    _getProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          searchContainer(),
          ValueListenableBuilder(
              valueListenable: widget.serviceProvider.loading,
              builder: (context, loading, child) {
                return loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : widget.serviceProvider.providers.length > 0
                        ? Expanded(
                            child: ListView.builder(
                              itemCount:
                                  widget.serviceProvider.providers.length,
                              itemBuilder: (context, index) {
                                ProviderEntity providerEntity =
                                    widget.serviceProvider.providers[index];
                                return providerDetailWidget(providerEntity);
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              "No provider available at the moment",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: Color(
                                  0xFF323232,
                                ),
                              ),
                            ),
                          );
              })
        ],
      ),
    );
  }

  Widget providerDetailWidget(ProviderEntity providerEntity) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          VIEW_PROVIDER_DETAIL_PAGE,
          arguments: providerEntity,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10.0,
        ),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: ListTile(
            title: Text(
              '${providerEntity.name}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${providerEntity.description}',
                  style: TextStyle(),
                ),
                SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 5,
                  rating: providerEntity.rating == null
                      ? 0.0
                      : providerEntity.rating.toDouble(),
                  size: 12.0,
                  isReadOnly: true,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0,
                )
              ],
            ),
            trailing: Text(
              '${providerEntity.activeStatus}',
              style: TextStyle(
                fontSize: 12,
                color: providerEntity.activeStatus == 'Active'
                    ? Theme.of(context).primaryColor
                    : Colors.yellow[800],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget searchContainer() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          // horizontal: 17,
          vertical: 15,
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 90,
              decoration: BoxDecoration(
                color: Color(0xffEFF2F5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  // left: 25.0,
                  right: 25.0,
                ),
                child: TextFormField(
                  controller: _searchController,
                  enableSuggestions: true,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Color(
                      0xFF323232,
                    ),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search providers eg Charles',
                    hintStyle: TextStyle(
                      color: Color(0xff5F738C),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                    contentPadding: EdgeInsets.only(left: 20),
                    // prefixIcon: SizedBox(
                    //   width: 2,
                    // )
                    // focusColor: Color(0xFFE5FFEA),
                    // focusedBorder: InputBorder(borderSide: ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
                size: 30.0,
              ),
              onPressed: () {
                _getProvider(
                  _searchController.text,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _getProvider([String searchText]) async {
    final providers = await Provider.of<ServiceProvider>(context, listen: false)
        .getProvidersList(searchText);
    providers.fold((l) {
      FlushBarNotification.showErrorMessage(
        context: context,
        message: FailureToMessage.mapFailureToMessage(l),
        title: "Error",
      );
    }, (r) => print(r.length));
  }
}

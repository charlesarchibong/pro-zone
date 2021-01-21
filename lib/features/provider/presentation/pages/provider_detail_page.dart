import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prozone_app/core/constants/route_names.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/presentation/providers/service_provider.dart';
import 'package:prozone_app/features/provider/presentation/widgets/custom_button_widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProviderDetailPage extends StatefulWidget {
  final ProviderEntity providerEntity;
  const ProviderDetailPage({
    Key key,
    @required this.providerEntity,
  }) : super(key: key);
  @override
  _ProviderDetailPageState createState() => _ProviderDetailPageState();
}

class _ProviderDetailPageState extends State<ProviderDetailPage> {
  final GlobalKey _menuKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
      child: CustomButtonWidget(
        buttonText: 'Edit Provider',
        onTap: () {
          dynamic state = _menuKey.currentState;
          state.showButtonMenu();
        },
      ),
      key: _menuKey,
      itemBuilder: (_) => <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
          child: const Text('Add Provider Image'),
          value: ADD_PROVIDER_IMAGES_PAGE,
        ),
        new PopupMenuItem<String>(
          child: const Text('Edit Provider Details'),
          value: EDIT_PROVIDER_DETAILS_PAGE,
        ),
        new PopupMenuItem<String>(
          child: const Text('View Provider Images'),
          value: VIEW_PROVIDER_IMAGE_PAGE,
        ),
      ],
      onSelected: (value) {
        Navigator.pushNamed(
          context,
          value,
          arguments: widget.providerEntity,
        );
      },
    );

    return Consumer<ServiceProvider>(
        builder: (context, serviceProvider, child) {
      return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        appBar: AppBar(
          title: Text(
            "${widget.providerEntity.name}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                providerDetailWidget(
                  title: 'Name',
                  text: widget.providerEntity.name,
                ),
                providerDetailWidget(
                  title: 'Description',
                  text: widget.providerEntity.description,
                ),
                providerDetailWidget(
                  title: 'Address',
                  text: widget.providerEntity.address,
                ),
                providerDetailWidget(
                  title: 'State',
                  text: widget.providerEntity.state.name,
                ),
                providerDetailWidget(
                  title: 'Provider Type',
                  text: widget.providerEntity.providerTypeEntity.name,
                ),
                providerDetailWidget(
                  title: 'Active Status',
                  text: widget.providerEntity.activeStatus,
                ),
                Text(
                  'Rating',
                ),
                SizedBox(
                  height: 5,
                ),
                SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 5,
                  rating: widget.providerEntity.rating == null
                      ? 0.0
                      : widget.providerEntity.rating.toDouble(),
                  size: 30.0,
                  isReadOnly: true,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                button,
                SizedBox(
                  height: 40,
                ),
                // buildGridView(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildGridView() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(widget.providerEntity.images.length, (index) {
          String imageUrl = widget.providerEntity.images[index].mediumImage.url;
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.network(
              imageUrl,
              width: 300,
              height: 300,
            ),
          );
        }),
      ),
    );
  }

  Widget providerDetailWidget({String title, String text}) {
    return Padding(
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
            '$text',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '$title',
            style: TextStyle(),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';

class ViewProviderImagesPage extends StatefulWidget {
  final ProviderEntity providerEntity;
  const ViewProviderImagesPage({
    Key key,
    @required this.providerEntity,
  }) : super(key: key);
  @override
  _ViewProviderImagesPageState createState() => _ViewProviderImagesPageState();
}

class _ViewProviderImagesPageState extends State<ViewProviderImagesPage> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            widget.providerEntity.images.length > 0
                ? Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(
                          widget.providerEntity.images.length, (index) {
                        String assetUrl =
                            widget.providerEntity.images[index].mediumImage.url;
                        print(assetUrl);
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.network(
                            assetUrl,
                            width: 300,
                            height: 300,
                          ),
                        );
                      }),
                    ),
                  )
                : Center(
                    child: Text(
                      'No provider image available yet',
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

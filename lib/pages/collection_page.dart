import 'package:flutter/material.dart';
import 'package:ngdemo16/pages/photos_page.dart';

import '../model/collection_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class CollectionPage extends StatefulWidget {
  static const String id = "collection_page";

  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  bool isLoading = false;
  List<Collection> items = [];
  int currentPage = 1;
  ScrollController  scrollcontroller = ScrollController();

  _callPhotosPage(Collection collection) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PhotosPage(
        collection: collection,
      );
    }));
  }

  @override
  void initState() {
    super.initState();

    scrollcontroller.addListener((){
      if(scrollcontroller.position.maxScrollExtent <= scrollcontroller.offset){
        currentPage++;
        LogService.i(currentPage.toString());
        _apiCollectionList();
      }
    });

    _apiCollectionList();
  }

  _apiCollectionList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_COLLECTIONS, Network.paramsCollections(currentPage));
    var result = Network.parseCollections(response!);
    LogService.i(response!);

    setState(() {
      items = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return itemOfCollection(items[index]);
              },
            ),

            isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
          ],
        )
    );
  }

  Widget itemOfCollection(Collection collection) {
    return GestureDetector(
      onTap: () {
        _callPhotosPage(collection);
      },
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Image.network(
                  collection.coverPhoto.urls.small!,
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 2,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [Colors.black54, Colors.black12])),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(collection.title!,
                        style: TextStyle(color: Colors.white, fontSize: 18))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
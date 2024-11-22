import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


import '../model/collection_model.dart';
import '../model/photo_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';
import 'details_page.dart';

class PhotosPage extends StatefulWidget {
  final Collection? collection;

  const PhotosPage({super.key, this.collection});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  bool isLoading = false;
  List<Photo> items = [];
  ScrollController scrollController = ScrollController();
  var currentPage = 1;

  _callDetailsPage(Photo photo) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailsPage(
        photo: photo,
      );
    }));
  }



  @override
  void initState() {
    super.initState();

    scrollController.addListener((){
      if(scrollController.position.maxScrollExtent <= scrollController.offset){
        currentPage++;
        LogService.i(currentPage.toString());
        _apiCollectionPhotos();
      }
    });

    _apiCollectionPhotos();
  }

  _apiCollectionPhotos() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(
        Network.API_COLLECTIONS_PHOTOS.replaceFirst(":id", widget.collection!.id),
        Network.paramsCollectionsPhotos(currentPage));
    LogService.i(response!);
    var result = Network.parseCollectionsPhotos(response);

    setState(() {
      items.addAll(result); // Append new data to the list
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          widget.collection!.title!,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          MasonryGridView.builder(
            controller: scrollController,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: items.length,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            itemBuilder: (context, index) {
              return _itemOfPhoto(items[index], index);
            },
          ),

          isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _itemOfPhoto(Photo photo, int index) {
    return GestureDetector(
      onTap: () {
        _callDetailsPage(photo);
      },
      child: Container(
        height: (index % 5 + 5) * 50.0,
        child: Image.network(
          photo.urls.small,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
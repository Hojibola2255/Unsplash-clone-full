import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ngdemo16/blocs/photos/photos_bloc.dart';
import 'package:ngdemo16/blocs/photos/photos_event.dart';
import 'package:ngdemo16/blocs/photos/photos_state.dart';


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
  late PhotoBloc photoBloc;

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

    photoBloc = BlocProvider.of<PhotoBloc>(context);
    photoBloc.add(PhotosPhotoEvent(widget.collection));

    scrollController.addListener((){
      if(scrollController.position.maxScrollExtent <= scrollController.offset){
        currentPage++;
        LogService.i(currentPage.toString());

      }
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

      body: BlocBuilder<PhotoBloc, PhotosState>(
          builder: (context, state){
            if (state is PhotosSuccesState) {
              ListView.builder(
                controller: ScrollController(),
                itemCount: photoBloc.items.length,
                itemBuilder: (context, index) {
                  return _itemOfPhoto(context, photoBloc.items[index], index);
                },
              );
            }
            if (state is PhotosErrorState) {
              return Center(
                child: Text("state.errorMessage"),
              );
            }
            return Stack(
              children: [
                MasonryGridView.builder(
                  controller: scrollController,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: photoBloc.items.length,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  itemBuilder: (context, index) {
                    return _itemOfPhoto(context, photoBloc.items[index], index);
                  },
                ),

                photoBloc.isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
              ],
            );
          }
      ),
    );
  }

  Widget _itemOfPhoto(BuildContext context, Photo photo,  int index ) {
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


/*Stack(
              children: [
                MasonryGridView.builder(
                  controller: scrollController,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: photoBloc.items.length,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  itemBuilder: (context, index) {
                    return _itemOfPhoto(context, photoBloc.items[index], index);
                  },
                ),

                photoBloc.isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
              ],
            );*/
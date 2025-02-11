import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngdemo16/blocs/collection/collection_bloc.dart';
import 'package:ngdemo16/blocs/collection/collection_event.dart';
import 'package:ngdemo16/blocs/collection/collection_state.dart';
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
  late CollectionBloc collectionBloc;

  int currentPage = 1;
  bool isLoading = false;
  ScrollController scrollcontroller = ScrollController();


  @override
  void initState() {
    super.initState();
    collectionBloc = BlocProvider.of<CollectionBloc>(context);
    collectionBloc.add(CollectionPhotoEvent());


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<CollectionBloc, CollectionState>(
          buildWhen: (previous, current) {
            return current is CollectionSuccesState;
          },
          builder: (context, state) {
            if (state is CollectionSuccesState) {
              ListView.builder(
                controller: ScrollController(),
                itemCount: collectionBloc.items.length,
                itemBuilder: (context, index) {
                  return itemOfCollection(collectionBloc.items[index], index, collectionBloc);
                },
              );
            }
            if (state is CollectionFeilureState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return ListView.builder(
              controller: ScrollController(),
              itemCount: collectionBloc.items.length,
              itemBuilder: (context, index) {
                return itemOfCollection(collectionBloc.items[index], index, collectionBloc);
              },
            );
          }
      ),
    );
  }

  Widget itemOfCollection(Collection collection, int index, CollectionBloc collectionBloc) {
    return GestureDetector(
      onTap: () {
        collectionBloc.callPhotosPage(context, collection);
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
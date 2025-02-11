
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngdemo16/blocs/collection/collection_event.dart';
import 'package:ngdemo16/blocs/collection/collection_state.dart';
import 'package:ngdemo16/blocs/photos/photos_bloc.dart';
import 'package:ngdemo16/model/photo_model.dart';

import '../../model/collection_model.dart';
import '../../pages/photos_page.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState>{

  List<Collection> items = [];
  int currentPage = 1;

  CollectionBloc() : super(CollectionInitialState()){
    on<CollectionPhotoEvent>(_onApiCollectionPhotoEvent);
  }

  Future<void> _onApiCollectionPhotoEvent(
      CollectionPhotoEvent event, Emitter<CollectionState> emit)async{
    emit(CollectionLoadingState());

    var response = await Network.GET(Network.API_COLLECTIONS, Network.paramsCollections(currentPage));
    var result = Network.parseCollections(response!);
    LogService.i(response!);
    items.addAll(result);
    emit(CollectionSuccesState(items));


  }

  callPhotosPage(BuildContext context, Collection collection){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return BlocProvider(
        create: (context) => PhotoBloc(),
        child: PhotosPage(
          collection: collection,
        ),
      );
    }));
  }


}
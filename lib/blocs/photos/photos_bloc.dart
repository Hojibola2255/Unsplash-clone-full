
import 'package:bloc/bloc.dart';
import 'package:ngdemo16/blocs/photos/photos_event.dart';
import 'package:ngdemo16/blocs/photos/photos_state.dart';

import '../../model/photo_model.dart';
import '../../services/http_service.dart';


class PhotoBloc extends Bloc<PhotosEvent, PhotosState>{
  bool isLoading = false;
  List<Photo> items = [];

  PhotoBloc(): super(PhotosInitialState()){
    on<PhotosPhotoEvent>(_onPhotosPhotoEvent);
  }
  Future<void>_onPhotosPhotoEvent(
      PhotosPhotoEvent event, Emitter<PhotosState>emit)async {
    emit(PhotosLoadingState());
    var response = await Network.GET(
        Network.API_COLLECTIONS_PHOTOS.replaceFirst(":id", event.collection!.id.toString()), Network.paramsCollectionsPhotos(1));
    var result = Network.parseCollectionsPhotos(response!);
    items = result;
    emit(PhotosSuccesState(items));
  }
}
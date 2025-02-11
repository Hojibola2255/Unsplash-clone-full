
import '../../model/collection_model.dart';

abstract class PhotosEvent {}

class PhotosPhotoEvent extends PhotosEvent {
  final Collection? collection;

  PhotosPhotoEvent(this.collection);

  @override
  List<Object> get props=> [];
}
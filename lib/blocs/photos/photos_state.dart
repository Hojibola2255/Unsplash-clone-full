import 'package:equatable/equatable.dart';

import '../../model/photo_model.dart';


abstract class PhotosState  extends Equatable {}

class PhotosInitialState extends PhotosState{
  @override
  List<Object?> get props => [];
}
class PhotosLoadingState extends PhotosState{
  @override
  List<Object?> get props => [];
}
class PhotosErrorState extends PhotosState{
  final String errorMessage;

  PhotosErrorState(this.errorMessage);
  @override
  List<Object?> get props => [];
}
class PhotosSuccesState extends PhotosState {
  final List<Photo> items;
  PhotosSuccesState(this.items);

  @override
  List<Object?> get props => [];
}
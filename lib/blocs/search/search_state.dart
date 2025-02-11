
import 'package:equatable/equatable.dart';

import '../../model/photo_model.dart';

abstract class SearchState  extends Equatable {}

class SearchInitialState extends SearchState{
  @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState{
  @override
  List<Object?> get props => [];
}

class SearchErrorState extends SearchState{
  final String errorMessage;

  SearchErrorState(this.errorMessage);
  @override
  List<Object?> get props => [];
}

class SearchSuccesState extends SearchState {
  final List<Photo> items;
  SearchSuccesState(this.items);

  @override
  List<Object?> get props => [];
}
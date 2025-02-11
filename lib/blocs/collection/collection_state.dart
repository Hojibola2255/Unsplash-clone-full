

import 'package:equatable/equatable.dart';

import '../../model/collection_model.dart';

abstract class CollectionState extends Equatable{
  const CollectionState();
}

class CollectionInitialState extends CollectionState{

  @override
  List<Object?> get props => [];
}

class CollectionLoadingState extends CollectionState{

  @override
  List<Object?> get props => [];
}

class CollectionSuccesState extends CollectionState{

  final List<Collection> items;
  CollectionSuccesState(this.items);

  @override
  List<Object?> get props => [];
}

class CollectionFeilureState extends CollectionState{

  final String errorMessage;

  CollectionFeilureState(this.errorMessage);
  @override
  List<Object?> get props => [];
}

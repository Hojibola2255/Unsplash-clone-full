
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends  Equatable{
  const SearchEvent();
}

class SearchPhotosEvent extends SearchEvent {
  @override
  List<Object> get props=> [];
}

class SearchKeyboardEvent extends SearchEvent{

  final String keysearch;
  SearchKeyboardEvent({this.keysearch = "office"});

  @override
  List<Object?> get props => [];
}
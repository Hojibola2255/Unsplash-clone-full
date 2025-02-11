
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{}

class BottonNavEvent extends HomeEvent{

  int currentIndex;

  BottonNavEvent({required this.currentIndex});

  @override
  List<Object?> get props => [];

}

class PageViewEvent extends HomeEvent{

  int currentIndex;

  PageViewEvent({required this.currentIndex});

  @override
  List<Object?> get props => [];

}
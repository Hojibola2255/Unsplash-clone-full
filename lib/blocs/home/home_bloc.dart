
import 'package:bloc/bloc.dart';
import 'package:ngdemo16/blocs/home/home_event.dart';
import 'package:ngdemo16/blocs/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  int currentIndex = 0;

  HomeBloc() : super(CurrentIndexState(currentIndex: 0)){
    on<BottonNavEvent>(_onBottonNavEvent);
    on<PageViewEvent>(_onPageViewEvent);
  }

  Future<void> _onBottonNavEvent(BottonNavEvent event, Emitter<HomeState> emit) async{
  emit(CurrentIndexState(currentIndex: event.currentIndex));
  }

  Future<void> _onPageViewEvent(PageViewEvent event, Emitter<HomeState> emit) async{
    emit(CurrentIndexState(currentIndex: event.currentIndex));
  }

}
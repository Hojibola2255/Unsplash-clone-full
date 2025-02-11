
import 'package:bloc/bloc.dart';
import 'package:ngdemo16/blocs/search/search_event.dart';
import 'package:ngdemo16/blocs/search/search_state.dart';
import 'package:ngdemo16/services/http_service.dart';

import '../../model/photo_model.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState>{
  List<Photo> items = [];
  int currentPage = 1;

  SearchBloc() : super(SearchInitialState()){
    on<SearchPhotosEvent>(_onSearchPhotos);
    on<SearchKeyboardEvent>(_onSearchKeyboardEvent);
  }

  Future<void> _onSearchPhotos(SearchPhotosEvent event, Emitter<SearchState> emit)async{
    emit(SearchLoadingState());
    var response = await Network.GET(
        Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos("search", currentPage));
    if (response != null){
      var result = Network.parseSearchPhotos(response!).results;
      items.addAll(result);
      currentPage ++;
      emit (SearchSuccesState(items));
    }else{
      emit (SearchErrorState("Couldn't fetch photos"));
    }
  }

  Future<void> _onSearchKeyboardEvent(SearchKeyboardEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState()); // Loading holatini yuborish

    final query = event.keysearch.isEmpty ? "office" : event.keysearch;

    try {
      // API chaqiruv
      var response = await Network.GET(
        Network.API_SEARCH_PHOTOS,
        Network.paramsSearchPhotos(query, currentPage),
      );

      if (response == null) {
        emit(SearchErrorState("No data received from API."));
        return;
      }


      var result = Network.parseSearchPhotos(response);
      items.addAll(result.results);

      emit(SearchSuccesState(items));
    } catch (e) {
      // Xato holati
      emit(SearchErrorState("An error occurred: $e"));
    }
  }

}
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ngdemo16/blocs/search/search_bloc.dart';
import 'package:ngdemo16/blocs/search/search_event.dart';
import 'package:ngdemo16/blocs/search/search_state.dart';

import '../model/photo_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  static const String id = "search_page";

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc searchBloc;

  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  _callDetailsPage(Photo photo) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailsPage(
        photo: photo,
      );
    }));
  }

  @override
  void initState() {
    super.initState();

    searchBloc= BlocProvider.of<SearchBloc>(context);
    searchBloc.add(SearchPhotosEvent());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent <= scrollController.offset) {
        searchBloc.currentPage++;
        LogService.i(searchBloc.currentPage.toString());
        searchBloc.add(SearchPhotosEvent());

      }
    });

  }

  //
  // _apiSearchPhotos({String query = "office"}) async {
  //   if (query.isEmpty) {
  //     query = "office";
  //   }
  //
  //   log("_api searchPhoto with query: $query");
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   try {
  //     var response = await Network.GET(
  //         Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos(query, searchBloc.currentPage));
  //
  //     if (response == null) {
  //       LogService.i("Received null response from API.");
  //       return;
  //     }
  //
  //     var result = Network.parseSearchPhotos(response);
  //     LogService.i(response);
  //
  //     setState(() {
  //       searchBloc.items.addAll(result.results);
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     LogService.e("Error occurred while fetching photos: $e");
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }



  // _onSearchChanged(String query) {
  //   setState(() {
  //     searchBloc.items.clear();
  //     searchBloc.currentPage = 1;
  //     _apiSearchPhotos(query: query);
  //   });
  // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                  child: Container(
                    height: 50,
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: searchController,
                          onSubmitted: (query) {
                            searchBloc.currentPage = 1;
                            searchBloc.add(SearchKeyboardEvent(keysearch: query));
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              size: 24,
                              color: Colors.white70,
                            ),
                            hintText: "Search photos, collections, users",
                            hintStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Colors.white38,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          style: TextStyle(
                            color: Colors.white, // matn kiritsa oq ko'rinada
                          ),
                        )

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Text(
                  "Discover",
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              Expanded(
                child: Stack(
                  children: [
                    MasonryGridView.builder(
                      controller: scrollController,
                      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: searchBloc.items.length,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      itemBuilder: (context, index) {
                        return _itemOfPhoto(searchBloc.items[index], index);
                      },
                    ),
                    isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _itemOfPhoto(Photo photo, int index) {
    return GestureDetector(
      onTap: () {
        _callDetailsPage(photo);
      },
      child: Container(
        height: (index % 5 + 5) * 50.0,
        child: Image.network(
          photo.urls.small!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

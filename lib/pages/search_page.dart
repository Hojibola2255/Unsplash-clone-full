import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  bool isLoading = false;
  List<Photo> items = [];
  int currentPage = 1;
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

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent <= scrollController.offset) {
        currentPage++;
        LogService.i(currentPage.toString());
        _apiSearchPhotos();
      }
    });

    _apiSearchPhotos();
  }

  // Updated method to use the search query
  _apiSearchPhotos({String query = "office"}) async {
    if (query.isEmpty) {
      query = "office"; // Default search term if no query is provided
    }

    log("_api searchPhoto with query: $query");
    setState(() {
      isLoading = true;
    });

    try {
      var response = await Network.GET(
          Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos(query, currentPage));

      // Check if response is null or invalid
      if (response == null) {
        LogService.i("Received null response from API.");
        return;
      }

      var result = Network.parseSearchPhotos(response);
      LogService.i(response);

      setState(() {
        items.addAll(result.results);
        isLoading = false;
      });
    } catch (e) {
      LogService.e("Error occurred while fetching photos: $e");
      setState(() {
        isLoading = false;
      });
    }
  }


  // Method to handle search
  _onSearchChanged(String query) {
    setState(() {
      items.clear(); // Clear previous results
      currentPage = 1; // Reset page number
      _apiSearchPhotos(query: query); // Pass the query properly
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
                    onChanged: _onSearchChanged, // Listen to changes in the text field
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
                  itemCount: items.length,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  itemBuilder: (context, index) {
                    return _itemOfPhoto(items[index], index);
                  },
                ),
                isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink(),
              ],
            ),
          )
        ],
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

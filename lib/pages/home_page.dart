import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngdemo16/pages/create_page.dart';
import 'package:ngdemo16/pages/profile_page.dart';
import 'package:ngdemo16/pages/search_page.dart';


import 'collection_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController? _pageController;
  int _currentTap = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _currentTap == 0 // agar uchinchi page ProfilePage bomasa AppBarni korsatadi
            ? AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              "Unsplash",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/unsplashlogo.png',
              width: 40,
              height: 40,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.grid_view_outlined, color: Colors.white),
            )
          ],
        )
            : null, // ProfilePage uchun AppBar ko'rsatilmaydi
        body: PageView(
          controller: _pageController,
          children: [
            CollectionPage(),
            SearchPage(),
            CreatePage(),
            ProfilePage(),
          ],
          onPageChanged: (int index) {
            setState(() {
              _currentTap = index;
            });
          },
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.collections, size: 32),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 32),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box, size: 32),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded, size: 32),
            ),
          ],
          currentIndex: _currentTap,
          activeColor: Colors.white,
          onTap: (int index) {
            setState(() {
              _currentTap = index;
            });
            _pageController!.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          },
        ),
      );
    }

  }


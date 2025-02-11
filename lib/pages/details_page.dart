import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ngdemo16/model/photo_model.dart';
import 'package:path_provider/path_provider.dart';

class DetailsPage extends StatefulWidget {
  final Photo? photo;
  const DetailsPage({super.key, this.photo});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          InteractiveViewer(
            panEnabled: true,
            minScale: 1.0,
            maxScale: 5.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                   height: 550,
                  width: double.infinity,
                  child: Image.network(
                    widget.photo!.urls.full,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 52,
            left: 65,
            child: Text(
              widget.photo!.description ?? "noname",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          Positioned(
            right: 16,
            bottom: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.white, size: 25,),
                    onPressed: () {},
                  ),
                ),

                SizedBox(height: 16),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white, size: 25,),
                    onPressed: () {},
                  ),
                ),

                SizedBox(height: 16),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.download, color: Colors.white, size: 25,),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

}

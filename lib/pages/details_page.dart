import 'package:flutter/material.dart';
import 'package:ngdemo16/model/photo_model.dart';

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
            maxScale: 4.0,
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  widget.photo!.urls.full,
                  fit: BoxFit.cover,
                  height: 550,
                ),
              ),
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
        ],
      ),
    );
  }
}

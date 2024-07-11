import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_hub/Popular.dart';

class Detail extends StatelessWidget {
  final PopularPlaces selectedItem;
  const Detail({required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xFF031F2B);
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Column(
            children:[ Stack(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(48.0), bottomLeft: Radius.circular(48.0)),
                      child: Image.asset(selectedItem.imageUrl, fit: BoxFit.cover,)),
                ),

                Positioned(
                    bottom: 28.0,
                    left: 16.0,
                    child: Text(selectedItem.name,
                      style: TextStyle(color: Colors.white, fontWeight:
                      FontWeight.bold, fontSize: 24),)),

                Positioned(
                    bottom: 16.0,
                    left: 18.0,
                    child: Text(selectedItem.name,
                      style: TextStyle(color: Colors.white, fontSize: 16),)),
                Positioned(
                    bottom: 16.0,
                    right: 48.0,
                    child: Text(selectedItem.rate,
                      style: TextStyle(color: Colors.white, fontSize: 24),)),
                Positioned(
                    bottom: 18.0,
                    right: 16.0,
                    child:Image.asset('assets/images/star.png', width: 24, height: 24,)),
              ],
            ),


            ]),



      ),
    );
  }
}

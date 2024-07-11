import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_hub/Popular.dart';

class Detail extends StatelessWidget {
  final PopularPlaces selectedItem;
  const Detail({required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xFF031F2B);
    Color secColor = Color(0xFF5EDFFF);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: mainColor,
            pinned: true,
            floating: true,
            expandedHeight: 300,
            flexibleSpace:  FlexibleSpaceBar(
              title: Text(selectedItem.name, style: TextStyle(color: Colors.white, fontSize: 16))
              ,background: ClipRRect(borderRadius: BorderRadius.only(bottomRight: Radius.circular(48.0), bottomLeft: Radius.circular(48.0)),
                child: Image.asset(selectedItem.imageUrl, fit: BoxFit.cover,)),
            ),
            
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                if (index == 0) {
                  return SizedBox(height: 32.0);
                } else if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Batafsil',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else if (index == 2) {
                  return SizedBox(height: 16.0);
                } else if (index == 3) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      selectedItem.description,
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                else if (index == 4) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 48.0, top: 36),
                    child: Row(
                      children: [

                      Expanded(
                        flex:3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0), // Adjust as needed
                            border: Border.all(
                              color: secColor, // Change this to your desired color
                              width: 1.0, // Adjust the width as needed
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 8.0,),
                              Image.asset( 'assets/images/location.png', width: 32, height: 32,),
                              SizedBox(width: 8.0,),
                              Text(' Joylashuv', style: TextStyle(color: secColor, fontSize: 18),)
                            ],
                          ),
                        ),
                      ),
                        SizedBox(width: 32,),

                        Expanded(
                          flex:3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0), // Adjust as needed
                              border: Border.all(
                                color: secColor, // Change this to your desired color
                                width: 1.0, // Adjust the width as needed
                              ),
                            ),

                            child: Row(
                              children: [
                                SizedBox(width: 8.0,),
                                Image.asset( 'assets/images/infos.png', width: 32, height: 32,),
                                SizedBox(width: 8.0,),
                                                Text(' Manba', style: TextStyle(color: secColor, fontSize: 18)
                                                ) ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                }else {
                  return SizedBox(height: 32.0);
                }
              },
              childCount: 5, // Adjust based on your number of items
            ),
          ),
        ],




      ),
    );
  }
}

// SizedBox(height: 32.0,),
//
// Padding(
// padding: const EdgeInsets.only(left: 16.0),
// child: Align(
// alignment: Alignment.topLeft,
// child: Text('Batafsil', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)),
// ),
// SizedBox(height: 16.0,),
//
// Padding(
// padding: const EdgeInsets.only(left: 16.0, right: 16.0),
// child: Text(selectedItem.description,
// style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
// ),
// SizedBox(height: 32.0,),


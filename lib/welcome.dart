
import 'package:flutter/material.dart';
import 'package:travel_hub/home.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {

    Color mainColor = Color(0xFF031F2B);
    Color secColor = Color(0xFF5EDFFF);
    return Scaffold(
      backgroundColor: mainColor,
      resizeToAvoidBottomInset: false,
      body: Column(
          children: [
            SizedBox(height: 150,),

            Image.asset('assets/images/welcome.png',width: double.infinity, height: 200, ),
            SizedBox(height: 16,),

            Text('Oddiy hayotdan qoching', style: TextStyle(color: Colors.white, fontSize: 32),),
            SizedBox(height: 12,),
            Text('Atrofingizdagi ajoyib tajribalarni kashf eting', style: TextStyle(color: Colors.white, fontSize: 16, height: 0),),
            Text('va sizni qiziqarli yashashga mabur qiling!', style: TextStyle(color: Colors.white, fontSize: 16, height: 0),),
        Spacer(),

        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(

            onPressed: () {

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
           ),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: secColor,
              ),
              child: Container(
                constraints: BoxConstraints(minWidth: 88.0, minHeight: 48.0),
                alignment: Alignment.center,
                child: Text(
                  'Boshladik',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),

            SizedBox(height: 72)
          ],
        ),

    );
  }
}

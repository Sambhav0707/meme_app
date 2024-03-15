import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:memes_by_sam/view/nav_drawer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class about_page extends StatelessWidget {
  const about_page({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),

        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.grey],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        centerTitle: true,

      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Memes by Sam',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                child: Text(
                  'Description: Your go-to app for hilarious memes! Browse, and enjoy a daily dose of laughter.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            // Center(
            //   child: Link(
            //     uri: Uri.parse('https://www.linkedin.com/in/sambhav-dalal-587bbb272/'),
            //     builder: (context, followLink) => GestureDetector(
            //       onTap: followLink,
            //       child: const Text(
            //         'LINKDIN PROFILE',
            //         style: TextStyle(
            //           color: Colors.purple,
            //           fontSize: 20,
            //           fontWeight: FontWeight.w800,
            //           decoration: TextDecoration.underline,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Center(
              child: GestureDetector(
                onTap:()=> launchUrlString("https://www.linkedin.com/in/sambhav-dalal-587bbb272/") ,
                child: const Text('LINKEDIN PROFILE',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.underline,

                ),
                ),
              ) ,
            ),



            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Center(
                child: Text(
                  'sambhavdalal1@gmail.com ',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            // Center(
            //   child: Link(
            //     uri: Uri.parse('https://github.com/Sambhav0707'),
            //     builder: (context, followLink) => GestureDetector(
            //       onTap: followLink,
            //       child: const Text(
            //         'GITHUB PROFILE',
            //         style: TextStyle(
            //           color: Colors.purple,
            //           fontSize: 20,
            //           fontWeight: FontWeight.w800,
            //           decoration: TextDecoration.underline,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Center(
              child: GestureDetector(
                onTap:()=> launchUrlString("https://github.com/Sambhav0707") ,
                child: const Text('GITHUB PROFILE',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline,

                  ),
                ),
              ) ,
            ),




            const SizedBox(
              height: 80,
            ),
            const Center(
              child: Text(
                'PHONE NO. :-  6350121697 ',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),



          ],
        ),
      ),
      drawer: const NavDrawer(selected: DrawerSelection.about),
    backgroundColor: const Color(0xFFE1BEE7),
    );
  }
}





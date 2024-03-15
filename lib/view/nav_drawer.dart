import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memes_by_sam/view/about_page.dart';
import 'package:memes_by_sam/view/home_page.dart';
import 'package:memes_by_sam/view/meme_creator.dart';

enum DrawerSelection {home,creator,about}

class NavDrawer extends StatefulWidget {
  final  DrawerSelection selected;
  const NavDrawer({super.key , required this.selected});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [

          const SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(gradient:LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors:[
                  Colors.pinkAccent,
                  Colors.grey,
                ],
              ),
              ),
              child: Center(child:
              Text("MENU",style:
              TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.w800),
              )
              ),
            ),
          ),
          ListTile(
            selected: widget.selected==DrawerSelection.home,
            selectedColor: Colors.indigo,
            selectedTileColor: Colors.indigo.shade50,

            title: const Text("HOME ", style: TextStyle(fontWeight: FontWeight.bold),),
            leading:  CircleAvatar( backgroundColor: Colors.transparent, radius: 15, child: SvgPicture.asset("images/home.svg"),),
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=> const HomePage()));
            },
            ),
          ListTile(
            selected: widget.selected==DrawerSelection.creator,
            selectedColor: Colors.indigo,
            selectedTileColor: Colors.indigo.shade50,


            title: const Text("MEME CREATION ", style: TextStyle(fontWeight: FontWeight.bold),),
            leading:  CircleAvatar( backgroundColor: Colors.transparent, radius: 15, child: SvgPicture.asset("images/memeCreation.svg"),),
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=> const MemeCreator()));
            },
          ),
          ListTile(
            selected: widget.selected==DrawerSelection.about,
            selectedColor: Colors.indigo,
            selectedTileColor: Colors.indigo.shade50,


            title: const Text("ABOUT ", style: TextStyle(fontWeight: FontWeight.bold),),
            leading:  CircleAvatar( backgroundColor: Colors.transparent, radius: 15, child: SvgPicture.asset("images/information.svg"),),
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=> const about_page()));
            },
          ),

        ],


      ),

    );
  }
}


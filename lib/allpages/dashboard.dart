import 'package:flutter/material.dart';
import 'package:matrimony/allpages/about_us_page.dart';
import 'package:matrimony/allpages/add_user.dart';
import 'package:matrimony/allpages/favourit.dart';
import 'package:matrimony/allpages/userList.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedBox = 0;
  List<Widget> pages = [AddUser(),Userlist(),Favourit(),AboutUsPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedBox],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(13, 24, 33, 1),
          selectedItemColor: Color.fromRGBO(240,244, 239, 1),
          unselectedItemColor: Color.fromRGBO(180, 205, 237, 1),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        onTap: (index) => {
          setState(() {
            selectedBox = index;
          })
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar_rounded),
            label: "add user",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check_rounded),
              label: "user list"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "favourit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_sharp),
            label: "about us",
          ),
        ],
        currentIndex: selectedBox,
        showUnselectedLabels: true,
      ),
    );
  }
}

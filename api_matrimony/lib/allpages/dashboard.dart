import 'package:flutter/material.dart';
import 'package:matrimonyapi/allpages/userList.dart';


import 'about_us_page.dart';
import 'all_list.dart';
import 'edit_button.dart';
import 'favourit.dart';
class Dashboard extends StatefulWidget {
  int? selected;
  Dashboard({super.key,this.selected});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedBox=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedBox = widget.selected??0;
  }
//AddUser(userDataList: AllList.userDataList,), 00  index ee inpages
  //EditButton(userDataList: AllList.userDataList,),
  List<Widget> pages = [Userlist(userDataList: AllList.userDataList,),Favourit(userDataList: AllList.userDataList,),AboutUsPage()];
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.edit_calendar_rounded),
          //   label: "add user",
          // ),
          BottomNavigationBarItem(
              icon: Tooltip(message: "This is the collection of all the users",child: Icon(Icons.playlist_add_check_rounded)),
              label: "user list"),
          BottomNavigationBarItem(
            icon: Tooltip(message: "This is the collection of all the favourit users",child: Icon(Icons.favorite)),
            label: "favourit",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.edit_calendar_rounded),
          //   label: "Edit Users",
          // ),
          BottomNavigationBarItem(
            icon: Tooltip(message: "This is the Inforamtion about the devlopers",child: Icon(Icons.account_box_sharp)),
            label: "about us",
          ),
        ],
        currentIndex: selectedBox,
        showUnselectedLabels: true,
      ),
    );
  }
}

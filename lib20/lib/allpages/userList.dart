import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';

import '../database/database.dart';
import 'add_user.dart';
import 'edit.dart';

class Userlist extends StatefulWidget {
  // final MyDatabase databse = MyDatabase(); // Initialize database
  List<Map<String, dynamic>> userDataList;

  Userlist({required this.userDataList, Key? key}) : super(key: key);

  @override
  State<Userlist> createState() => _Userlist();
}

class _Userlist extends State<Userlist> {
  String searchQuery = '';
  String sortAttribute = 'userName';
  bool isAscending = true;
  List<Map<String, dynamic>> userDataList = [];

  // MyDatabase databse = MyDatabase();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final String apiUrl = "https://66f274a771c84d80587551d2.mockapi.io/users";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(
          json.decode(response.body),
        );

        if (mounted) {
          setState(() {
            widget.userDataList = users;
          });
        }
      } else {
        print("Failed to load users: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching users: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = widget.userDataList
        .where((user) =>
            user['userName'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    filteredList.sort((a, b) {
      if (isAscending) {
        return (a[sortAttribute] ?? '').compareTo(b[sortAttribute] ?? '');
      } else {
        return (b[sortAttribute] ?? '').compareTo(a[sortAttribute] ?? '');
      }
    });

    return Scaffold(
      floatingActionButton: Tooltip(
        message: "This is used to add a user",
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddUser(
                  userDataList: filteredList,
                ),
              ),
            );
          },
          backgroundColor:Color.fromRGBO(54, 84, 117, 1),
          child: Icon(Icons.add,color: Color.fromRGBO(240,255, 239, 1),),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(13, 24, 33, 1),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Ready to Wed?",
                    style: GoogleFonts.b612(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Search Bar
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search by name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return constraints.maxWidth < 400
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButton<String>(
                                dropdownColor: Colors.black,
                                value: sortAttribute,
                                items: [
                                  DropdownMenuItem(
                                    value: 'userName',
                                    child: Text(
                                      'Sort by Name',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'age',
                                    child: Text(
                                      'Sort by Age',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'gender',
                                    child: Text(
                                      'Sort by Gender',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    sortAttribute = value!;
                                  });
                                },
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Ascending:',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Switch(
                                    value: isAscending,
                                    onChanged: (value) {
                                      setState(() {
                                        isAscending = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton<String>(
                                dropdownColor: Colors.black,
                                value: sortAttribute,
                                items: [
                                  DropdownMenuItem(
                                    value: 'userName',
                                    child: Text(
                                      'Sort by Name',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'age',
                                    child: Text(
                                      'Sort by Age',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'gender',
                                    child: Text(
                                      'Sort by Gender',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    sortAttribute = value!;
                                  });
                                },
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Ascending:',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Switch(
                                    value: isAscending,
                                    onChanged: (value) {
                                      setState(() {
                                        isAscending = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: const Color.fromRGBO(13, 24, 33, 1),
                ),
                 ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: const Color(0xFF1E2A38),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              filteredList[index]["userName"] ??
                                                  "N/A",
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Divider(
                                              color: Colors.grey[600],
                                              thickness: 1),
                                          const SizedBox(height: 10),

                                          Text(
                                            filteredList[index]
                                                    ["extraDetails"] ??
                                                "My name is ${widget.userDataList[index]["fullName"]}\n My age is ${widget.userDataList[index]["age"]}\n My email is ${widget.userDataList[index]["email"]}\n My city is ${widget.userDataList[index]["city"]}\n ",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(height: 10),
                                          Divider(
                                              color: Colors.grey[600],
                                              thickness: 1),
                                          // Favorite Status
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ListTile(
                                                  leading: Icon(Icons.favorite,
                                                      color: Colors.redAccent),
                                                  title: Text(
                                                    "${filteredList[index]["isFav"] == 0 ? 'no' : 'yes'}",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons
                                                          .mobile_screen_share_outlined,
                                                      color: Colors.blueAccent),
                                                  title: Text(
                                                    "${filteredList[index]["mobileNo"]}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.accessibility,
                                                      color: Colors.cyan),
                                                  title: Text(
                                                    "${filteredList[index]["gender"]}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.email,
                                                      color: Colors.purple),
                                                  title: Text(
                                                    "${filteredList[index]["email"] ?? "N/A"}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                      Icons.location_city,
                                                      color: Colors.yellow),
                                                  title: Text(
                                                    "${filteredList[index]["city"] ?? "N/A"}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.cake,
                                                      color: Colors.green),
                                                  title: Text(
                                                    "${filteredList[index]["age"] ?? "N/A"}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          // Close Button
                                          Center(
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueAccent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text("Close",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Center(
                                  child: Card(
                                    color: const Color(0xFF1E2A38),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 5,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    filteredList[index]
                                                                ["gender"] ==
                                                            "Male"
                                                        ? Icons.male
                                                        : Icons.female,
                                                    color: filteredList[index]
                                                                ["gender"] ==
                                                            "Male"
                                                        ? Colors.blue
                                                        : Colors.pink,
                                                    size: 24,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    filteredList[index]
                                                            ["userName"] ??
                                                        "N/A",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                             Row(
                                               mainAxisSize: MainAxisSize.min,
                                               children: [
                                                 IconButton(
                                                   onPressed: () async {
                                                     int is_fav = filteredList[index]["isFav"];
                                                     // await widget.databse.updateIsFav(filteredList[index], 1-is_fav);
                                                     // _loadUserData();
                                                     await _updateUser(filteredList[index]["id"],
                                                         {"isFav":1-is_fav});

                                                     setState(() {});
                                                     _loadUserData();
                                                   },
                                                   icon: Icon((filteredList[index]["isFav"] ?? 0) == 0 ? Icons.favorite_border : Icons.favorite, color: Colors.redAccent, size: 24,),),
                                                 PopupMenuButton<String>(
                                                   icon: Icon(Icons.more_vert, color: Colors.blueAccent),
                                                   color: Color.fromRGBO(54, 84, 117, 1),
                                                   onSelected: (value) async {
                                                     if (value == "edit") {
                                                       Navigator.push(
                                                         context,
                                                         MaterialPageRoute(
                                                           builder: (context) => AddUser(
                                                             userDataList: filteredList,
                                                             editIndex: index,
                                                           ),
                                                         ),
                                                       ).then((updatedData) async {
                                                         if (updatedData != null) {
                                                           await _updateUser(filteredList[index]["id"], updatedData);
                                                           // updatedData["id"] = filteredList[index]["id"];
                                                           // print(updatedData);
                                                           // await widget.databse.updateUser(updatedData);
                                                           _loadUserData();
                                                           setState(() {});
                                                         }
                                                       });
                                                     } else if (value == "delete") {
                                                       bool? confirmDelete = await showDialog(
                                                         context: context,
                                                         builder: (context) => AlertDialog(
                                                           title: Text("Confirm Deletion"),
                                                           content: Text("Are you sure you want to delete ${filteredList[index]["userName"]}?"),
                                                           actions: [
                                                             TextButton(
                                                               onPressed: () => Navigator.of(context).pop(false),
                                                               child: Text("Cancel"),
                                                             ),
                                                             TextButton(
                                                               onPressed: () async {
                                                                 // await widget.databse.deleteUser(filteredList[index]["id"]);
                                                                 // Navigator.of(context).pop(true);
                                                                 _deleteUser(filteredList[index]["id"]);
                                                                 Navigator.pop(context);
                                                                 setState(() {});
                                                                 _loadUserData();
                                                               },
                                                               child: Text("Delete", style: TextStyle(color: Colors.red)),
                                                             ),
                                                           ],
                                                         ),
                                                       );
                                                     }
                                                   },
                                                   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                                     PopupMenuItem<String>(
                                                       value: "edit",
                                                       child: ListTile(
                                                         leading: Icon(Icons.edit, color: Colors.blueAccent),
                                                         title: Text(
                                                           "Edit",
                                                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                         ),
                                                       ),
                                                     ),
                                                     PopupMenuItem<String>(
                                                       value: "delete",
                                                       child: ListTile(
                                                         leading: Icon(Icons.delete, color: Colors.red),
                                                         title: Text(
                                                           "Delete",
                                                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 )
                                               ],
                                             ),

                                              // SpeedDial(
                                              //   icon: Icons.more_vert,
                                              //   foregroundColor: Colors.white,
                                              //   backgroundColor: Color.fromRGBO(54, 84, 120, 1), // Set your preferred color
                                              //   elevation: 0, // Reduce shadow
                                              //   buttonSize: Size(45, 45), // Reduce circle size slightly
                                              //   childrenButtonSize: Size(40, 40), // Reduce child button size
                                              //   spaceBetweenChildren: 6, // Adjust spacing
                                              //   overlayColor: Colors.transparent, // Prevents background light effect
                                              //   overlayOpacity: 0.0, // Completely disables dimming
                                              //   children: [
                                              //     // Favorite button
                                              //     SpeedDialChild(
                                              //       child: Icon(
                                              //         (filteredList[index]["isFav"] ?? 0) == 0
                                              //             ? Icons.favorite_border
                                              //             : Icons.favorite,
                                              //         color: Colors.redAccent,
                                              //       ),
                                              //       // label: "Favorite",
                                              //       // labelBackgroundColor: Colors.white, // Prevents background glow
                                              //       onTap: () async {
                                              //         int is_fav = filteredList[index]["isFav"];
                                              //         await widget.databse.updateIsFav(filteredList[index], 1 - is_fav);
                                              //         _loadUserData();
                                              //       },
                                              //     ),
                                              //     // Edit button
                                              //     SpeedDialChild(
                                              //       child: Icon(Icons.edit, color: Colors.blueAccent),
                                              //       // label: "Edit",
                                              //       //labelBackgroundColor: Colors.white,
                                              //       onTap: () {
                                              //         Navigator.push(
                                              //           context,
                                              //           MaterialPageRoute(
                                              //             builder: (context) => AddUser(
                                              //               userDataList: filteredList,
                                              //               editIndex: index, // Passing index for editing
                                              //             ),
                                              //           ),
                                              //         ).then((updatedData) async {
                                              //           if (updatedData != null) {
                                              //             updatedData["id"] = filteredList[index]["id"];
                                              //             await widget.databse.updateUser(updatedData);
                                              //             _loadUserData();
                                              //           }
                                              //         });
                                              //       },
                                              //     ),
                                              //     // Delete button
                                              //     SpeedDialChild(
                                              //       child: Icon(Icons.delete, color: Colors.red),
                                              //       // label: "Delete",
                                              //       // labelBackgroundColor: Colors.white,
                                              //       onTap: () async {
                                              //         bool? confirmDelete = await showDialog(
                                              //           context: context,
                                              //           builder: (context) => AlertDialog(
                                              //             title: Text("Confirm Deletion"),
                                              //             content: Text("Are you sure you want to delete ${filteredList[index]["userName"]}?"),
                                              //             actions: [
                                              //               TextButton(
                                              //                 onPressed: () => Navigator.of(context).pop(false),
                                              //                 child: Text("Cancel"),
                                              //               ),
                                              //               TextButton(
                                              //                 onPressed: () async {
                                              //                   await widget.databse.deleteUser(filteredList[index]["id"]);
                                              //                   Navigator.of(context).pop(true);
                                              //                   _loadUserData();
                                              //                 },
                                              //                 child: Text("Delete", style: TextStyle(color: Colors.red)),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         );
                                              //       },
                                              //     ),
                                              //   ],
                                              // ),
                                              //           Row(
                                    //             children: [
                                    //               //for heart
                                    //               IconButton(
                                    //                 onPressed: () async {
                                    //                 int is_fav = filteredList[index]["isFav"];
                                    //                 await widget.databse.updateIsFav(filteredList[index], 1-is_fav);
                                    //                 _loadUserData();
                                    //                 },
                                    //                 icon: Icon((filteredList[index]["isFav"] ?? 0) == 0 ? Icons.favorite_border : Icons.favorite, color: Colors.redAccent, size: 24,),),
                                    //               // for edit
                                    //               IconButton(
                                    //           icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) => AddUser(
                                    //           userDataList: filteredList,
                                    //           editIndex: index, // Passing the index for editing
                                    //         ),
                                    //       ),
                                    //     ).then((updatedData) async {
                                    //       if (updatedData != null) {
                                    //         updatedData["id"] = filteredList[index]["id"];
                                    //         print(updatedData);
                                    //         await widget.databse.updateUser(updatedData);
                                    //
                                    //         _loadUserData();  // Refresh the user list after updating
                                    //       }
                                    //     });
                                    //   },
                                    // ),
                                    //               // for delete
                                    //           IconButton(
                                    //                 onPressed: () async {
                                    //                   bool? confirmDelete =
                                    //                       await showDialog(
                                    //                     context: context,
                                    //                     builder: (context) =>
                                    //                         AlertDialog(
                                    //                       title: Text(
                                    //                           "Confirm Deletion"),
                                    //                       content: Text(
                                    //                           "Are you sure you want to delete ${filteredList[index]["userName"]}?"),
                                    //                       actions: [
                                    //                         TextButton(
                                    //                           onPressed: () =>
                                    //                               Navigator.of(
                                    //                                       context)
                                    //                                   .pop(
                                    //                                       false),
                                    //                           child: Text(
                                    //                               "Cancel"),
                                    //                         ),
                                    //                         TextButton(
                                    //                           onPressed:
                                    //                               () async {
                                    //                             await widget
                                    //                                 .databse
                                    //                                 .deleteUser(
                                    //                                     filteredList[index]
                                    //                                         [
                                    //                                         "id"]);
                                    //                             Navigator.of(
                                    //                                     context)
                                    //                                 .pop(
                                    //                                     true); // Close dialog
                                    //
                                    //                             _loadUserData(); // Reload user data after deletion
                                    //                           },
                                    //                           child: Text(
                                    //                               "Delete",
                                    //                               style: TextStyle(
                                    //                                   color: Colors
                                    //                                       .red)),
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                   );
                                    //                 },
                                    //                 icon: Icon(Icons.delete,
                                    //                     color: Colors.red),
                                    //               ),
                                    //             ],
                                    //           ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.location_on,
                                                        color: Colors.yellow,
                                                        size: 18),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "${filteredList[index]["city"] ?? "N/A"}",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.call,
                                                        color: Colors.blue,
                                                        size: 18),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "${filteredList[index]["mobileNo"] ?? "N/A"}",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: filteredList.length,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateUser(String userId, Map<String, dynamic> updatedData) async {
    final String apiUrl = "https://66f274a771c84d80587551d2.mockapi.io/users/$userId";

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        print("User updated successfully!");

        // Fetch the updated list from API and update UI
        _loadUserData();
      } else {
        print("Failed to update user: ${response.statusCode}");
      }
    } catch (error) {
      print("Error updating user: $error");
    }
  }

  Future<void> _deleteUser(String userId) async {
    final String apiUrl = "https://66f274a771c84d80587551d2.mockapi.io/users/$userId";

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print("User deleted successfully!");

        // Fetch the updated list from API
        _loadUserData();
      } else {
        print("Failed to delete user: ${response.statusCode}");
      }
    } catch (error) {
      print("Error deleting user: $error");
    }
  }
}

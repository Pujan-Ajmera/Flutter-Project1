import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../database/database.dart';
import 'edit.dart';

class Userlist extends StatefulWidget {
  final MyDatabase databse = MyDatabase(); // Initialize database
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
    List<Map<String, dynamic>> users = await widget.databse.selectAllUser();
    setState(() {
      widget.userDataList = users;
    });
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
                FutureBuilder<List<Map<String, dynamic>>>(
                    future: widget.databse.selectAllUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No users available"));
                      }
                      return ListView.builder(
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
                                                children: [
                                                  // IconButton(
                                                  //   icon: Icon(
                                                  //     (filteredList[index][
                                                  //                     "isFav"] ??
                                                  //                 0) ==
                                                  //             0
                                                  //         ? Icons
                                                  //             .favorite_border
                                                  //         : Icons.favorite,
                                                  //     color: Colors.redAccent,
                                                  //     size: 24,
                                                  //   ),
                                                  //   onPressed: () async {
                                                  //     int is_fav = snapshot.data![index]["isFav"];
                                                  //     await widget.databse.updateIsFav(snapshot.data![index], 1-is_fav);
                                                  //     setState(() {
                                                  //
                                                  //       // filteredList[index]["isFav"] =(filteredList[index]["isFav"] ??0) ==0? 1: 0;
                                                  //     });
                                                  //   },
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.location_city,
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
                                                    Icon(Icons.email,
                                                        color: Colors.green,
                                                        size: 18),
                                                    SizedBox(width: 5),
                                                    Expanded(
                                                      // Wrap in Expanded to prevent overflow
                                                      child: Text(
                                                        "${filteredList[index]["email"] ?? "N/A"}",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.calendar_today,
                                                        color: Colors.blue,
                                                        size: 18),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "${filteredList[index]["age"] ?? "N/A"}",
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
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

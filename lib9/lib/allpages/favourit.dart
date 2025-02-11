import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony/database/database.dart';

class Favourit extends StatefulWidget {
  List<Map<String, dynamic>> userDataList;

  Favourit({required this.userDataList});

  @override
  State<Favourit> createState() => _Favourit();
}

class _Favourit extends State<Favourit> {
  MyDatabase databse = MyDatabase();
  List<Map<String, dynamic>>? userDataList;

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    List<Map<String, dynamic>> allUsers = await databse.selectAllUser();
    setState(() {
      userDataList = allUsers.where((item) => (item["isFav"] ?? 0) == 1).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Loved Ones",
            style: GoogleFonts.b612(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(13, 24, 33, 1),
      ),
      body: userDataList == null || userDataList!.isEmpty
          ? Center(
              child: Text(
                "No favorite profiles found!",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : Stack(
              children: [
                Container(color: const Color.fromRGBO(13, 24, 33, 1)),
                 ListView.builder(
                        itemCount: userDataList!.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(userDataList![index]["userName"]),
                            confirmDismiss: (direction) async {
                              return await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Confirm Deletion"),
                                  content: Text(
                                      "Are you sure you want to delete ${userDataList![index]["userName"]}?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text("Delete",
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onDismissed: (direction) async {
                              final deletedItem = userDataList![index]; // Store the deleted item
                              final deletedIndex = index;
                              int is_fav = userDataList![index]["isFav"];
                              await databse.updateIsFav(userDataList![index],1-is_fav);
                              setState(() {

                              });

                              // Show a snackbar with an undo action
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${deletedItem["userName"]} dismissed'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      setState(() {
                                        // userDataList!.insert(deletedIndex, deletedItem);
                                        // userDataList![deletedIndex]["isFav"] = 1 - (userDataList![deletedIndex]["isFav"] ?? 0);
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                            child: GestureDetector(
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
                                                userDataList![index]["userName"] ?? "N/A",
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
                                              userDataList![index]["extraDetails"] ??
                                                  "My name is ${userDataList![index]["fullName"]}\n My age is ${userDataList![index]["age"]}\n My email is ${userDataList![index]["email"]}\n My city is ${userDataList![index]["city"]}\n ",
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ListTile(
                                                    leading: Icon(
                                                        Icons.favorite,
                                                        color:
                                                            Colors.redAccent),
                                                    title: Text(
                                                      "Favorite: ${(userDataList![index]["isFav"] ?? 0) == 1 ? "Yes" : "No"}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                        Icons
                                                            .mobile_screen_share_outlined,
                                                        color:
                                                            Colors.blueAccent),
                                                    title: Text(
                                                      "Mo.: ${userDataList![index]["mobileNo"]}",
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
                                                      "Gender: ${userDataList![index]["gender"]}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.email,
                                                        color: Colors.purple),
                                                    title: Text(
                                                      "Email: ${userDataList![index]["email"] ?? "N/A"}",
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
                                                      "City: ${userDataList![index]["city"] ?? "N/A"}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.cake,
                                                        color: Colors.green),
                                                    title: Text(
                                                      "Age: ${userDataList![index]["age"] ?? "N/A"}",
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
                                                        BorderRadius.circular(
                                                            10),
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
                                            // Row for Name and Gender Icon
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    // Gender Icon (based on gender)
                                                    Icon(
                                                      userDataList![index]["gender"] == "Male" ? Icons.male : Icons.female,
                                                      color: userDataList![index]["gender"] == "Male" ? Colors.blue : Colors.pink,
                                                      size: 24,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    // Username
                                                    Text(
                                                      userDataList![index]["userName"] ?? "N/A",
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Heart Icon for Toggling Favorite
                                                IconButton(
                                                  icon: Icon(
                                                    (userDataList![index]["isFav"] ?? 0) == 1
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: Colors.redAccent,
                                                    size: 24,
                                                  ),
                                                  onPressed: () async {
                                                    bool? confirmAction =
                                                        await showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                            "Confirm Action"),
                                                        content: Text(
                                                          (userDataList![index][
                                                                          "isFav"] ??
                                                                      0) ==
                                                                  1
                                                              ? "Remove ${userDataList![index]["userName"]} from favorites?"
                                                              : "Add ${userDataList![index]["userName"]} to favorites?",
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false),
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true),
                                                            child: Text(
                                                              (userDataList![index]["isFav"] ?? 0) == 1
                                                                  ? "Remove"
                                                                  : "Add",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );

                                                    if (confirmAction == true) {
                                                      final removedUser =
                                                      userDataList![index]; // Store for undo
                                                      final removedIndex =
                                                          index;
                                                      var i_d = userDataList![index]["id"];
                                                      await databse.updateIsFav(userDataList![index], 0);
                                                      await fetchFavorites();
                                                      setState(() {
                                                        // Toggle favorite using integer logic
                                                        // userDataList![index]
                                                        //         ["isFav"] =
                                                        //     1 -
                                                        //         (userDataList![
                                                        //                     index]
                                                        //                 [
                                                        //                 "isFav"] ??
                                                        //             0);
                                                        // if ((userDataList![
                                                        //                 index]
                                                        //             ["isFav"] ??
                                                        //         0) ==
                                                        //     0) {
                                                        //   userDataList!
                                                        //       .removeAt(index);
                                                        // }
                                                      });

                                                      // Show a snackbar with an undo option
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            (userDataList![index]["isFav"] ?? 0) ==
                                                                    1
                                                                ? '${removedUser["userName"]} added to favorites'
                                                                : '${removedUser["userName"]} removed',
                                                          ),
                                                          action:
                                                              SnackBarAction(
                                                            label: 'Undo',
                                                            onPressed: () {
                                                              setState(() {
                                                                // userDataList!.insert(
                                                                //     removedIndex,
                                                                //     removedUser);
                                                                // userDataList![
                                                                //         removedIndex]
                                                                //     [
                                                                //     "isFav"] = 1;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            // City, Email, Age row
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
                                                        "${userDataList![index]["city"] ?? "N/A"}",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
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
                                                        child: Text(
                                                          "${userDataList![index]["email"] ?? "N/A"}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
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
                                                        "${userDataList![index]["age"] ?? "N/A"}",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
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
                            ),
                          );
                        },
                      ),
              ],
            ),
    );
  }
}

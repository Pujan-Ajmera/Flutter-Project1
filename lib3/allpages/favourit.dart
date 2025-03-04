import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Favourit extends StatefulWidget {
  List<Map<String, dynamic>> userDataList;
  Favourit({required this.userDataList});

  @override
  State<Favourit> createState() => _Favourit();
}

class _Favourit extends State<Favourit> {
  List<Map<String, dynamic>>? userDataList;

  @override
  void initState() {
    super.initState();
    // Filter the favorite users here
    userDataList = widget.userDataList.where((item) => item["isFav"] == true).toList();
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
                onDismissed: (direction) {
                  setState(() {
                    userDataList![index]["isFav"] = !userDataList![index]["isFav"];
                    userDataList!.removeAt(index);

                  });

                  // Then show a snackbar.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('${index} dismissed')));
                },
                child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: const Color(0xFF1E2A38),
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      widget.userDataList[index]["userName"] ??
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
                                      color: Colors.grey[600], thickness: 1),
                                  const SizedBox(height: 10),

                                  Text(
                                    widget.userDataList[index]["extraDetails"] ??
                                        "My name is ${widget.userDataList[index]["fullName"]}\n My age is ${widget.userDataList[index]["age"]}\n My email is ${widget.userDataList[index]["email"]}\n My city is ${widget.userDataList[index]["city"]}\n ",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  Divider(color: Colors.grey[600], thickness: 1),
                                  // Favorite Status
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.favorite, color: Colors.redAccent),
                                          title: Text(
                                            "Favorite: ${widget.userDataList[index]["isFav"] ? "Yes" : "No"}",
                                            style: TextStyle(color: Colors.white, fontSize: 14),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.mobile_screen_share_outlined, color: Colors.blueAccent),
                                          title: Text(
                                            "Mo.: ${widget.userDataList[index]["mobileNo"]}",
                                            style: TextStyle(color: Colors.white, fontSize: 14),
                                          ),
                                        ),

                                        ListTile(
                                          leading: Icon(Icons.accessibility, color: Colors.cyan),
                                          title: Text(
                                            "Gender: ${widget.userDataList[index]["gender"]}",
                                            style: TextStyle(color: Colors.white, fontSize: 14),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email, color: Colors.purple),
                                          title: Text(
                                            "Email: ${widget.userDataList[index]["email"] ?? "N/A"}",
                                            style: TextStyle(color: Colors.white, fontSize: 14),
                                          ),
                                        ),

                                        ListTile(
                                          leading: Icon(Icons.location_city, color: Colors.yellow),
                                          title: Text(
                                            "City: ${widget.userDataList[index]["city"] ?? "N/A"}",
                                            style: TextStyle(color: Colors.white, fontSize: 14),
                                          ),
                                        ),

                                        ListTile(
                                          leading: Icon(Icons.cake, color: Colors.green),
                                          title: Text(
                                            "Age: ${widget.userDataList[index]["age"] ?? "N/A"}",
                                            style: TextStyle(color: Colors.white, fontSize: 14),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // Close Button
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text("Close",
                                          style:
                                          TextStyle(color: Colors.white)),
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
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row for Name and Gender Icon
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items on both sides
                                  children: [
                                    Row(
                                      children: [
                                        // Gender Icon (based on gender)
                                        Icon(
                                          userDataList![index]["gender"] == "Male" ? Icons.male : Icons.female,
                                          color: userDataList![index]["gender"] == "Male" ? Colors.blue : Colors.pink,
                                          size: 24,
                                        ),
                                        const SizedBox(width: 8), // Space between gender icon and name
                                        // Username
                                        Text(
                                          userDataList![index]["userName"] ?? "N/A",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Heart Icon for Toggling Favorite (on the opposite side)
                                    IconButton(
                                      icon: Icon(
                                        userDataList![index]["isFav"] ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.redAccent,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          userDataList![index]["isFav"] = !userDataList![index]["isFav"];
                                          if (!userDataList![index]["isFav"]) {
                                            userDataList!.removeAt(index);  // Remove the user if they are no longer a favorite
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                )
                                ,
                                const SizedBox(height: 10),
                                // City, Email, Date of Birth in the same row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_city, color: Colors.yellow, size: 18),
                                          SizedBox(width: 5),
                                          Text(
                                            "${userDataList![index]["city"] ?? "N/A"}",
                                            style: const TextStyle(fontSize: 14, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(Icons.email, color: Colors.green, size: 18),
                                          SizedBox(width: 5),
                                          Expanded( // Wrap in Expanded to prevent overflow
                                            child: Text(
                                              "${userDataList![index]["email"] ?? "N/A"}",
                                              style: const TextStyle(fontSize: 14, color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(Icons.calendar_today, color: Colors.blue, size: 18),
                                          SizedBox(width: 5),
                                          Text(
                                            "${userDataList![index]["age"] ?? "N/A"}",
                                            style: const TextStyle(fontSize: 14, color: Colors.white),
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

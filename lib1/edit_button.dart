import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'add_user.dart';
import 'edit.dart';

class EditButton extends StatefulWidget {
  List<Map<String, dynamic>> userDataList;

  EditButton({required this.userDataList});

  @override
  State<EditButton> createState() => _EditButton();
}

class _EditButton extends State<EditButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Edit page",
            style: GoogleFonts.b612(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(13, 24, 33, 1),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(13, 24, 33, 1),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              // Parse and format the date
              String dob = widget.userDataList[index]["dob"] ?? "N/A";
              String formattedDob = "N/A";
              try {
                DateTime date = DateFormat("yyyy-MM-dd").parse(dob);
                formattedDob = DateFormat("dd/MM/yyyy").format(date); // Day/Month/Year format
              } catch (e) {
                formattedDob = "N/A";
              }

              return Column(
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
                            // Row for Name, Edit, and Favorite
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      widget.userDataList[index]["gender"] == "Male"
                                          ? Icons.male
                                          : Icons.female,
                                      color: widget.userDataList[index]["gender"] == "Male"
                                          ? Colors.blue
                                          : Colors.pink,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 8), // Space between the icon and username
                                    Text(
                                      widget.userDataList[index]["userName"] ?? "N/A",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddUser(
                                              userDataList: widget.userDataList,
                                              editIndex: index, // Passing the index for editing
                                            ),
                                          ),
                                        ).then((updatedData) {
                                          if (updatedData != null) {
                                            widget.userDataList[index] = updatedData;
                                          }
                                          setState(() {});
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      onPressed: () {
                                        setState(() {
                                          widget.userDataList
                                              .removeAt(index);
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        (widget.userDataList[index]["isFav"] ?? false)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.redAccent,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          widget.userDataList[index]["isFav"] =
                                          !(widget.userDataList[index]["isFav"] ?? false);
                                        });
                                      },
                                    ),

                                  ],
                                ),
                              ],
                            ),
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
                                        "${widget.userDataList[index]["city"] ?? "N/A"}",
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
                                          "${widget.userDataList[index]["email"] ?? "N/A"}",
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
                                        "${widget.userDataList[index]["age"] ?? "N/A"}",
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
              );
            },
            itemCount: widget.userDataList.length,
          ),
        ],
      ),
    );
  }
}

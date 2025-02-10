import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'package:sqflite/sqflite.dart';
import '../database/database.dart';
import 'add_user.dart';
import 'edit.dart';

class EditButton extends StatefulWidget {
  List<Map<String, dynamic>> userDataList;

  EditButton({required this.userDataList});

  @override
  State<EditButton> createState() => _EditButton();
}

class _EditButton extends State<EditButton> {
  MyDatabase databse = MyDatabase();
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
          FutureBuilder(
          future: databse.selectAllUser(),
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
              // Parse and format the date
              var user = snapshot.data![index];
              String dob = user["dob"] ?? "N/A";
              String formattedDob = "N/A";
              try {
                DateTime date = DateTime.parse(dob);
                formattedDob = DateFormat("dd/MM/yyyy").format(date); // Day/Month/Year format
              } catch (e) {
                formattedDob = "N/A";
              }

              return Dismissible(
                key: Key(user["userName"]),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Confirm Deletion"),
                      content: Text("Are you sure you want to delete ${user["userName"]}?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text("Delete", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) async {
                  var deletedUser = snapshot.data![index];
                  int deletedUserId = deletedUser["id"];

                  // Delete from the database first
                  await databse.deleteUser(deletedUserId);

                  // Refresh UI by calling setState() (which triggers FutureBuilder to rebuild)
                  setState(() {});

                  // Show Snackbar with Undo option
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${deletedUser["userName"]} deleted'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () async {
                          await databse.insertUser(deletedUser);
                          setState(() {}); // Refresh UI
                        },
                      ),
                    ),
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
                              // Row for Name, Edit, and Favorite
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        user["gender"] == "Male"
                                            ? Icons.male
                                            : Icons.female,
                                        color: user["gender"] == "Male"
                                            ? Colors.blue
                                            : Colors.pink,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8), // Space between the icon and username
                                      Text(
                                        user["userName"].split(" ")[0] ?? "N/A",
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
                                        icon: Icon(
                                          (snapshot.data![index]["isFav"] ?? 0) == 0 ? Icons.favorite_border : Icons.favorite,
                                          color: Colors.redAccent,
                                          size: 24,
                                        ),
                                        onPressed: () async {
                                          int is_fav = snapshot.data![index]["isFav"];
                                          await databse.updateIsFav(snapshot.data![index], 1-is_fav);
                                          setState(() {

                                            // filteredList[index]["isFav"] =(filteredList[index]["isFav"] ??0) ==0? 1: 0;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddUser(
                                                userDataList: snapshot.data!,
                                                editIndex: index, // Passing the index for editing
                                              ),
                                            ),
                                          ).then((updatedData) async {
                                            if (updatedData != null) {
                                              updatedData["id"] = snapshot.data![index]["id"];
                                              print(updatedData);
                                              await databse.updateUser(updatedData);
                                            }
                                            setState(() {});
                                          });
                                        },
                                      ),

                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                                          onPressed: () async {
                                            bool? confirmDelete = await showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text("Confirm Deletion"),
                                                content: Text("Are you sure you want to delete ${user["userName"]}?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(false),
                                                    child: Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      await databse.deleteUser(user["id"]);
                                                      Navigator.of(context).pop(true);
                                                      setState(() {});  // Refresh UI after deletion
                                                    },
                                                    child: Text("Delete", style: TextStyle(color: Colors.red)),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }

                                      ),
                                      // IconButton(
                                      //   icon: Icon(
                                      //     (widget.userDataList[index]["isFav"] ?? 0) == 1
                                      //         ? Icons.favorite
                                      //         : Icons.favorite_border,
                                      //     color: Colors.redAccent,
                                      //     size: 24,
                                      //   ),
                                      //   onPressed: () {
                                      //     setState(() {
                                      //       widget.userDataList[index]["isFav"] =
                                      //           1 - (widget.userDataList[index]["isFav"] ?? 0);
                                      //     });
                                      //   },
                                      // ),

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
                                        SizedBox(width: 3),
                                        Text(
                                          "${user["city"] ?? "N/A"}",
                                          style: const TextStyle(fontSize: 14, color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.email, color: Colors.green, size: 18),
                                        SizedBox(width: 3),
                                        Expanded( // Wrap in Expanded to prevent overflow
                                          child: Text(
                                            "${user["email"] ?? "N/A"}",
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
                                        SizedBox(width: 3 ),
                                        Text(
                                          "${user["age"] ?? "N/A"}",
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
              );
            },
            itemCount: snapshot.data!.length,
          );}),
        ],
      ),
    );
  }
}

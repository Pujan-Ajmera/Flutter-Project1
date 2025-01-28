import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Favourit extends StatefulWidget {
  @override
  State<Favourit> createState() => _Favourit();
}

class _Favourit extends State<Favourit> {
  List<Map<String, dynamic>> userDataList = [
    {
      "userName": "John Doe",
      "city": "New York",
      "email": "john.doe@example.com",
      "mobileNumber": "1234567890",
      "dateOfBirth": "1990-01-01",
      "gender": "Male",
      "age": 35,
      "isFav": false,
    },
    {
      "userName": "Jane Smith",
      "city": "Los Angeles",
      "email": "jane.smith@example.com",
      "mobileNumber": "9876543210",
      "dateOfBirth": "1992-05-14",
      "gender": "Female",
      "age": 31,
      "isFav": false,
    },
    {
      "userName": "Michael Johnson",
      "city": "Chicago",
      "email": "michael.johnson@example.com",
      "mobileNumber": "4561237890",
      "dateOfBirth": "1985-12-22",
      "gender": "Male",
      "age": 39,
      "isFav": false,
    },
    {
      "userName": "Emily Davis",
      "city": "San Francisco",
      "email": "emily.davis@example.com",
      "mobileNumber": "7891234560",
      "dateOfBirth": "1995-03-10",
      "gender": "Female",
      "age": 29,
      "isFav": false,
    },
    {
      "userName": "David Wilson",
      "city": "Seattle",
      "email": "david.wilson@example.com",
      "mobileNumber": "6547891230",
      "dateOfBirth": "1988-07-20",
      "gender": "Male",
      "age": 36,
      "isFav": false,
    },
    {
      "userName": "Sophia Martinez",
      "city": "Miami",
      "email": "sophia.martinez@example.com",
      "mobileNumber": "3219876540",
      "dateOfBirth": "1998-11-02",
      "gender": "Female",
      "age": 26,
      "isFav": true,
    }
  ];
  _Favourit(){
    userDataList  = userDataList.where((item)=>item["isFav"]==true).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profiles Awaiting Marriage Confirmation",
            style: GoogleFonts.b612(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(13, 24, 33, 1),
      ),
      body: Stack(
        children: [
          Container(color: Color.fromRGBO(13, 24, 33, 1)),
          ListView.builder(itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(height: 25,),
                Center(
                  child: Card(
                    color: const Color(0xFF1E2A38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.blueGrey,
                                    radius: 28,
                                    child: Icon(Icons.person, size: 32, color: Colors.white),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    userDataList[index]["userName"] ?? "N/A",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  userDataList[index]["isFav"] ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.redAccent,
                                  size: 28,
                                ),
                                onPressed: () {
                                  setState(() {
                                    userDataList[index]["isFav"] = !userDataList[index]["isFav"];
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Icon(Icons.location_city, color: Colors.blueAccent),
                            title: const Text("City", style: TextStyle(color: Colors.grey)),
                            subtitle: Text(userDataList[index]["city"] ?? "N/A", style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.email, color: Colors.orangeAccent),
                            title: const Text("Email", style: TextStyle(color: Colors.grey)),
                            subtitle: Text(userDataList[index]["email"] ?? "N/A", style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.phone, color: Colors.greenAccent),
                            title: const Text("Mobile Number", style: TextStyle(color: Colors.grey)),
                            subtitle: Text(userDataList[index]["mobileNumber"] ?? "N/A", style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.cake, color: Colors.pinkAccent),
                            title: const Text("Date of Birth", style: TextStyle(color: Colors.grey)),
                            subtitle: Text(userDataList[index]["dateOfBirth"] ?? "N/A", style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: Icon(
                              userDataList[index]["gender"] == "Male" ? Icons.male : Icons.female,
                              color: Colors.lightBlueAccent,
                            ),
                            title: const Text("Gender", style: TextStyle(color: Colors.grey)),
                            subtitle: Text(userDataList[index]["gender"] ?? "N/A", style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.timeline, color: Colors.purpleAccent),
                            title: const Text("Age", style: TextStyle(color: Colors.grey)),
                            subtitle: Text("${userDataList[index]["age"] ?? "N/A"}", style: const TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                },
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                label: const Text("Edit", style: TextStyle(color: Colors.white)),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                },
                                icon: const Icon(Icons.delete, color: Colors.red),
                                label: const Text("Delete", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
            ;
          },itemCount: userDataList.length,)
        ],
      ),
    );

  }
}


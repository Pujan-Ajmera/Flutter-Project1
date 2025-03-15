import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../database/database.dart';
import 'dashboard.dart';

class AddUser extends StatefulWidget {
  List<Map<String, dynamic>> userDataList;
  int? editIndex;

  AddUser({required this.userDataList, this.editIndex});

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  MyDatabase databse = MyDatabase();
  String? selectedCity = "City";
  String? selectedGender = "Gender";
  DateTime firstDate = DateTime(DateTime.now().year - 80, DateTime.now().month, DateTime.now().day);
  DateTime lastDate = DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
  final _formKey = GlobalKey<FormState>();
  TextEditingController dobController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Map<String, bool> hobbies = {
    "Reading": false,
    "Traveling": false,
    "Cooking": false,
    "Sports": false,
    "Music": false,
  };

  @override
  void initState() {
    super.initState();
    if (widget.editIndex != null) {
      var userData = widget.userDataList[widget.editIndex!];
      String userHobbies = userData["hobbies"];
      List<String> selectedHobbies = userHobbies.split(',');
      for (String hobby in selectedHobbies) {
        hobby = hobby.trim(); // Remove any extra spaces
        if (hobbies.containsKey(hobby)) {
          hobbies[hobby] = true;
        }
      }
      fullNameController.text = userData["userName"];
      addressController.text = userData["address"];
      emailController.text = userData["email"];
      mobileController.text = userData["mobileNo"];
      selectedCity = userData["city"];
      selectedGender = userData["gender"];
      dobController.text = userData["dob"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                children: [
                  Text(
                    widget.editIndex == null
                        ? "Start Your Love Story"
                        : "Edit Your Details",
                    style: GoogleFonts.satisfy(
                      textStyle: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(fullNameController, "Full Name"),
                  SizedBox(height: 20),
                  _buildTextField(addressController, "Address"),
                  SizedBox(height: 20),
                  _buildEmailField(),
                  SizedBox(height: 20),
                  _buildMobileField(),
                  SizedBox(height: 20),
                  _buildDropdownField("City", selectedCity, getDropDownListItems()),
                  SizedBox(height: 20),
                  _buildDropdownField("Gender", selectedGender, _genderItems()),
                  SizedBox(height: 20),
                  _buildDatePickerField(),
                  SizedBox(height: 20),
                  _buildHobbiesSelection(),
                  SizedBox(height: 20),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false,List<TextInputFormatter> d = const [],var e = const []}) {
    if(hintText == "Full Name"){
      d =[ FilteringTextInputFormatter.singleLineFormatter,
       FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))];
    }
    return TextFormField(
      controller: controller,
      inputFormatters: d,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(100, 100, 100, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(180, 205, 237, 1)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hintText cannot be empty";
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
        if (value == null || value.isEmpty) {
          return "Email Address cannot be empty";
        } else if (!emailRegex.hasMatch(value)) {
          return "Enter a valid email address";
        }
        return null;
      },
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Email Address",
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(100, 100, 100, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(180, 205, 237, 1)),
        ),
      ),
    );
  }

  Widget _buildMobileField() {
    return TextFormField(
      controller: mobileController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Mobile Number cannot be empty";
        } else if (value.length != 10) {
          return "Mobile Number must be exactly 10 digits";
        } else if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
          return "Mobile Number can only contain digits";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Mobile No.",
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(100, 100, 100, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(180, 205, 237, 1)),
        ),
      ),
    );
  }

  Widget _buildDatePickerField() {
    return TextFormField(
      controller: dobController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Date of Birth (DD/MM/YYYY)",
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(100, 100, 100, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(180, 205, 237, 1)),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: lastDate,
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (pickedDate != null) {
          setState(() {
            dobController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please select a date";
        }
        final dob = DateFormat('dd/MM/yyyy').parse(value);
        final age = DateTime.now().difference(dob).inDays ~/ 365.25;
        if (age < 18 || age > 80) {
          return "You must be at least 18 and less than 80 years old.";
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String label, String? selectedValue, List<DropdownMenuItem<String>> items) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: items,
      onChanged: (value) {
        setState(() {
          if (label == "City") {
            selectedCity = value;
          } else if (label == "Gender") {
            selectedGender = value;
          }
        });
      },
      style: TextStyle(color: Colors.white),
      dropdownColor: Color.fromRGBO(13, 24, 33, 1),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(100, 100, 100, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(180, 205, 237, 1)),
        ),
      ),
      validator: (value) {
        if (value == "City" || value == "Gender") {
          return "Please select a valid $label.";
        }
        return null;
      },
    );
  }

  Widget _buildHobbiesSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: hobbies.entries.map((entry) {
        return CheckboxListTile(
          title: Text(entry.key, style: TextStyle(color: Colors.white)),
          value: entry.value,
          onChanged: (bool? value) {
            setState(() {
              hobbies[entry.key] = value!;
            });
          },
          activeColor: Colors.green,
          checkColor: Colors.white,
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                String fullName = fullNameController.text;
                String address = addressController.text;
                String email = emailController.text;
                String mobile = mobileController.text;
                String city = selectedCity ?? "Not Selected";
                String gender = selectedGender ?? "Not Selected";
                String dob = dobController.text;
                List<String> selectedHobbies = hobbies.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList();

                // Calculate age from DOB
                final dobDate = DateFormat('dd/MM/yyyy').parse(dob);
                final age = DateTime.now().difference(dobDate).inDays ~/ 365.25;
                // int isFav = widget.userDataList[widget.editIndex!]["isFav"];
                // print(isFav);
                Map<String, dynamic> newUser = {
                  "userName": fullName,
                  "address": address,
                  "email": email,
                  "mobileNo": mobile,
                  "city": city,
                  "gender": gender,
                  "dob": dob,
                  "hobbies": selectedHobbies.join(","),
                  "age": age,
                  "isFav":0,
                  "extraDetails":"my name is ${fullName} i live at ${address} you can contact me at ${email} and at ${mobile} i live at the city named ${city} my gender is ${gender} my hobbies are ${hobbies} and i good}"
                };

                if (widget.editIndex != null) {
                  // widget.userDataList[widget.editIndex!] = newUser;
                  newUser["isFav"] = widget.userDataList[widget.editIndex!]["isFav"];
                  print("${newUser} updated");
                  Navigator.pop(context,newUser);
                } else {
                  // print("${newUser} added");
                  // await databse.insertUser(newUser);
                  // Add new user
                  // widget.userDataList.add(newUser);
                  await _addUser(newUser);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Dashboard(selected: 0,),
                  ),);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added User'),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(13, 24, 33, 1),
            ),
            child: Text(
              widget.editIndex == null ? "Submit" : "Save",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getDropDownListItems() {
    return [
      DropdownMenuItem(value: "City", child: Text("City")),
      DropdownMenuItem(value: "Mumbai", child: Text("Mumbai")),
      DropdownMenuItem(value: "Delhi", child: Text("Delhi")),
      DropdownMenuItem(value: "Bangalore", child: Text("Bangalore")),
      DropdownMenuItem(value: "Chennai", child: Text("Chennai")),
    ];
  }

  List<DropdownMenuItem<String>> _genderItems() {
    return [
      DropdownMenuItem(value: "Gender", child: Text("Gender")),
      DropdownMenuItem(value: "Male", child: Text("Male")),
      DropdownMenuItem(value: "Female", child: Text("Female")),
      DropdownMenuItem(value: "Other", child: Text("Other")),
    ];
  }

  Future<void> _addUser(Map<String, dynamic> newUser) async {
    final String apiUrl = "https://66f274a771c84d80587551d2.mockapi.io/users";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(newUser),
      );

      if (response.statusCode == 201) {
        print("User added successfully!");
      } else {
        print("Failed to add user: ${response.statusCode}");
      }
    } catch (error) {
      print("Error adding user: $error");
    }
  }
}


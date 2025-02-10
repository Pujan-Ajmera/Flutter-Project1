import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditUser extends StatefulWidget {
  final Map<String, dynamic> userData;
  final List<Map<String, dynamic>> userDataList;
  final int index;

  EditUser({required this.userData, required this.userDataList, required this.index});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late String selectedCity;
  late String selectedGender;
  late TextEditingController fullNameController;
  late TextEditingController addressController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController dobController;

  Map<String, bool> hobbies = {
    "Reading": false,
    "Traveling": false,
    "Cooking": false,
    "Sports": false,
    "Music": false,
  };

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data
    fullNameController = TextEditingController(text: widget.userData['userName']);
    addressController = TextEditingController(text: widget.userData['address']);
    emailController = TextEditingController(text: widget.userData['email']);
    mobileController = TextEditingController(text: widget.userData['mobileNo']);
    dobController = TextEditingController(text: widget.userData['dob']);

    // Initialize hobbies based on existing data
    for (var hobby in hobbies.keys) {
      hobbies[hobby] = widget.userData['hobbies']?.contains(hobby) ?? false;
    }

    // Initialize selected city and gender
    selectedCity = widget.userData['city'] ?? 'Not Selected';
    selectedGender = widget.userData['gender'] ?? 'Not Selected';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(fullNameController, "Full Name"),
              _buildTextField(addressController, "Address"),
              _buildEmailField(),
              _buildMobileField(),
              _buildDropdownField("City", selectedCity, _getCityDropdownItems()),
              _buildDropdownField("Gender", selectedGender, _getGenderDropdownItems()),
              _buildDatePickerField(),
              _buildHobbiesSelection(),
              ElevatedButton(
                onPressed: _saveUserData,
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(),
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
      decoration: InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
        if (value == null || value.isEmpty) {
          return "Email Address cannot be empty";
        } else if (!emailRegex.hasMatch(value)) {
          return "Enter a valid email address";
        }
        return null;
      },
    );
  }

  Widget _buildMobileField() {
    return TextFormField(
      controller: mobileController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Mobile No.",
        border: OutlineInputBorder(),
      ),
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
    );
  }

  Widget _buildDropdownField(String label, String selectedValue, List<DropdownMenuItem<String>> items) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: items,
      onChanged: (value) {
        setState(() {
          if (label == "City") {
            selectedCity = value ?? 'Not Selected';
          } else if (label == "Gender") {
            selectedGender = value ?? 'Not Selected';
          }
        });
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value == 'Not Selected') {
          return "Please select a valid $label.";
        }
        return null;
      },
    );
  }

  Widget _buildDatePickerField() {
    return TextFormField(
      controller: dobController,
      decoration: InputDecoration(
        labelText: "Date of Birth (DD/MM/YYYY)",
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
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
  Widget _buildHobbiesSelection() {
    return Column(
      children: hobbies.entries.map((entry) {
        return CheckboxListTile(
          title: Text(entry.key),
          value: entry.value ?? false,  // Ensure the value is not null
          onChanged: (bool? value) {
            setState(() {
              hobbies[entry.key] = value ?? false;  // Ensure value is either true or false
            });
          },
        );
      }).toList(),
    );
  }
  List<DropdownMenuItem<String>> _getCityDropdownItems() {
    return [
      DropdownMenuItem(value: "Mumbai", child: Text("Mumbai")),
      DropdownMenuItem(value: "Delhi", child: Text("Delhi")),
      DropdownMenuItem(value: "Bangalore", child: Text("Bangalore")),
      DropdownMenuItem(value: "Chennai", child: Text("Chennai")),
    ];
  }

  List<DropdownMenuItem<String>> _getGenderDropdownItems() {
    return [
      DropdownMenuItem(value: "Male", child: Text("Male")),
      DropdownMenuItem(value: "Female", child: Text("Female")),
      DropdownMenuItem(value: "Other", child: Text("Other")),
    ];
  }

  void _saveUserData() {
    if (_formKey.currentState?.validate() ?? false) {
      List<String> selectedHobbies = hobbies.entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key)
          .toList();

      Map<String, dynamic> updatedUser = {
        "userName": fullNameController.text,
        "address": addressController.text,
        "email": emailController.text,
        "mobileNo": mobileController.text,
        "city": selectedCity,
        "gender": selectedGender,
        "dob": dobController.text,
        "hobbies": selectedHobbies,
      };
      print("before ${widget.userDataList[widget.index]}");
      widget.userDataList[widget.index] = updatedUser;
      print("after ${widget.userDataList[widget.index]}");
      Navigator.pop(context, updatedUser);
    }
  }
}

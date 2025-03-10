import 'package:flutter/material.dart';
import 'package:movies_api/database/database.dart';

class Play extends StatefulWidget {
  const Play({super.key});

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  MyDatabase db = MyDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("THis is the DB"),),
      floatingActionButton: FloatingActionButton(onPressed: _showAddUserDialog,child: Icon(Icons.add),),
      body: FutureBuilder(future: db.getAllUsers(), builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasError){
          return Center(child: Text('There is a error in the snapshot'),);
        }else if(!snapshot.hasData||snapshot.data!.isEmpty){
          return Center(child: Text('No users found in the db'),);
        }else{
          return ListView.builder(itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Row(
                children: [
                  Text("${snapshot.data![index]["user_name"]} ,"),
                  // Text("${snapshot.data![index]["user_email"]}"),
                  IconButton(icon:Icon(Icons.delete,color: Colors.red,),onPressed: () async {
                    print(snapshot.data![index]["user_id"]);
                    await db.deleteUser(snapshot.data![index]);
                    setState(() {

                    });
                  },),
                  IconButton(icon:Icon(Icons.edit,color: Colors.blue,),onPressed: () async {
                    _showEditUserDialog(snapshot.data![index]["user_id"]);
                  },),
                ],
              ),
            );
          },itemCount: snapshot.data!.length,);
        }

      },),
    );
  }

  void _showAddUserDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text.trim();
                String email = emailController.text.trim();
                if (name.isNotEmpty && email.isNotEmpty) {
                  await db.insertUser({"user_name": name, "user_email": email});
                  setState(() {});
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }


  void _showEditUserDialog(int id) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text.trim();
                String email = emailController.text.trim();
                if (name.isNotEmpty && email.isNotEmpty) {
                  await db.updateUser({"user_id":id,"user_name": name, "user_email": email});
                  setState(() {});
                  Navigator.pop(context);
                }
              },
              child: Text("Edit"),
            ),
          ],
        );
      },
    );
  }
}

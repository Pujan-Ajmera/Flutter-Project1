import 'package:flutter/material.dart';
import 'package:lab6/api_practical/api_services.dart';
class API extends StatefulWidget {
  const API({super.key});

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  ApiData api = ApiData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        _showAddUserDialog();
            setState(() {});
      },child: Icon(Icons.add),),
      appBar: AppBar(title: Text('THIS IS A CRUD BY API :)'),),
      body: FutureBuilder(future: api.getAllUsers(), builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasError){
          return Center(child: Text('This api has some error'),);
        }else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(child: Text('This api has no data'),);
        }else{
          return ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              title: Text('${snapshot.data![index]["name"]}'),
              subtitle: Text('${snapshot.data![index]["email"]}'),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(onPressed: () async {
                      await api.deleteUser(snapshot.data![index]["id"]);
                      setState(() {});
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                    IconButton(onPressed: ()  => {
                      _showEditUserDialog(snapshot.data![index]["id"]),
                      setState(() {}),
                    }, icon: Icon(Icons.edit,color: Colors.blue,)),
                  ],
                ),
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
                   await api.addUser({"name": name, "email": email});
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

  void _showEditUserDialog(String id) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit User"),
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
              onPressed: () => Navigator.pop(context), // Close dialog
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text.trim();
                String email = emailController.text.trim();
                if (name.isNotEmpty && email.isNotEmpty) {
                   await api.updateUser(id,{"name": name, "email": email});
                  setState(() {});
                  Navigator.pop(context); // Close dialog
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:native_shared_preferences/native_shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              controller: _name,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0,),
            Text(
              "Age",
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              controller: _age,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      var nm = _name.text.toString();
                      var ag = _age.text.toString();
                      NativeSharedPreferences prefs =
                          await NativeSharedPreferences.getInstance();
                      //Store
                      prefs.setString("firstname", nm);
                      prefs.setString("age", ag);

                      FlutterToastr.show("Value Stored!", context,
                          duration: FlutterToastr.lengthShort,
                          position: FlutterToastr.bottom);

                      _name.text = "";
                      _age.text = "";
                    },
                    child: Text("Add")),
                ElevatedButton(
                    onPressed: () async {
                      NativeSharedPreferences prefs =
                          await NativeSharedPreferences.getInstance();

                      //check
                      if (prefs.containsKey("firstname")) {
                        //read
                        var firstname = prefs.getString("firstname").toString();
                        var age = prefs.getString("age").toString();

                        FlutterToastr.show("Name : " + firstname + "Age :"  + age, context,
                            duration: FlutterToastr.lengthShort,
                            position: FlutterToastr.bottom);

                      } else {
                        FlutterToastr.show("Not Available!", context,
                            duration: FlutterToastr.lengthShort,
                            position: FlutterToastr.bottom);
                      }
                    },
                    child: Text("Read")),
                ElevatedButton(
                    onPressed: () async {
                      NativeSharedPreferences prefs =
                          await NativeSharedPreferences.getInstance();
                      //check
                      if (prefs.containsKey("firstname")) {
                        prefs.clear(); //all data
                        // prefs.remove("firstname");

                        FlutterToastr.show("Value Removed", context,
                            duration: FlutterToastr.lengthShort,
                            position: FlutterToastr.bottom);
                      } else {
                        FlutterToastr.show("Not Available!", context,
                            duration: FlutterToastr.lengthShort,
                            position: FlutterToastr.bottom);
                      }
                    },
                    child: Text("Delete")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

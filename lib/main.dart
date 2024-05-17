import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp( MyApp());
}

//shared preference is used to store user specific info
// for example when a user logs in into an app hsi her info is stored into the system
//so when the user opens the app again user doesnt have to login again and again
//in these matter shred preference comes in use logout k baad firse login krega
//large data mei query generate krke handle krte h there we use large dbms in small we use shared preferences
// add shared preference dependency
//shared preference can take large amount of time where the process can be done asynchronously thats why we write async and await
//async because ui part jo h time lgne pe hold pe na jaye humme iske liye wait na krna pde sync way mei yu jo h hold ho skti h
//time lgega to ui jo h hold mei chlijaegi vo humme chahie nhi to humne async lgaya
//convert to stateful not stateless
//textfield mei value lene k liye we use controller
//init cannot be handled async thats why we use getvalue function which we made seperately



class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  var nameController = TextEditingController();
  var nameValue ="No Value Saved";

  var emailController = TextEditingController();
  var emailValue = "No Value Saved";

  var passwordController = TextEditingController();
  var passwordValue = "No Value Saved";

  @override
  void initState(){
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
          title: Text("SharedPreferences"),
        ),

        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
                  ),
                  obscureText: true,
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () async{
                  var name= nameController.text.toString();
                  var email = emailController.text.toString();
                  var password = passwordController.text.toString();

                  var prefs = await SharedPreferences.getInstance();

                  prefs.setString("name", name);
                  prefs.setString("email", email);
                  prefs.setString("password", password);


                  setState(() {
                    nameValue=name;
                    emailValue=email;
                    passwordValue=password;
                  });
                },
                    child: Text("Save"),
                ),
              ),
              SizedBox(height: 10,),
              Text("Name:$nameValue"),
              Text("Email:$emailValue"),


            ],
          ),
        ),

      ),
    );



  }
  void getValue() async{

    var prefs= await SharedPreferences.getInstance();

    var getName =prefs.getString("name");
    var getEmail = prefs.getString("email");
    var getPassword = prefs.getString("password");

    setState(() {
      nameValue = getName!= null ? getName :"No Value Saved";
      emailValue = getEmail!= null ? getEmail :"No Value Saved";
      passwordValue = getPassword!= null ? getPassword :"No Value Saved";

    });
  }

}
//app start hogi init statecall hogi uske andr getvalue call hogi uske andr pregs.getString call hogi
//vo dekhega ki key name uske naam se pehle kuch h ya nhi agr h to firse save nhi krega agr nhi h to save krega
//save pe tap krke setstring se save hojaega






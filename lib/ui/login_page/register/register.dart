import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../home_page/home_page.dart';

class ResgisterPage extends StatefulWidget {
  const ResgisterPage({Key? key}) : super(key: key);

  @override
  State<ResgisterPage> createState() => _ResgisterPageState();
}

class _ResgisterPageState extends State<ResgisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noHpController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> register() async {
    var jsonRespone;
    if(_usernameController.text.isNotEmpty || _passwordController.text.isNotEmpty ){
      var response = await http.post(Uri.parse("http://www.amanahfurniture.space/api/register"),
        body: ({
          'username' : _usernameController.text.trim(),
          'email' : _emailController.text.trim(),
          'password' : _passwordController.text.trim(),
          'alamat' : _alamatController.text.trim(),
          'no_hp' : _noHpController.text.trim(),
          'password' : _passwordController.text.trim(),

        }),
      );
      jsonRespone = await json.decode(response.body);
      var token = jsonRespone['access_token'];
      print('Token : ' + jsonRespone['access_token']);
      if(response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Register Success!')));
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(Token: token),));
      }
      else{
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid Credentials.')));
      }
    }
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Black Field not ALlowed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register'
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18
                ),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: "Nama Pengguna",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 18,
                    )
                ),
              ),
              TextField(
                controller: _emailController,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18
                ),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 18,
                    )
                ),
              ),
              TextField(
                controller: _alamatController,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18
                ),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: "Alamat",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 18,
                    )
                ),
              ),
              TextField(
                controller: _noHpController,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: "No Telp",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 18,
                    )
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18
                ),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 18,
                    )
                ),
              ),
              SizedBox(
                height: 200,
              ),
              ElevatedButton(onPressed: () => register(), child: Text('Register'))
            ],
          ),
        ),
      ),
    );
  }
}

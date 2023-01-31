import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:login_laravel/ui/home_page/home_page.dart';
import 'package:login_laravel/ui/login_page/register/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> login() async {
    var jsonRespone;
    if(_usernameController.text.isNotEmpty || _passwordController.text.isNotEmpty ){
      var response = await http.post(Uri.parse("http://www.amanahfurniture.space/api/login"),
        body: ({
          'email' : _usernameController.text.trim(),
          'password' : _passwordController.text.trim()
        }),
      );
      jsonRespone = await json.decode(response.body);
      var token = jsonRespone['access_token'];
      print('Token : ' + jsonRespone['access_token']);
      if(response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login Success!')));
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 70,
                            right: 20
                        ),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {

                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              width: 50,
                              color: Colors.green,
                              alignment: Alignment.center,
                              child: Text(
                                'Skip',
                                style: GoogleFonts.poppins(
                                    color: Colors.green,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 25,
                            right: 25
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20
                            ),
                            color: Colors.black.withOpacity(0.03),
                            child: TextField(
                              maxLines: 1,
                              controller: _usernameController,
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
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 25,
                            right: 25
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20
                            ),
                            color: Colors.black.withOpacity(0.03),
                            child: TextField(
                              obscureText: true,
                              maxLines: 1,
                              controller: _passwordController,
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
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  color:Colors.green,
                                  width: 100,
                                  height: 50,
                                  child: InkWell(
                                      child: Center(child: Text('Login', style: TextStyle(color: Colors.white),)),
                                      onTap: () async {
                                        login();
                                      }
                                  ),
                                ),
                              )
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Container(
                              color: Colors.white,
                              width: 100,
                              height: 50,
                              child: InkWell(
                                  onTap: () async {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResgisterPage(),));
                                  },
                                  child: Center(child: Text('Sign Up', style: TextStyle(color: Colors.green),))
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}

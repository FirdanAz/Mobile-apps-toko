import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_laravel/model/data_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.Token}) : super(key: key);
  final Token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? userModels;
  bool _isLoad = false;

  Future<void> getDataRes() async {
    _isLoad = true;
    var token = widget.Token;
    var jsonResponse;
    try{
      var response = await http.get(Uri.parse("http://www.amanahfurniture.space/api/user"),
          headers: {
            'Content-Type' : 'application/json; charset=UTF-8',
            'Authorization' : 'Bearer $token'
          }
      );
      if(response.statusCode == 200){
        jsonResponse = await json.decode(response.body);
        UserModel userModel = UserModel(jsonResponse["id"], jsonResponse["username"], jsonResponse["email"], jsonResponse["alamat"], jsonResponse["no_hp"]);
        print(jsonResponse);
        setState(() {
          userModels = userModel;
          _isLoad = false;
        });
      }
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataRes();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoad == true ? Center(child: CircularProgressIndicator(),) : Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            title: Text('Account Info'),
            expandedHeight: 100,
            backgroundColor: Colors.black87,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(userModels!.username.toString()),
                Text(userModels!.email.toString()),
                Text(userModels!.alamat.toString()),
                Text(userModels!.no_hp.toString()),
              ],
            )
          )
        ],
      ),
    );
  }
}

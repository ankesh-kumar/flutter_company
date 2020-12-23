
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app2/company_model.dart';
import 'package:http/http.dart' as http;


class ListCompany extends StatefulWidget{
  @override
  _ListCompanyState createState() => _ListCompanyState();
}

class _ListCompanyState extends State<ListCompany> {

  List<Company> list_company;
  bool is_api_calling=false;

  @override
  void initState() {

    setState(() {
      is_api_calling=true;
    });
    getData();
    super.initState();
  }

  void getData()async{

    var url = 'https://clouce.com/companies.json';
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    setState(() {
      is_api_calling=false;
      var res=jsonDecode(response.body);
      list_company=res['companies'];

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      is_api_calling?CircularProgressIndicator():
      Expanded(
        child: ListView.builder(
          itemCount: list_company.length,
          itemBuilder: (BuildContext ctxt, int index){
              return Card(
                elevation: 5.0,
                child: ListTile(

                  leading: Image.network(list_company[index].companyLogo),
                  title:Text(list_company[index].companyName),
                  subtitle: Text(list_company[index].companyCeo),

                ),
              );


          }



        ),
    ),

    );

  }
}
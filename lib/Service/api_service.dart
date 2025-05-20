import 'dart:convert';

import 'package:ecommerce/model/Products.dart';
import 'package:ecommerce/model/ResponseMain.dart';
import 'package:http/http.dart' as http;

class ApiService {

  Future <List<Products>?> fetchProducts() async{

    var response= await http.get(Uri.parse("https://dummyjson.com/products"));
      

    if (response.statusCode == 200) {
    final jsonMap = jsonDecode(response.body);

    
    ResponseMain res = ResponseMain.fromJson(jsonMap);

    var list=res.products;
    return list;
   
  } else {
    throw Exception('Failed to load products');
  }
    
  }
}


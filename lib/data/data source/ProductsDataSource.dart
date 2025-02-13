import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../data model/ProductDataModel.dart';

class ProductsDataSource {
  Future<List<ProductDataModel>?> getProducts() async {
    print("getProducts called");
    try {
      QuerySnapshot<Map<String, dynamic>> collection =
          await FirebaseFirestore.instance.collection('products').get();

      final List<Map<String, dynamic>> productsList = collection.docs.map((e) {
        return e.data();
      }).toList();

      final List<ProductDataModel> products = [];
      for (Map<String, dynamic> item in productsList) {
        ProductDataModel product = ProductDataModel.fromJson(item);
        products.add(product);
      }

      return products;
    } catch (e) {
      print(e);

      return null;
    }
  }

// static Future<bool> getProducts() async {
//   print("getProducts called");
//   try {
//     final response =
//     await http.get(Uri.parse('https://dummyjson.com/products'));
//     // final response =
//     //     await http.get(Uri.parse("https://fakestoreapi.com/products"));
//     //https://dummyjson.com/products
//
//     if (response.statusCode == 200) {
//       print('Loaded Products');
//       //List<dynamic> productsList = jsonDecode(response.body);
//       Map<String, dynamic> resBody = jsonDecode(response.body);
//
//       final List<dynamic> productsList = resBody['products'];
//
//       for (Map<String, dynamic> item in productsList) {
//         ProductDataModel product = ProductDataModel.fromJson(item);
//         products.add(product);
//       }
//
//       isLoading = false;
//     } else {
//       throw Exception("${response.statusCode}");
//     }
//     return true;
//   } catch (e) {
//     isLoading = false;
//     isError = true;
//     errorMessage = e.toString();
//     print(e);
//
//     return false;
//   }
// }
}

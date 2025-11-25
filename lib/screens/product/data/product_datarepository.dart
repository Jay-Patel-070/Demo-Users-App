import 'dart:convert';
import 'package:demo_users_app/http/api_result.dart';
import 'package:demo_users_app/screens/product/data/product_datasource.dart';
import 'package:demo_users_app/screens/product/model/product_details_model.dart';
import 'package:demo_users_app/screens/product/model/product_model.dart';
import 'package:http/http.dart';

class ProductDatarepository {
  final ProductDatasource productdatasource;
  ProductDatarepository(this.productdatasource);
  Future<ApiResult<ProductModel>> getallproducts({String? search, String? sortBy,String? category}) async{
    try{
      Response result = await productdatasource.getallproducts(search: search,sortBy: sortBy,category: category);
    if(result.statusCode == 200){
      final data = ProductModel.fromJson(jsonDecode(result.body));
      return ApiResult.success(data: data);
    } else{
      return ApiResult.failure(error: jsonDecode(result.body)['message']);
    }
    } catch(e) {
      print(e);
      return ApiResult.failure(error: "Something went wrong");
    }
  }

  Future<ApiResult<ProductDetailsModel>> getproductbyid(int id) async{
    try{
      Response result = await productdatasource.getproductbyid(id);
      if(result.statusCode == 200){
        final data = ProductDetailsModel.fromJson(jsonDecode(result.body));
        return ApiResult.success(data: data);
      } else{
        return ApiResult.failure(error: jsonDecode(result.body)['message']);
      }
    } catch(e) {
      print(e);
      return ApiResult.failure(error: "Something went wrong");
    }
  }

  Future<ApiResult<List>> getproductcategorylist() async{
    try{
      Response result = await productdatasource.getproductcategorylist();
      if(result.statusCode == 200){
        final data = jsonDecode(result.body);
        return ApiResult.success(data: data);
      } else{
        return ApiResult.failure(error: jsonDecode(result.body)['message']);
      }
    } catch(e) {
      print(e);
      return ApiResult.failure(error: "Something went wrong");
    }
  }
}
import 'dart:convert';
import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/http/my_app_http.dart';
import 'package:demo_users_app/utils/api_constant.dart';
import 'package:http/http.dart' as http ;

class ProductDatasource {
  Future<dynamic> getallproducts ({String? search, String? sortBy,String? category}) async{
    try{
      var buffer = StringBuffer(ApiConstant.products);
      if(search.isNotNullOrEmpty()){
         buffer.write("/search?q=$search");
      }
      if(sortBy.isNotNullOrEmpty()){
        buffer.write("?sortBy=title&order=$sortBy");
      }
      if(category.isNotNullOrEmpty()){
        buffer.write("/category/$category");
      }
      final response = await getMethod(
          endpoint: buffer.toString()
      );
      return response;
    } catch (e){
      print(e);
    }
  }

  Future<dynamic> getproductbyid (int id) async{
    try{
      final response = await getMethod(endpoint: ApiConstant.products + '/' + id.toString());
      return response;
    } catch (e){
      print(e);
    }
  }

  Future<dynamic> getproductcategorylist () async{
    try{
      final response = await getMethod(endpoint: ApiConstant.products + ApiConstant.category_list);
      return response;
    } catch (e){
      print(e);
    }
  }
}
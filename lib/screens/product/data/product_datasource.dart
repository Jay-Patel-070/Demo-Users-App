import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/http/my_app_http.dart';
import 'package:demo_users_app/utils/api_constant.dart';

class ProductDatasource {
  Future<dynamic> getallproducts({
    String? search,
    String? sortBy,
    String? category,
    int? skip,
    num? limit
  }) async {
    try {
      var buffer = StringBuffer(ApiConstant.products);
      if (search.isNotNullOrEmpty()) {
        buffer.write("/search?q=$search");
      }
      if (sortBy.isNotNullOrEmpty()) {
        buffer.write("?sortBy=title&order=$sortBy");
      }
      if (category.isNotNullOrEmpty()) {
        buffer.write("/category/$category");
      }
      if (skip != null) {
        buffer.write("/?limit=${limit ?? 16}&skip=$skip");
      }
      final response = await getMethod(endpoint: buffer.toString());
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getproductbyid(int id) async {
    try {
      final response = await getMethod(endpoint: '${ApiConstant.products}/$id');
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getproductcategorylist() async {
    try {
      final response = await getMethod(
        endpoint: '${ApiConstant.products}${ApiConstant.category_list}',
      );
      return response;
    } catch (e) {
      print(e);
    }
  }
}

import 'package:demo_users_app/screens/product/model/product_details_model.dart';
import 'package:demo_users_app/screens/product/model/product_model.dart';

enum ApiCallState { none, busy, success, failure }

class ProudctInitialState extends ProductState {}

class ProductState {
  ApiCallState productapicallstate;
  ApiCallState loadmoreProductState;
  ApiCallState categoryapicallstate;
  ProductModel? productModel;
  String? error;
  ProductDetailsModel? productdetailsmodel;
  List? productcategorylist;
  ProductState({
    this.productapicallstate = ApiCallState.none,
    this.productModel,
    this.error,
    this.productdetailsmodel,
    this.productcategorylist,
    this.categoryapicallstate = ApiCallState.none,
    this.loadmoreProductState = ApiCallState.none,
  });

  ProductState copywith({
    ApiCallState? productapicallstate,
    ApiCallState? loadmoreProductState,
    ProductModel? productModel,
    String? error,
    ApiCallState? categoryapicallstate,
    ProductDetailsModel? productdetailsmodel,
    List? productcategorylist,
  }) {
    return ProductState(
      productapicallstate: productapicallstate ?? this.productapicallstate,
      loadmoreProductState: loadmoreProductState ?? this.loadmoreProductState,
      productModel: productModel ?? this.productModel,
      categoryapicallstate: categoryapicallstate ?? this.categoryapicallstate,
      productdetailsmodel: productdetailsmodel ?? this.productdetailsmodel,
      productcategorylist: productcategorylist ?? this.productcategorylist,
      error: error ?? this.error,
    );
  }
}

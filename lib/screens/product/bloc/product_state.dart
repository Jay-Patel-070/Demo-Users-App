import 'package:demo_users_app/screens/product/model/product_details_model.dart';
import 'package:demo_users_app/screens/product/model/product_model.dart';

enum ProductApiCallState {none,busy, success, failure}

class ProudctInitialState extends ProductState  {}

class ProductState {
  ProductApiCallState apicallstate;
  ProductModel? productmodel;
  String? error;
  ProductDetailsModel? productdetailsmodel;
  List? productcategorylist;
  ProductState({this.apicallstate = ProductApiCallState.none,this.productmodel, this.error,this.productdetailsmodel,this.productcategorylist});

  ProductState copywith({ProductApiCallState? apicallstate, ProductModel? productmodel, String? error,ProductDetailsModel? productdetailsmodel,List? productcategorylist}) {
    return ProductState(
      apicallstate: apicallstate ?? this.apicallstate,
      productmodel: productmodel ?? this.productmodel,
      productdetailsmodel: productdetailsmodel ?? this.productdetailsmodel,
        productcategorylist: productcategorylist ?? this.productcategorylist,
      error: error ?? this.error
    );
  }
}
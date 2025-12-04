import 'dart:math';

import 'package:demo_users_app/screens/product/bloc/product_event.dart';
import 'package:demo_users_app/screens/product/bloc/product_state.dart';
import 'package:demo_users_app/screens/product/data/product_datarepository.dart';
import 'package:demo_users_app/screens/product/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductDatarepository productdatarepository;
  ProductBloc(this.productdatarepository) : super(ProudctInitialState()) {
    on<FetchAllProductsEvent>(fetchallproductsevent);
    on<FetchProductsEventById>(fetchproducteventbyid);
    on<FetchProductCategoryListEvent>(fetchproductcategorylistevent);
  }
  fetchallproductsevent(FetchAllProductsEvent event, emit) async {
    if (event.skip == null || event.skip == 0) {
      emit(state.copywith(productapicallstate: ApiCallState.busy));
    } else {
      emit(state.copywith(loadmoreProductState: ApiCallState.busy));
    }
    try {
      final result = await productdatarepository.getallproducts(
        search: event.search,
        sortBy: event.sortBy,
        category: event.category,
        skip: event.skip,
      );
      emit(state.copywith(productapicallstate: ApiCallState.busy));
      result.when(
        success: (data) {
          if(event.skip == null || event.skip ==0){
            emit(
              state.copywith(
                productapicallstate: ApiCallState.success,
                productModel: result.data,
              ),
            );
            emit(state.copywith(productapicallstate: ApiCallState.none));
          }else{
            final previous = state.productModel?.products;
            previous?.addAll(result.data?.products ?? []);
            emit(
              state.copywith(
                productModel: ProductModel(products: previous,total: state.productModel?.total,),
                productapicallstate: ApiCallState.success,
              ),
            );
            emit(state.copywith(loadmoreProductState: ApiCallState.none));
          emit(state.copywith(productapicallstate: ApiCallState.none));
          }
        },
        failure: (error) {
          emit(
            state.copywith(
              productapicallstate: ApiCallState.failure,
              error: error,
            ),
          );
        },
      );
      emit(state.copywith(productapicallstate: ApiCallState.none));
    } catch (e) {
      emit(state.copywith(productapicallstate: ApiCallState.busy));
      emit(state.copywith(productapicallstate: ApiCallState.failure));
    }
  }

  fetchproducteventbyid(FetchProductsEventById event, emit) async {
    emit(state.copywith(productapicallstate: ApiCallState.busy));
    try {
      final result = await productdatarepository.getproductbyid(event.id);
      emit(state.copywith(productapicallstate: ApiCallState.busy));
      result.when(
        success: (data) {
          emit(
            state.copywith(
              productapicallstate: ApiCallState.success,
              productdetailsmodel: result.data,
            ),
          );
        },
        failure: (error) {
          emit(
            state.copywith(
              productapicallstate: ApiCallState.failure,
              error: error,
            ),
          );
        },
      );
      emit(state.copywith(productapicallstate: ApiCallState.none));
    } catch (e) {
      emit(state.copywith(productapicallstate: ApiCallState.busy));
      emit(state.copywith(productapicallstate: ApiCallState.failure));
    }
  }

  fetchproductcategorylistevent(
    FetchProductCategoryListEvent event,
    emit,
  ) async {
    emit(state.copywith(categoryapicallstate: ApiCallState.busy));
    try {
      final result = await productdatarepository.getproductcategorylist();
      emit(state.copywith(categoryapicallstate: ApiCallState.busy));
      result.when(
        success: (data) {
          emit(
            state.copywith(
              categoryapicallstate: ApiCallState.success,
              productcategorylist: result.data,
            ),
          );
        },
        failure: (error) {
          emit(
            state.copywith(
              categoryapicallstate: ApiCallState.failure,
              error: error,
            ),
          );
        },
      );
      emit(state.copywith(categoryapicallstate: ApiCallState.none));
    } catch (e) {
      emit(state.copywith(categoryapicallstate: ApiCallState.busy));
      emit(state.copywith(categoryapicallstate: ApiCallState.failure));
    }
  }
}

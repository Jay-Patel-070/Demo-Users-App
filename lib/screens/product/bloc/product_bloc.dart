import 'package:demo_users_app/screens/product/bloc/product_event.dart';
import 'package:demo_users_app/screens/product/bloc/product_state.dart';
import 'package:demo_users_app/screens/product/data/product_datarepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductDatarepository productdatarepository;
  ProductBloc(this.productdatarepository) : super(ProudctInitialState()) {
    on<FetchAllProductsEvent>(fetchallproductsevent);
    on<FetchProductsEventById>(fetchproducteventbyid);
    on<FetchProductCategoryListEvent>(fetchproductcategorylistevent);
  }
  fetchallproductsevent(FetchAllProductsEvent event, emit) async {
    emit(state.copywith(apicallstate: ProductApiCallState.busy));
    try {
      final result = await productdatarepository.getallproducts(
        search: event.search,
        sortBy: event.sortBy,
        category: event.category
      );
      emit(state.copywith(apicallstate: ProductApiCallState.busy));
      result.when(
        success: (data) {
          emit(
            state.copywith(
              apicallstate: ProductApiCallState.success,
              productmodel: result.data,
            ),
          );
        },
        failure: (error) {
          emit(
            state.copywith(
              apicallstate: ProductApiCallState.failure,
              error: error,
            ),
          );
        },
      );
      emit(state.copywith(apicallstate: ProductApiCallState.none));
    } catch (e) {
      emit(state.copywith(apicallstate: ProductApiCallState.busy));
      emit(state.copywith(apicallstate: ProductApiCallState.failure));
    }
  }

  fetchproducteventbyid(FetchProductsEventById event, emit) async {
    emit(state.copywith(apicallstate: ProductApiCallState.busy));
    try {
      final result = await productdatarepository.getproductbyid(event.id);
      emit(state.copywith(apicallstate: ProductApiCallState.busy));
      result.when(
        success: (data) {
          emit(
            state.copywith(
              apicallstate: ProductApiCallState.success,
              productdetailsmodel: result.data,
            ),
          );
        },
        failure: (error) {
          emit(
            state.copywith(
              apicallstate: ProductApiCallState.failure,
              error: error,
            ),
          );
        },
      );
      emit(state.copywith(apicallstate: ProductApiCallState.none));
    } catch (e) {
      emit(state.copywith(apicallstate: ProductApiCallState.busy));
      emit(state.copywith(apicallstate: ProductApiCallState.failure));
    }
  }

  fetchproductcategorylistevent(
    FetchProductCategoryListEvent event,
    emit,
  ) async {
    emit(state.copywith(apicallstate: ProductApiCallState.busy));
    try {
      final result = await productdatarepository.getproductcategorylist();
      emit(state.copywith(apicallstate: ProductApiCallState.busy));
      result.when(
        success: (data) {
          emit(
            state.copywith(
              apicallstate: ProductApiCallState.success,
              productcategorylist: result.data,
            ),
          );
        },
        failure: (error) {
          emit(
            state.copywith(
              apicallstate: ProductApiCallState.failure,
              error: error,
            ),
          );
        },
      );
      emit(state.copywith(apicallstate: ProductApiCallState.none));
    } catch (e) {
      emit(state.copywith(apicallstate: ProductApiCallState.busy));
      emit(state.copywith(apicallstate: ProductApiCallState.failure));
    }
  }
}

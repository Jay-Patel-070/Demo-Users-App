import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/components/searchbar_component.dart';
import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/screens/product/bloc/product_bloc.dart';
import 'package:demo_users_app/screens/product/bloc/product_event.dart';
import 'package:demo_users_app/screens/product/bloc/product_state.dart';
import 'package:demo_users_app/screens/product/data/product_datarepository.dart';
import 'package:demo_users_app/screens/product/data/product_datasource.dart';
import 'package:demo_users_app/screens/product/model/product_model.dart';
import 'package:demo_users_app/screens/product/product_detail_screen.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cm.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductBloc productbloc = ProductBloc(
    ProductDatarepository(ProductDatasource()),
  );
  ProductModel? productmodel;
  FocusNode searchfocusnode = FocusNode();
  TextEditingController searchproducts = TextEditingController();
  String? isselectedsort;
  String? iscategoryselected;
  List? productcategorylist;

  @override
  void initState() {
    // TODO: implement initState
    productbloc.add(FetchProductCategoryListEvent());
    productbloc.add(FetchAllProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      bloc: productbloc,
      listener: (context, state) {
        if (state.apicallstate == ProductApiCallState.success) {
          productmodel = state.productmodel;
          productcategorylist = state.productcategorylist;
          setState(() {

          });
        }
        if (state.apicallstate == ProductApiCallState.failure) {
          Cm.showSnackBar(context, message: state.error.toString());
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: AppbarComponent(title: AppLabels.products, centertitle: true),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 45,
                child: SearchbarComponent(
                  focusNode: searchfocusnode,
                  controller: searchproducts,
                  backgroundcolor: AppColors.greywithshade.withOpacity(0.2),
                  hintText: AppStrings.search_products_by_name_or_sku,
                  showborder: false,
                  onChanged: onChangedSearchBar,
                  onClear: onClearSearchBar,
                ),
              ).withPadding(
                padding: .symmetric(horizontal: AppPadding.lg)
              ),
              sb(10),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(AppPadding.xs),
                      child: Container(
                        alignment: Alignment.center,
                        padding: .all(AppPadding.xs),
                        child: PopupMenuButton<String>(
                          icon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.swap_vert,size: 18,color: isselectedsort == '' || isselectedsort == null ? AppColors.blackcolor : AppColors.primarycolor),
                              sbw(5),
                              if (isselectedsort == null || isselectedsort == '')
                              Text('sort'),
                              if (isselectedsort == "asc" ||
                                  isselectedsort == 'desc')
                                Text(
                                  isselectedsort.toString() == 'asc'
                                      ? 'A-Z'
                                      : 'Z-A',
                                  style: TextStyle(
                                     color: isselectedsort == '' ? AppColors.blackcolor : AppColors.primarycolor
                                  ),
                                ),
                            ],
                          ),
                          onSelected: onSelectedPopUpMenuButton,
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  enabled: false,
                                  child: Text(
                                    'Sort By',
                                    style: TextStyle(
                                      fontFamily: Appfonts.robotobold,
                                      fontSize: AppFontSizes.lg,
                                      color: AppColors.primarycolor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: .symmetric(
                                    horizontal: AppPadding.md,
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'asc',
                                  child: Text(
                                    'A-Z Sort',
                                    style: TextStyle(
                                      fontFamily: Appfonts.robotobold,
                                      fontSize: AppFontSizes.md,
                                      color: isselectedsort == 'asc'
                                          ? AppColors.primarycolor
                                          : AppColors.blackcolor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: .symmetric(
                                    horizontal: AppPadding.md,
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'desc',
                                  child: Text(
                                    'Z-A Sort',
                                    style: TextStyle(
                                      fontFamily: Appfonts.robotobold,
                                      fontSize: AppFontSizes.md,
                                      color: isselectedsort == 'desc'
                                          ? AppColors.primarycolor
                                          : AppColors.blackcolor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: .symmetric(
                                    horizontal: AppPadding.md,
                                  ),
                                ),
                              ],
                          padding: .symmetric(horizontal: AppPadding.md),
                          color: AppColors.whitecolor,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.greywithshade.withOpacity(0.2),
                          borderRadius: .circular(AppRadius.md),
                        ),
                      ),
                    ),
                    ...List.generate(productcategorylist?.length ?? 0, (
                      index,
                    ) {
                      return Padding(
                        padding: EdgeInsets.all(AppPadding.xs),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                iscategoryselected ==
                                    productcategorylist?[index]
                                ? AppColors.primarycolor
                                : AppColors.greywithshade.withOpacity(0.2),
                            borderRadius: .circular(AppRadius.circle),
                          ),
                          alignment: Alignment.center,
                          padding: .all(AppPadding.md),
                          child: Row(
                            children: [
                              Text(
                                '${productcategorylist?[index]}'.capitalizeFirst(),
                                style: TextStyle(
                                  color:
                                      iscategoryselected ==
                                          productcategorylist?[index]
                                      ? AppColors.whitecolor
                                      : AppColors.blackcolor,
                                ),
                              ),
                              sbw(5),
                              if (iscategoryselected ==
                                  productcategorylist?[index])
                                Icon(
                                  Icons.close,
                                  size: 18,
                                  color: AppColors.whitecolor,
                                ),
                            ],
                          ),
                        ),
                      ).onTap(() => onTapCategory(index));
                    }),
                  ],
                ),
              ),
              sb(20),
              BlocBuilder<ProductBloc, ProductState>(
                bloc: productbloc,
                builder: (context, state) {
                  if (state.apicallstate == ProductApiCallState.busy) {
                    return Expanded(
                      child: Center(child: CircularProgressIndicator(color: AppColors.primarycolor)),
                    );
                  }
                  if (productmodel != null &&
                      productmodel?.products != null) {
                    final list = productmodel?.products;
                    return productmodel?.products?.isEmpty == true
                        ? Expanded(
                            child: Center(child: Text('No Products Found')),
                          )
                        : Expanded(
                            flex: 10,
                            child: RefreshIndicator(
                              color: AppColors.primarycolor,
                              backgroundColor: AppColors.whitecolor,
                              onRefresh: onReferesh,
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.65,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                    ),
                                itemCount: list?.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final fields = list?[index];
                                  return productItemCard(
                                    imageUrl: fields?.thumbnail,
                                    title: fields?.title,
                                    price: "\$${fields?.price}",
                                    ontap: () =>
                                        onTapProductItemCard(fields?.id),
                                  );
                                },
                              ),
                            ).withPadding(
                                padding: .symmetric(horizontal: AppPadding.lg)
                            ),
                          );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productItemCard({
    String? imageUrl,
    String? title,
    String? price,
    VoidCallback? ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.greywithshade.withOpacity(0.2),
          ),
          color: AppColors.whitecolor,
          borderRadius: .circular(AppRadius.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppRadius.xl),
                ),
                child: Image.network(
                  imageUrl ?? '',
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppPadding.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppFontSizes.lg,
                      fontFamily: Appfonts.robotomedium,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    price ?? '',
                    style: TextStyle(
                      fontSize: AppFontSizes.lg,
                      fontFamily: Appfonts.robotomedium,
                      color: AppColors.primarycolor
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onChangedSearchBar(String value) {
    if (value.isEmpty) {
      productbloc.add(FetchAllProductsEvent());
    } else {
      setState(() {
        isselectedsort = '';
        iscategoryselected = null;
        productbloc.add(FetchAllProductsEvent(search: value));
      });
    }
  }

  onClearSearchBar() {
    searchproducts.clear();
    FocusScope.of(context).unfocus();
    productbloc.add(FetchAllProductsEvent());
  }

  onSelectedPopUpMenuButton(String value) {
    if (value == 'asc' || value == 'desc') {
      searchproducts.clear();
      isselectedsort = value;
      iscategoryselected = null;
      productbloc.add(FetchAllProductsEvent(sortBy: isselectedsort));
      FocusScope.of(context).unfocus();
      searchfocusnode.unfocus();
      setState(() {});
    }
  }

  onTapCategory(int index) {
    if (iscategoryselected == productcategorylist?[index]) {
      // remove selection
      iscategoryselected = null;
      productbloc.add(FetchAllProductsEvent());
      setState(() {

      });
    } else {
      // apply new selection
      searchfocusnode.unfocus();
      searchproducts.clear();
      isselectedsort = '';
      iscategoryselected = productcategorylist?[index];
      productbloc.add(
        FetchAllProductsEvent(category: productcategorylist?[index]),
      );
    }
    setState(() {});
  }

  Future<void> onReferesh() async {
    searchfocusnode.unfocus();
    searchproducts.clear();
    isselectedsort = '';
    iscategoryselected = null;
    productbloc.add(FetchAllProductsEvent());
    setState(() {});
  }

  onTapProductItemCard(int? id) {
    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductDetailScreen(id: id)),
    );
  }
}

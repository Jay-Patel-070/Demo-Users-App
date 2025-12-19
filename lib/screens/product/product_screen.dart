import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/components/searchbar_component.dart';
import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/screens/notification/notification_screen.dart';
import 'package:demo_users_app/screens/product/bloc/product_bloc.dart';
import 'package:demo_users_app/screens/product/bloc/product_event.dart';
import 'package:demo_users_app/screens/product/bloc/product_state.dart';
import 'package:demo_users_app/screens/product/data/product_datarepository.dart';
import 'package:demo_users_app/screens/product/data/product_datasource.dart';
import 'package:demo_users_app/screens/product/product_detail_screen.dart';
import 'package:demo_users_app/screens/product/product_item_card.dart';
import 'package:demo_users_app/screens/product/productcategorygraph_screen.dart';
import 'package:demo_users_app/screens/product/shimmer/product_screen_shimmers.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cm.dart';

class ProductScreen extends StatefulWidget {
  bool? isfromnotificationtap;
  ProductScreen({super.key,this.isfromnotificationtap});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductBloc productbloc = ProductBloc(
    ProductDatarepository(ProductDatasource()),
  );
  FocusNode searchfocusnode = FocusNode();
  TextEditingController searchproducts = TextEditingController();
  String? isselectedsort;
  String? iscategoryselected;
  final ScrollController scrollController = ScrollController();
  final ScrollController sortlistscrollController = ScrollController();
  ValueNotifier<int> scrollNotifier = ValueNotifier(-1);
  bool hadFocusBeforeScroll = false;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.isfromnotificationtap == true){
    callNextScreenWithResult(context, NotificationScreen(),).then((value) {
      widget.isfromnotificationtap = value;
    },);
    }
    productbloc.add(FetchProductCategoryListEvent());
    productbloc.add(FetchAllProductsEvent(skip: 0));
    scrollController.addListener(scrollPosition);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void scrollDown() {
    final double goDown = scrollController.position.maxScrollExtent;
    scrollController.animateTo(
      goDown,
      duration: Duration(seconds: 1),
      curve: Curves.easeInCirc,
    );
  }

  void scrollUp() {
    final double goUp = scrollController.position.minScrollExtent;
    scrollController.animateTo(
      goUp,
      duration: Duration(seconds: 1),
      curve: Curves.easeInCirc,
    );
  }

  void scrollPosition() {
    bool canApiCall = true;
    final position = scrollController.position.pixels;
    final min = scrollController.position.minScrollExtent;
    final max = scrollController.position.maxScrollExtent;
    double mid = max / 2;
    if (position == min || position == max) {
      scrollNotifier.value = -1;
    } else if (position < mid) {
      scrollNotifier.value = 0;
    } else if (position > mid) {
      scrollNotifier.value = 1;
    }
    if (position > 300) {
      if (searchfocusnode.hasFocus) {
        hadFocusBeforeScroll = true;
        // searchfocusnode.unfocus();
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
    }

    if (position <= min) {
      if (hadFocusBeforeScroll /*&& !searchfocusnode.hasFocus*/ ) {
        //   searchfocusnode.requestFocus();
        SystemChannels.textInput.invokeMethod('TextInput.show');
      }
    }
    if (position == max) {
      if (iscategoryselected.isNotNullOrEmpty() ||
          isselectedsort.isNotNullOrEmpty() ||
          searchproducts.text.isNotEmpty ||
          productbloc.state.productModel!.products!.length ==
              productbloc.state.productModel!.total!) {
        canApiCall = false;
      } else {
        canApiCall = true;
      }

      if (canApiCall &&
          productbloc.state.loadmoreProductState != ApiCallState.busy) {
        // if (productbloc.state.productModel!.products!.length <
        //     productbloc.state.productModel!.total!) {
        //   if (productbloc.state.loadmoreProductState != ApiCallState.busy) {
        productbloc.add(
          FetchAllProductsEvent(
            skip: productbloc.state.productModel?.products?.length ?? 0,
          ),
        );
        //   }
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return BlocListener<ProductBloc, ProductState>(
      bloc: productbloc,
      listener: (context, state) {
        if (state.productapicallstate == ApiCallState.failure) {
          Cm.showSnackBar(context, message: state.error.toString());
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: AppbarComponent(
            title: AppLabels.products,
            centertitle: true,
            actions: [
              IconButton(onPressed: () {
                callNextScreen(context, ProductcategorygraphScreen());
              }, icon: Icon(Icons.bar_chart)),
              IconButton(onPressed: () {
                callNextScreen(context, NotificationScreen());
              }, icon: Icon(Icons.notifications_outlined)),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SearchbarComponent(
                focusNode: searchfocusnode,
                controller: searchproducts,
                hintText: AppStrings.search_products_by_name_or_sku,
                onChanged: onChangedSearchBar,
                onClear: onClearSearchBar,
                // readOnly: !hadFocusBeforeScroll,
              ).withPadding(padding: .symmetric(horizontal: AppPadding.lg)),
              sb(10),
              BlocBuilder<ProductBloc, ProductState>(
                bloc: productbloc,
                builder: (context, state) {
                  return Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView(
                            padding: .symmetric(horizontal: AppPadding.lg),
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            controller: sortlistscrollController,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(AppPadding.xs),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: .all(AppPadding.xs),
                                  decoration: BoxDecoration(
                                    color: AppColors.greywithshade.withOpacity(
                                      0.2,
                                    ),
                                    borderRadius: .circular(AppRadius.md),
                                  ),
                                  child: PopupMenuButton<String>(
                                    icon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.swap_vert,
                                          size: 18,
                                          color:
                                              isselectedsort == '' ||
                                                  isselectedsort == null
                                              ? null
                                              : AppColors.primarycolor,
                                        ),
                                        sbw(5),
                                        if (isselectedsort == null ||
                                            isselectedsort == '')
                                          Text('sort'),
                                        if (isselectedsort == "asc" ||
                                            isselectedsort == 'desc')
                                          Text(
                                            isselectedsort.toString() == 'asc'
                                                ? 'A-Z'
                                                : 'Z-A',
                                            style: TextStyle(
                                              color: isselectedsort == ''
                                                  ? null
                                                  : AppColors.primarycolor,
                                            ),
                                          ),
                                      ],
                                    ),
                                    onSelected: onSelectedPopUpMenuButton,
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                            enabled: false,
                                            padding: .symmetric(
                                              horizontal: AppPadding.md,
                                            ),
                                            child: Text(
                                              'Sort By',
                                              style: TextStyle(
                                                fontFamily: Appfonts.robotobold,
                                                fontSize: AppFontSizes.lg,
                                                color: AppColors.primarycolor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'asc',
                                            padding: .symmetric(
                                              horizontal: AppPadding.md,
                                            ),
                                            child: Text(
                                              'A-Z Sort',
                                              style: TextStyle(
                                                fontFamily: Appfonts.robotobold,
                                                fontSize: AppFontSizes.md,
                                                color: isselectedsort == 'asc'
                                                    ? AppColors.primarycolor
                                                    : null,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'desc',
                                            padding: .symmetric(
                                              horizontal: AppPadding.md,
                                            ),
                                            child: Text(
                                              'Z-A Sort',
                                              style: TextStyle(
                                                fontFamily: Appfonts.robotobold,
                                                fontSize: AppFontSizes.md,
                                                color: isselectedsort == 'desc'
                                                    ? AppColors.primarycolor
                                                    : null,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                    padding: .symmetric(
                                      horizontal: AppPadding.md,
                                    ),
                                  ),
                                ),
                              ),
                              ...List.generate(
                                state.productcategorylist?.length ?? 0,
                                (index) {
                                  return Padding(
                                    padding: EdgeInsets.all(AppPadding.xs),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            iscategoryselected ==
                                                state
                                                    .productcategorylist?[index]
                                            ? AppColors.primarycolor
                                            : AppColors.greywithshade
                                                  .withOpacity(0.2),
                                        borderRadius: .circular(
                                          AppRadius.circle,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      padding: .all(AppPadding.md),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${state.productcategorylist?[index]}'
                                                .capitalize(),
                                            style: TextStyle(
                                              color:
                                                  iscategoryselected ==
                                                      state
                                                          .productcategorylist?[index]
                                                  ? AppColors.whitecolor
                                                  : null,
                                            ),
                                          ),
                                          sbw(5),
                                          if (iscategoryselected ==
                                              state.productcategorylist?[index])
                                            Icon(
                                              Icons.close,
                                              size: 18,
                                              color: AppColors.whitecolor,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ).onTapEvent(() => onTapCategory(index));
                                },
                              ),
                            ],
                          ),
                        ),
                        if (state.productapicallstate == ApiCallState.busy)
                          Expanded(
                            child: gridShimmer(itemCount: 6), // initial shimmer
                          )
                        else
                          if(state.productModel?.products?.isEmpty == true)
                            Expanded(child: Center(child: Text(AppStrings.no_products_found)))
                          else
                            Expanded(
                            // flex: 10,
                              child: RefreshIndicator(
                              color: AppColors.primarycolor,
                              onRefresh: onReferesh,
                              child: ListView(
                                controller: scrollController,
                                children: [
                                  GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.65,
                                          mainAxisSpacing: 15,
                                          crossAxisSpacing: 15,
                                        ),
                                    itemCount:
                                        state.productModel?.products?.length ??
                                        0,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: .symmetric(
                                      horizontal: AppPadding.lg,
                                      vertical: AppPadding.sm,
                                    ),
                                    itemBuilder: (context, index) {
                                      return productItemCard(
                                        imageUrl: state
                                            .productModel
                                            ?.products?[index]
                                            .thumbnail,
                                        title: state
                                            .productModel
                                            ?.products?[index]
                                            .title,
                                        price:
                                            "\$${state.productModel?.products?[index].price}",
                                        ontap: () => onTapProductItemCard(
                                          state
                                              .productModel
                                              ?.products?[index]
                                              .id,
                                        ),
                                      );
                                    },
                                  ),
                                  if (state.loadmoreProductState ==
                                      ApiCallState.busy)
                                    Padding(
                                      padding: EdgeInsets.all(AppPadding.md),
                                      child: SizedBox(
                                        height: 150,
                                        child: gridShimmer(itemCount: 2), // small shimmer at bottom
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: (context, value, child) {
            IconData icon = Icons.arrow_downward_sharp;
            if (value == 0) {
              icon = Icons.arrow_downward_sharp;
            } else if (value == 1) {
              icon = Icons.arrow_upward_sharp;
            }
            return AnimatedOpacity(
              opacity: value == -1 ? 0 : 1,
              duration: Duration(milliseconds: 300),
              child: FloatingActionButton.small(
                onPressed: () {
                  if (value == 0) {
                    scrollDown();
                  } else if (value == 1) {
                    scrollUp();
                  }
                },
                child: Icon(icon, color: AppColors.whitecolor),
                backgroundColor: AppColors.primarycolor,
              ),
            );
          },
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
      hadFocusBeforeScroll = false;
      productbloc.add(FetchAllProductsEvent(sortBy: isselectedsort));
      FocusScope.of(context).unfocus();
      searchfocusnode.unfocus();
      setState(() {});
    }
  }

  onTapCategory(int index) {
    if (iscategoryselected == productbloc.state.productcategorylist?[index]) {
      // remove selection
      iscategoryselected = null;
      productbloc.add(FetchAllProductsEvent());
      setState(() {});
    } else {
      // apply new selection
      searchfocusnode.unfocus();
      hadFocusBeforeScroll = false;
      searchproducts.clear();
      isselectedsort = '';
      iscategoryselected = productbloc.state.productcategorylist?[index];
      productbloc.add(
        FetchAllProductsEvent(
          category: productbloc.state.productcategorylist?[index],
        ),
      );
    }
    setState(() {});
  }

  Future<void> onReferesh() async {
    searchfocusnode.unfocus();
    searchproducts.clear();
    isselectedsort = '';
    iscategoryselected = null;
    hadFocusBeforeScroll = false;
    productbloc.add(FetchProductCategoryListEvent());
    productbloc.add(FetchAllProductsEvent());
    sortlistscrollController.animateTo(
      0,
      curve: Curves.linear,
      duration: Duration(milliseconds: 400),
    );
    setState(() {});
  }

  onTapProductItemCard(int? id) {
    searchfocusnode.unfocus();
    callNextScreenWithResult(context, ProductDetailScreen(id: id)).then((
      value,
    ) {
      if (value != null) {
        Cm.showSnackBar(
          context,
          message: '$value ${AppStrings.added_to_cart}',
          bg: AppColors.greencolor,
        );
        productbloc.add(FetchAllProductsEvent());
      }
    });
  }
}

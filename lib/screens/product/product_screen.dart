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
import 'package:demo_users_app/screens/product/product_item_card.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cm.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  final ProductBloc productbloc = ProductBloc(
    ProductDatarepository(ProductDatasource()),
  );
  ProductModel? productmodel;
  FocusNode searchfocusnode = FocusNode();
  TextEditingController searchproducts = TextEditingController();
  String? isselectedsort;
  String? iscategoryselected;
  List? productcategorylist;
  final ScrollController scrollController = ScrollController();
  final ScrollController sortlistscrollController = ScrollController();
  ValueNotifier<int> scrollNotifier = ValueNotifier(-1);
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    productbloc.add(FetchProductCategoryListEvent());
    productbloc.add(FetchAllProductsEvent());
    scrollController.addListener(scrollPosition);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return BlocListener<ProductBloc, ProductState>(
      bloc: productbloc,
      listener: (context, state) {
        if (state.apicallstate == ProductApiCallState.success) {
          productmodel = state.productmodel;
          productcategorylist = state.productcategorylist;
          setState(() {});
        }
        if (state.apicallstate == ProductApiCallState.failure) {
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
              IconButton(onPressed: onReferesh, icon: Icon(Icons.refresh)),
            ],
          ),
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
              ).withPadding(padding: .symmetric(horizontal: AppPadding.lg)),
              sb(10),
              SizedBox(
                height: 50,
                child: ListView(
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
                          color: AppColors.greywithshade.withOpacity(0.2),
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
                                    ? AppColors.blackcolor
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
                                        ? AppColors.blackcolor
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
                                          : AppColors.blackcolor,
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
                                          : AppColors.blackcolor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                          padding: .symmetric(horizontal: AppPadding.md),
                          color: AppColors.whitecolor,
                        ),
                      ),
                    ),
                    ...List.generate(productcategorylist?.length ?? 0, (index) {
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
                                '${productcategorylist?[index]}'
                                    .capitalize(),
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
                      ).onTapEvent(() => onTapCategory(index));
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 48,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.primarycolor,
                  labelColor: AppColors.primarycolor,
                  unselectedLabelColor: AppColors.greywithshade,
                  tabs: [
                    Tab(
                      child: Text(
                        'Grid',
                        style: TextStyle(
                          fontSize: AppFontSizes.lg,
                          fontFamily: Appfonts.robotobold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'List',
                        style: TextStyle(
                          fontSize: AppFontSizes.lg,
                          fontFamily: Appfonts.robotobold,
                        ),
                      ),
                    ),
                  ],
                  dividerColor: AppColors.greywithshade.withOpacity(0.2),
                ),
              ),
              sb(10),
              BlocBuilder<ProductBloc, ProductState>(
                bloc: productbloc,
                builder: (context, state) {
                  if (state.apicallstate == ProductApiCallState.busy) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primarycolor,
                        ),
                      ),
                    );
                  }
                  if (productmodel != null && productmodel?.products != null) {
                    final list = productmodel?.products;
                    return productmodel?.products?.isEmpty == true
                        ? Expanded(
                            child: Center(child: Text('No Products Found')),
                          )
                        : Expanded(
                            // flex: 10,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                RefreshIndicator(
                                  color: AppColors.primarycolor,
                                  backgroundColor: AppColors.whitecolor,
                                  onRefresh: onReferesh,
                                  child:
                                      GridView.builder(
                                        controller: scrollController,
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
                                            ontap: () => onTapProductItemCard(
                                              fields?.id,
                                            ),
                                          );
                                        },
                                      ).withPadding(
                                        padding: .symmetric(
                                          horizontal: AppPadding.lg,
                                        ),
                                      ),
                                ),
                                RefreshIndicator(
                                  color: AppColors.primarycolor,
                                  backgroundColor: AppColors.whitecolor,
                                  onRefresh: onReferesh,
                                  child: ListView.builder(
                                    controller: scrollController,
                                    itemCount: list?.length,
                                    itemBuilder: (context, index) {
                                      final fields = list?[index];
                                      return listItemCard(
                                        imageUrl: fields?.thumbnail,
                                        title: fields?.title,
                                        price: "\$${fields?.price}",
                                        ontap: () =>
                                            onTapProductItemCard(fields?.id),
                                      ).withPadding(
                                        padding: .only(
                                          bottom: 12,
                                          left: AppPadding.lg,
                                          right: AppPadding.lg,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                    // productmodel?.products?.isEmpty == true
                    //   ? Expanded(
                    //       child: Center(child: Text('No Products Found')),
                    //     )
                    //   : Expanded(
                    //       flex: 10,
                    //       child: RefreshIndicator(
                    //         color: AppColors.primarycolor,
                    //         backgroundColor: AppColors.whitecolor,
                    //         onRefresh: onReferesh,
                    //         child: GridView.builder(
                    //           controller: scrollController,
                    //           gridDelegate:
                    //               SliverGridDelegateWithFixedCrossAxisCount(
                    //                 crossAxisCount: 2,
                    //                 childAspectRatio: 0.65,
                    //                 mainAxisSpacing: 15,
                    //                 crossAxisSpacing: 15,
                    //               ),
                    //           itemCount: list?.length,
                    //           physics: BouncingScrollPhysics(),
                    //           itemBuilder: (context, index) {
                    //             final fields = list?[index];
                    //             return productItemCard(
                    //               imageUrl: fields?.thumbnail,
                    //               title: fields?.title,
                    //               price: "\$${fields?.price}",
                    //               ontap: () =>
                    //                   onTapProductItemCard(fields?.id),
                    //             );
                    //           },
                    //         ),
                    //       ).withPadding(
                    //           padding: .symmetric(horizontal: AppPadding.lg)
                    //       ),
                    //     );
                  }
                  return Container();
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

  Widget listItemCard({
    String? imageUrl,
    String? title,
    String? price,
    VoidCallback? ontap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: .circular(AppRadius.md),
        color: AppColors.whitecolor,
        border: Border.all(color: AppColors.greywithshade.withOpacity(0.2)),
      ),
      padding: EdgeInsets.all(AppPadding.md),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Image.network(imageUrl ?? '', fit: BoxFit.contain),
            ),
          ),
          sbw(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: Appfonts.robotomedium,
                    fontSize: AppFontSizes.lg,
                  ),
                ),
                sb(6),
                Text(
                  price ?? '',
                  style: TextStyle(
                    color: AppColors.primarycolor,
                    fontSize: AppFontSizes.lg,
                    fontFamily: Appfonts.robotomedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).onTapEvent(ontap!,);
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
      setState(() {});
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
          message: '$value Added to cart',
          bg: AppColors.greencolor,
        );
        productbloc.add(FetchAllProductsEvent());
      }
    });
  }
}

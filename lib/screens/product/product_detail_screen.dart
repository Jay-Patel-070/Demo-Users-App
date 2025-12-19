import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/button_component.dart';
import 'package:demo_users_app/screens/product/bloc/product_bloc.dart';
import 'package:demo_users_app/screens/product/bloc/product_event.dart';
import 'package:demo_users_app/screens/product/bloc/product_state.dart';
import 'package:demo_users_app/screens/product/data/product_datarepository.dart';
import 'package:demo_users_app/screens/product/data/product_datasource.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final int? id;
  ProductDetailScreen({required this.id, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductBloc productbloc = ProductBloc(
    ProductDatarepository(ProductDatasource()),
  );
  bool show = false;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.id != null) {
      productbloc.add(FetchProductsEventById(widget.id!));
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    productbloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      bloc: productbloc,
      listener: (context, state) {
        if (state.productapicallstate == ApiCallState.failure) {
          Cm.showSnackBar(
            context,
            message: AppStrings.error_fetching_product_details,
          );
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        bloc: productbloc,
        builder: (context, state) {
          return Scaffold(
            body: state.productapicallstate == ApiCallState.busy
                ? Center(child: Cm.showLoader())
                : Stack(
                  children: [
                    CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            pinned: true,
                            expandedHeight: 300,
                            flexibleSpace: LayoutBuilder(
                              builder: (context, constraints) {
                                final collapsed = constraints.maxHeight < 120;
                                return FlexibleSpaceBar(
                                  collapseMode: CollapseMode.none,
                                  title: AnimatedOpacity(
                                    opacity: collapsed ? 1 : 0,
                                    duration: Duration(milliseconds: 100),
                                    child: Text(
                                      AppLabels.product_details,
                                      style: TextStyle(
                                        fontSize: AppFontSizes.xxl,
                                        fontFamily: Appfonts.robotobold,
                                      ),
                                    ),
                                  ),
                                  centerTitle: true,
                                  background: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          state.productdetailsmodel?.thumbnail ??
                                              '',
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: .symmetric(horizontal: 16),
                              children: [
                                sb(16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.productdetailsmodel?.title ?? '',
                                        style: TextStyle(
                                          fontSize: AppFontSizes.display,
                                          fontFamily: Appfonts.robotobold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "\$${state.productdetailsmodel?.price}",
                                      style: TextStyle(
                                        fontSize: AppFontSizes.display,
                                        fontFamily: Appfonts.robotobold,
                                        color: AppColors.primarycolor,
                                      ),
                                    ),
                                  ],
                                ),
                                sb(10),
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(AppPadding.xs),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.greywithshade
                                                .withOpacity(0.2),
                                            borderRadius: .circular(AppRadius.md),
                                          ),
                                          alignment: Alignment.center,
                                          padding: .all(AppPadding.md),
                                          child: Text(
                                            state
                                                    .productdetailsmodel
                                                    ?.tags?[index] ??
                                                '',
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount:
                                        state.productdetailsmodel?.tags?.length ??
                                        0,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                                expansionTileSection(
                                  title: AppLabels.product_description,
                                  content: Text(
                                    state.productdetailsmodel?.description ?? '',
                                    style: TextStyle(
                                      fontSize: AppFontSizes.md,
                                      height: 1.4,
                                      fontFamily: Appfonts.robotomedium,
                                      color: AppColors.greywithshade,
                                    ),
                                  ),
                                  initiallyExpanded: true,
                                ),
                                expansionTileSection(
                                  title: AppLabels.product_details,
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      infoRow(
                                        AppLabels.stock,
                                        state.productdetailsmodel?.stock
                                                .toString() ??
                                            '',
                                      ),
                                      infoRow(
                                        AppLabels.sku,
                                        state.productdetailsmodel?.sku ?? '',
                                      ),
                                      infoRow(
                                        AppLabels.weight,
                                        "${state.productdetailsmodel?.weight}",
                                      ),
                                      infoRow(
                                        AppLabels.discount,
                                        "${state.productdetailsmodel?.discountPercentage}%",
                                      ),
                                      infoRow(
                                        AppLabels.warranty,
                                        "${state.productdetailsmodel?.warrantyInformation}",
                                      ),
                                      infoRow(
                                        AppLabels.shipping,
                                        "${state.productdetailsmodel?.shippingInformation}",
                                      ),
                                      infoRow(
                                        AppLabels.return_policy,
                                        "${state.productdetailsmodel?.returnPolicy}",
                                      ),
                                    ],
                                  ),
                                ),
                                expansionTileSection(
                                  title: AppLabels.dimensions,
                                  content: Column(
                                    children: [
                                      infoRow(
                                        AppLabels.width,
                                        "${state.productdetailsmodel?.dimensions?.width}",
                                      ),
                                      infoRow(
                                        AppLabels.height,
                                        "${state.productdetailsmodel?.dimensions?.height}",
                                      ),
                                      infoRow(
                                        AppLabels.depth,
                                        "${state.productdetailsmodel?.dimensions?.depth}",
                                      ),
                                    ],
                                  ),
                                ),
                                expansionTileSection(
                                  title: AppLabels.reviews,
                                  content: ListView.builder(
                                    padding: .all(0),
                                    itemCount:
                                        state
                                            .productdetailsmodel
                                            ?.reviews
                                            ?.length ??
                                        0,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return reviewCard(
                                        name:
                                            state
                                                .productdetailsmodel
                                                ?.reviews?[index]
                                                .reviewerName ??
                                            '',
                                        rating:
                                            state
                                                .productdetailsmodel
                                                ?.reviews?[index]
                                                .rating ??
                                            0,
                                        comment:
                                            state
                                                .productdetailsmodel
                                                ?.reviews?[index]
                                                .comment ??
                                            '',
                                      );
                                    },
                                  ),
                                ),
                                sb(200),
                              ],
                            ),
                          ),
                        ],
                      ),
                    Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: AppPadding.lg,
                        right: AppPadding.lg,
                        bottom: AppPadding.lg,
                      ),
                      child: ButtonComponent(
                        ontap: () {
                          Navigator.pop(context, state.productdetailsmodel?.title);
                        },
                        buttontitle: AppLabels.add_to_cart,
                      ),
                    ),)
                  ],
                ),
          );
        },
      ),
    );
  }

  // ---------- UI COMPONENTS ----------
  Widget infoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppFontSizes.md,
              color: AppColors.greywithshade,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: AppFontSizes.md,
              fontFamily: Appfonts.roboto,
            ),
          ),
        ],
      ),
    );
  }

  Widget reviewCard({
    required String name,
    required int rating,
    required String comment,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.xs),
      child: Container(
        padding: EdgeInsets.all(AppPadding.md),
        decoration: BoxDecoration(
          color: AppColors.greywithshade.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.greywithshade.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name + Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: AppFontSizes.lg,
                    fontFamily: Appfonts.robotomedium,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: AppColors.rating, size: 18),
                    sbw(4),
                    Text(rating.toString()),
                  ],
                ),
              ],
            ),
            sb(6),
            Text(
              comment,
              style: TextStyle(fontSize: AppFontSizes.md, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget expansionTileSection({
    required String title,
    required Widget content,
    bool initiallyExpanded = false,
  }) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppFontSizes.lg,
          fontFamily: Appfonts.robotobold,
        ),
      ),
      tilePadding: .all(0),
      children: [content],
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.transparent),
      ),
      collapsedShape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.transparent),
      ),
    );
  }
}

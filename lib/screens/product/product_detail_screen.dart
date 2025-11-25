import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/components/button_component.dart';
import 'package:demo_users_app/extension.dart';
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
        if (state.apicallstate == ProductApiCallState.failure) {
          print('error');
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        bloc: productbloc,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(preferredSize: Size(double.infinity, 50), child: AppbarComponent(title: AppLabels.product_details,centertitle: true,)),
            body: state.apicallstate == ProductApiCallState.busy
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: .symmetric(horizontal: 16),
                    children: [
                      // ---------- Product Image ----------
                      Container(
                         height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.greycolor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          image: DecorationImage(
                            image: NetworkImage(
                              state.productdetailsmodel?.thumbnail ?? '',
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      sb( 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              state.productdetailsmodel?.title ?? '',
                              style: TextStyle(
                                fontSize: AppFontSizes.display,
                                fontFamily: Appfonts.robotobold
                              ),
                            ),
                          ),
                          Text(
                            "₹${state.productdetailsmodel?.price}",
                            style: TextStyle(
                              fontSize: AppFontSizes.display,
                              fontFamily: Appfonts.robotobold,
                              color: AppColors.primarycolor,
                            ),
                          ),
                        ],
                      ),
                      sb( 20),
                      expansionTileSection(
                        title: "Product Description",
                        content: Text(
                          state.productdetailsmodel?.description ?? '',
                          style: TextStyle(
                            fontSize: AppFontSizes.md,
                             height: 1.4,
                            fontFamily: Appfonts.robotomedium,
                            color: AppColors.greywithshade
                          ),
                        ),
                        initiallyExpanded: true,
                      ),
                      expansionTileSection(
                        title: "Product Details",
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            infoRow(
                              "Stock",
                              state.productdetailsmodel?.stock.toString() ?? '',
                            ),
                            infoRow(
                              "SKU",
                              state.productdetailsmodel?.sku ?? '',
                            ),
                            infoRow(
                              "Weight",
                              "${state.productdetailsmodel?.weight}",
                            ),
                            infoRow(
                              "Discount",
                              "${state.productdetailsmodel?.discountPercentage}%",
                            ),
                            infoRow(
                              "Warranty",
                              "${state.productdetailsmodel?.warrantyInformation}",
                            ),
                            infoRow(
                              "Shipping",
                              "${state.productdetailsmodel?.shippingInformation}",
                            ),
                            infoRow(
                              "Return Policy",
                              "${state.productdetailsmodel?.returnPolicy}",
                            ),
                          ],
                        ),
                      ),
                      expansionTileSection(
                        title: "Dimensions",
                        content: Column(
                          children: [
                            infoRow(
                              "Width",
                              "${state.productdetailsmodel?.dimensions?.width}",
                            ),
                            infoRow(
                              "Height",
                              "${state.productdetailsmodel?.dimensions?.height}",
                            ),
                            infoRow(
                              "Depth",
                              "${state.productdetailsmodel?.dimensions?.depth}",
                            ),
                          ],
                        ),
                      ),
                      expansionTileSection(
                        title: "Reviews",
                        content: ListView.builder(
                          itemCount:
                              state.productdetailsmodel?.reviews?.length ?? 0,
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
            bottomSheet: Padding(
              padding: EdgeInsets.only(left: AppPadding.lg, right: AppPadding.lg, bottom: AppPadding.lg),
              child: ButtonComponent(ontap: () {

              }, buttontitle: AppLabels.add_to_cart),
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
            style: TextStyle(fontSize: AppFontSizes.md, color: AppColors.greywithshade),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: AppFontSizes.md,
              fontFamily: Appfonts.roboto
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
                    fontFamily: Appfonts.robotomedium
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
            sb( 6),
            Text(
              comment,
              style: TextStyle(fontSize: AppFontSizes.md,  height: 1.3),
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
          fontFamily: Appfonts.robotobold
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
      iconColor: AppColors.blackcolor,
      collapsedIconColor: AppColors.blackcolor,
    );
  }
}

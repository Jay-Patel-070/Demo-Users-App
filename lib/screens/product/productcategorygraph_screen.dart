import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/screens/product/bloc/product_bloc.dart';
import 'package:demo_users_app/screens/product/bloc/product_event.dart';
import 'package:demo_users_app/screens/product/bloc/product_state.dart';
import 'package:demo_users_app/screens/product/data/product_datarepository.dart';
import 'package:demo_users_app/screens/product/data/product_datasource.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductcategorygraphScreen extends StatefulWidget {
  const ProductcategorygraphScreen({super.key});

  @override
  State<ProductcategorygraphScreen> createState() => _ProductcategorygraphScreenState();
}

class _ProductcategorygraphScreenState extends State<ProductcategorygraphScreen> {
  final ProductBloc productBloc = ProductBloc(ProductDatarepository(ProductDatasource()));
  int? touchedIndex;
  @override
  void initState() {
    // TODO: implement initState
    productBloc.add(FetchAllProductsEvent(skip: 0,limit: 195));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity, 50),
          child: AppbarComponent(title: 'Category-wise Available Products')),
      body: SafeArea(child: BlocBuilder<ProductBloc, ProductState>(
        bloc: productBloc,
        builder: (context, state) {
          if (state.productapicallstate == ApiCallState.busy) {
            return Center(child: Cm.showLoader());
          }

          if (state.productapicallstate == ApiCallState.failure) {
            return Center(child: Text(state.error.toString()));
          }

          // if (state.productapicallstate == ApiCallState.success) {
            final categoryCount =
            getCategoryWiseProductCount(state.productModel?.products ?? []);

          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 80,
                  sections: List.generate(categoryCount.length, (i) {
                    final isTouched = i == touchedIndex;
                    final categoryName = categoryCount.keys.toList()[i];
                    final value = categoryCount.values.toList()[i];
                    return PieChartSectionData(
                      value: value.toDouble(),
                      title: /*isTouched ? */'$categoryName: $value'/* : ''*/,
                      radius: isTouched ? 120 : 100,
                      titleStyle: TextStyle(
                        fontSize: AppFontSizes.md,
                        fontWeight: FontWeight.bold,
                      ),
                      showTitle: true,
                      titlePositionPercentageOffset: isTouched ? -0.65 : 0.7,
                      color: AppColors.greencolor
                    );
                  }),
                  sectionsSpace: 2,
                  pieTouchData: PieTouchData(
                    touchCallback: (event, response) {
                      setState(() {
                        if (response != null &&
                            response.touchedSection != null) {
                          touchedIndex = response.touchedSection!.touchedSectionIndex;
                        } else {
                          touchedIndex = null;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          );
          }
        //   return const SizedBox();
        // },
      )
      ),
    );
  }
  Map<String, int> getCategoryWiseProductCount(List products) {
    final Map<String, int> map = {};

    for (final product in products) {
      map[product.category] =
          (map[product.category] ?? 0) + 1;
    }
    print('Map ------> $map');

    return map;
  }

}

import 'package:demo_users_app/components/button_component.dart';
import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/main.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class productItemCard extends StatefulWidget {
  const productItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.ontap,
  });

  final String? imageUrl;
  final String? title;
  final String? price;
  final VoidCallback? ontap;

  @override
  State<productItemCard> createState() => _productItemCardState();
}

class _productItemCardState extends State<productItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greywithshade.withValues(alpha: 0.01),
        border: Border.all(
          width: 1,
          color: AppColors.greywithshade.withOpacity(0.2),
        ),
        borderRadius: .circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: AppColors.greywithshade.withOpacity(0.06),  // very soft black (Card default)
            blurRadius: 3,
            spreadRadius: 2,
            offset: Offset(3, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppRadius.xl),
              ),
              child: Image.network(
                widget.imageUrl ?? '',
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
                  widget.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppFontSizes.lg,
                    fontFamily: Appfonts.robotomedium,
                  ),
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      widget.price ?? '',
                      style: TextStyle(
                        fontSize: AppFontSizes.lg,
                        fontFamily: Appfonts.robotomedium,
                        color: AppColors.primarycolor,
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Icon(Icons.shopping_cart_outlined),
                    //     TextButton(onPressed: () {
                    //
                    //     }, child: Text('Add To Cart',style: TextStyle(color: AppColors.blackcolor),))
                    //   ],
                    // )
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    ).onTapEvent(widget.ontap!,);
  }
}

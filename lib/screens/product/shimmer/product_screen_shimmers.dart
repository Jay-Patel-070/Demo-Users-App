import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget productCardShimmer() {
  return Shimmer.fromColors(
    baseColor: AppColors.greywithshade.withValues(alpha: 0.7),
    highlightColor: AppColors.greywithshade.withValues(alpha: 0.2),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.whitecolor,
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
      width: double.infinity,
    ),
  );
}

Widget gridShimmer({int itemCount = 6}) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: .symmetric(
      horizontal: AppPadding.lg,
      vertical: AppPadding.sm,
    ),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.65,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
    ),
    itemCount: itemCount,
    itemBuilder: (context, index) => productCardShimmer(),
  );
}

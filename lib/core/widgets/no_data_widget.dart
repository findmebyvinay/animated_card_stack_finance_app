import 'package:animated_card_stack_finance/core/constants/app_assets.dart';
import 'package:animated_card_stack_finance/core/localization/app_locale.dart';
import 'package:animated_card_stack_finance/core/widgets/build_context_extension.dart';
import 'package:animated_card_stack_finance/core/widgets/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NoDataWidget extends StatelessWidget {
  final double? height;
  final String? title;
  final String? subtitle;
  const NoDataWidget({super.key, this.height, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.noDataImage, height: height?.h ?? 250.h),
          Text(
            title ?? context.l10(AppLocale.noData),
            style: context.textTheme.titleLarge,
          ).padBottom(bottom: 10.h),
          Text(
            subtitle ?? context.l10(AppLocale.noData),
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ).padBottom(bottom: 10.h),
        ],
      ).padHorizontal(horizontal: 10.w),
    );
  }
}

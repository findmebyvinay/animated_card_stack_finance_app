import 'package:animated_card_stack_finance/core/constants/app_assets.dart';
import 'package:animated_card_stack_finance/core/localization/app_locale.dart';
import 'package:animated_card_stack_finance/core/widgets/build_context_extension.dart';
import 'package:animated_card_stack_finance/core/widgets/button_widget.dart';
import 'package:animated_card_stack_finance/core/widgets/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


class CustomErrorWidget extends StatelessWidget {
  final double? height;
  final String? title;
  final String? subTitle;
  final VoidCallback onRetry;
  const CustomErrorWidget({
    super.key,
    this.height,
    this.subTitle,
    this.title,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.errorImage, height: height?.h ?? 250.h),
          Text(
            title ?? context.l10(AppLocale.somethingWentWrong),
            style: context.textTheme.titleLarge,
          ).padBottom(bottom: 5.h),
          Text(
            subTitle ?? context.l10(AppLocale.somethingWentWrongMessage),
            style: context.textTheme.titleMedium,
          ).padBottom(bottom: 10.h),

          ButtonWidget(
            height: 35.h,
            width: 120.w,
            lable: context.l10(AppLocale.retry),
            onTap: onRetry,
          ).padBottom(bottom: 10.h),
        ],
      ).padHorizontal(horizontal: 10.w),
    );
  }
}

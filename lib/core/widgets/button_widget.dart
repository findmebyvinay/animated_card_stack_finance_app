import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/core/localization/app_locale.dart';
import 'package:animated_card_stack_finance/core/utils/debounc_utils.dart';
import 'package:animated_card_stack_finance/core/utils/decore_utils.dart';
import 'package:animated_card_stack_finance/core/widgets/build_context_extension.dart';
import 'package:animated_card_stack_finance/core/widgets/loader_widget.dart';
import 'package:animated_card_stack_finance/core/widgets/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ButtonWidget extends StatelessWidget {
  final String? lable;
  final VoidCallback onTap;
  final Color? buttonColor, lableColor, borderColor;
  final double? width;
  final double? height;
  final double horizontal;
  final bool isLoading;
  const ButtonWidget({
    super.key,
    this.lable,
    required this.onTap,
    this.buttonColor,
    this.lableColor,
    this.borderColor,
    this.width,
    this.height,
    this.horizontal = 0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          height: height?.h ?? 48.h,
          alignment: Alignment.center,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color:
                (buttonColor ??
                (context.isDark
                    ? AppColors.primaryColor
                    : AppColors.primaryColor)),
            border: Border.all(
              color:
                  (borderColor ??
                  (context.isDark
                      ? AppColors.primaryColor
                      : AppColors.primaryColor)),
            ),
          ),
          child: isLoading
              ? LoaderWidget(
                  dotColor: AppColors.whiteColor,
                ).padVertical(vertical: 8.h)
              : Text(
                  lable ?? context.l10(AppLocale.submit),
                  style: context.textTheme.titleMedium!.copyWith(
                    color:
                        lableColor ??
                        (context.isDark
                            ? AppColors.whiteColor
                            : AppColors.whiteColor),
                  ),
                ).padHorizontal(horizontal: 20.w).padVertical(vertical: 8.h),
        )
        .onTap(() {
          DebounceUtils().run(onTap);
        })
        .padHorizontal(horizontal: horizontal);
  }
}

Widget alertButton(
  BuildContext context, {
  required String lable,
  bool isOk = true,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
    alignment: Alignment.center,
    width: 0.3.sw,
    decoration: boxDecoration(
      context,
      color: isOk ? AppColors.primaryColor : null,
      borderColor: AppColors.primaryColor,
    ),
    child: Text(
      lable,
      style: context.textTheme.titleMedium?.copyWith(
        color: isOk ? AppColors.whiteColor : null,
      ),
    ),
  );
}

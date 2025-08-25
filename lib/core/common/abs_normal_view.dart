import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/core/constants/enum.dart';
import 'package:animated_card_stack_finance/core/widgets/error_widget.dart';
import 'package:animated_card_stack_finance/core/widgets/loader_widget.dart';
import 'package:animated_card_stack_finance/core/widgets/no_data_widget.dart';
import 'package:animated_card_stack_finance/core/widgets/pull_to_refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class AbsNormalView<T> extends StatelessWidget {
  final bool isToRefresh;
  final Widget? errorWidget;
  final Widget? noDataWidget;
  final AbsNormalStatus absNormalStatus;
  final T? data;
  final VoidCallback? onRetry;
  final Widget child;
  AbsNormalView({
    super.key,
    this.isToRefresh = false,
    this.errorWidget,
    this.noDataWidget,
    required this.absNormalStatus,
    this.data,
    this.onRetry,
    required this.child,
  }) : assert(
         !isToRefresh || onRetry != null,
         'If isToRefresh is true, onRetry must not be null',
       );

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    switch (absNormalStatus) {
      case AbsNormalStatus.LOADING:
      case AbsNormalStatus.INITIAL:
        return Center(child: LoaderWidget(dotColor: AppColors.primaryColor));

      case AbsNormalStatus.ERROR:
        return errorWidget ?? CustomErrorWidget(onRetry: onRetry ?? () {});

      case AbsNormalStatus.SUCCESS:
        if (data is List && (data as List).isEmpty) {
          return noDataWidget ?? const NoDataWidget();
        } else if (data != null) {
          return isToRefresh
              ? SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () {
                    onRetry!();
                    _refreshController.refreshCompleted();
                  },
                  child: child,
                )
              : child;
        } else {
          return noDataWidget ?? const NoDataWidget();
        }
    }
  }
}

class AbsPaginationNormalView<T> extends StatelessWidget {
  final Widget child;
  final Widget? errorWidget;
  final AbsNormalStatus absNormalStatus;
  final T? data;
  final VoidCallback onLoading;
  final VoidCallback onRefresh;
  const AbsPaginationNormalView({
    super.key,
    required this.child,
    this.errorWidget,
    required this.absNormalStatus,
    this.data,
    required this.onLoading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    switch (absNormalStatus) {
      case AbsNormalStatus.LOADING:
      case AbsNormalStatus.INITIAL:
        return Center(child: LoaderWidget(dotColor: AppColors.primaryColor));

      case AbsNormalStatus.ERROR:
        return errorWidget ?? CustomErrorWidget(onRetry: onRefresh);

      case AbsNormalStatus.SUCCESS:
        if (data is List && (data as List).isEmpty) {
          return const NoDataWidget();
        } else if (data != null) {
          return PullToRefreshWidget(
            onLoading: onLoading,
            onRefresh: onRefresh,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: child,
            ),
          );
        } else {
          return const NoDataWidget();
        }
    }
  }
}

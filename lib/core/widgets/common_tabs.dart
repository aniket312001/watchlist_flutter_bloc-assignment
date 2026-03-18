import 'package:flutter/material.dart';
import 'package:stock_market/core/theme/app_colors.dart';

class CommonTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTap;

  const CommonTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: selectedIndex,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        onTap: onTap, // ✅ update bloc
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.grey,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }
}

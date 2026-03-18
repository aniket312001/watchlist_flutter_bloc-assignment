import 'package:flutter/material.dart';
import 'package:stock_market/core/theme/app_colors.dart';

class CommonDivider extends StatelessWidget {
  const CommonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: AppColors.lightGrey, height: 0);
  }
}

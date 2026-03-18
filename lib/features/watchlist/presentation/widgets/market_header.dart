import 'package:flutter/material.dart';
import 'package:stock_market/core/theme/app_colors.dart';

class MarketHeader extends StatelessWidget {
  const MarketHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("SENSEX", style: TextStyle(fontWeight: FontWeight.bold)),

                  SizedBox(height: 2),
                  Text(
                    "71,200  +120 (0.45%)",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),

            VerticalDivider(
              color: AppColors.lightGrey,
              thickness: 1,
              width: 20,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "NIFTY BANK",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "48,300  -80 (0.15%)",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

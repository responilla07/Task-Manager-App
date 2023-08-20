import 'package:flutter/material.dart';
import 'package:task_manager/utils/theme.dart';

class HomeLoader extends StatelessWidget {
  final Color txtColor;
  const HomeLoader({
    super.key,
    this.txtColor = const Color(0xff966ef8),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.secondary,
            backgroundColor: AppColors.secondaryL,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading...',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: txtColor,
            ),
          ),
        ],
      ),
    );
  }
}

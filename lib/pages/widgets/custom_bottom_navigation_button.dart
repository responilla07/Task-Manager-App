import 'package:flutter/material.dart';
import 'package:task_manager/utils/theme.dart';

class CustomBottomNavButton extends StatelessWidget {
  final Function()? onPressed;
  final String btnText;
  const CustomBottomNavButton({
    super.key,
    this.onPressed,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: Colors.white,
        child: TextButton(
          style: TextButton.styleFrom(
            elevation: 4,
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.all(16.0),
            backgroundColor: AppColors.primary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                btnText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

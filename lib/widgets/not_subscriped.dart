import 'package:flutter/material.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';
import 'package:kidflix_app/views/nav_bar/nav_bar.dart';
import 'package:kidflix_app/widgets/custom_text_button.dart';

class NotSubscriped extends StatelessWidget {
  const NotSubscriped({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'You are not subscriped yet',
              style: AppStyles.style18SemiBold(FontFamily.FIGTREE,
                  color: Colors.grey),
            ),
            Text(
              'Please subscripe to watch videos',
              style: AppStyles.style18SemiBold(FontFamily.FIGTREE,
                  color: Colors.grey),
            ),
            CustomTextButton(
                text: 'Subscripe',
                style: AppStyles.style18SemiBold(FontFamily.FIGTREE,
                    color: AppColors.purble),
                onPressed: () {
                  // change navBar to index 1
                  tabControllerHomeShared.index = 1;
                })
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

/// Лого + «Activ QR / кабинет мерчанта» на экранах входа и кода.
class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: Image.asset(
            'assets/images/activbank-qr-app.png',
            width: AppDimens.brandLogo,
            height: AppDimens.brandLogo,
            fit: BoxFit.cover,
            excludeFromSemantics: true,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Activ QR',
                style: AppTextStyles.brandName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                'кабинет мерчанта',
                style: AppTextStyles.brandSubtitle.copyWith(
                  color: context.colors.textTertiary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

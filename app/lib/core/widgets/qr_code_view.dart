import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum QrBuildError { tooLong, invalid }

/// Готовая матрица QR или ошибка построения.
class QrBuild {
  const QrBuild._(this.code, this.error);

  /// Уровень коррекции L, как в прототипе: модули крупнее, сканируется издалека.
  factory QrBuild.from(String data) {
    final r = QrValidator.validate(
      data: data,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    return switch (r.status) {
      QrValidationStatus.valid => _checked(r.qrCode!),
      QrValidationStatus.contentTooLong => const QrBuild._(
        null,
        QrBuildError.tooLong,
      ),
      QrValidationStatus.error => const QrBuild._(null, QrBuildError.invalid),
    };
  }

  /// Слишком длинная строка проходит validate и падает только при отрисовке —
  /// строим матрицу заранее, чтобы показать понятную ошибку, а не пустоту.
  static QrBuild _checked(QrCode code) {
    try {
      QrImage(code);
      return QrBuild._(code, null);
    } on InputTooLongException {
      return const QrBuild._(null, QrBuildError.tooLong);
    } on Exception {
      return const QrBuild._(null, QrBuildError.invalid);
    }
  }

  final QrCode? code;
  final QrBuildError? error;
}

/// Чёрный QR на белом с тихой зоной [quietModules] модулей (стандарт — 4).
/// Занимает квадрат по меньшей стороне доступного места.
class QrCodeView extends StatelessWidget {
  const QrCodeView({
    super.key,
    required this.code,
    this.quietModules = 4,
    this.semanticLabel = 'QR-код для оплаты',
    this.radius = 0,
  });

  final QrCode code;
  final int quietModules;
  final String semanticLabel;

  /// Скругление белой плашки (в тёмной теме — как в Apple Wallet).
  /// Углы попадают в тихую зону, на сканирование не влияют.
  final double radius;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final side = math.min(c.maxWidth, c.maxHeight);
        final module = side / (code.moduleCount + quietModules * 2);
        return Semantics(
          image: true,
          label: semanticLabel,
          child: Container(
            width: side,
            height: side,
            padding: EdgeInsets.all(module * quietModules),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: CustomPaint(
              size: Size.square(module * code.moduleCount),
              painter: QrPainter.withQr(
                qr: code,
                gapless: true,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Colors.black,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Серый макет QR, пока строка с бэка не пришла.
class QrPlaceholder extends StatelessWidget {
  const QrPlaceholder({super.key, this.radius = 0});

  final double radius;

  static const _fill = Color(0xFFE4E4DF);
  static const _eye = Color(0xFFC9CAC5);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final side = math.min(c.maxWidth, c.maxHeight);
        final m = side / 29;
        Widget eye(double x, double y) => Positioned(
          left: x * m,
          top: y * m,
          child: Container(width: 7 * m, height: 7 * m, color: _eye),
        );
        return Container(
          width: side,
          height: side,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 2 * m,
                top: 2 * m,
                child: Container(width: 25 * m, height: 25 * m, color: _fill),
              ),
              eye(3, 3),
              eye(19, 3),
              eye(3, 19),
            ],
          ),
        );
      },
    );
  }
}

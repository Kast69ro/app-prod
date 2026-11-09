import 'package:flutter/material.dart';

/// Маршрут go_router, который открывается шторкой снизу (как sheet в iOS),
/// а не новой страницей. Закрывается свайпом вниз, тапом по затемнению,
/// системной кнопкой «Назад» и `context.pop()`.
class SheetPage<T> extends Page<T> {
  const SheetPage({super.key, required this.child});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
    settings: this,
    // Высоту задаёт содержимое (DraggableScrollableSheet), а не 9/16 экрана.
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    builder: (_) => child,
  );
}

/// Основа шторки: скруглённый верх, «ручка» и свайп вниз по всему
/// содержимому. [builder] получает контроллер — его нужно отдать списку,
/// чтобы протяжка вниз от начала списка закрывала шторку.
class SheetScaffold extends StatelessWidget {
  const SheetScaffold({
    super.key,
    required this.builder,
    required this.backgroundColor,
    required this.handleColor,
    this.bottom,
  });

  final Widget Function(BuildContext context, ScrollController controller)
  builder;
  final Color backgroundColor;
  final Color handleColor;

  /// Закреплено внизу, не прокручивается (кнопки действий).
  final Widget? bottom;

  /// Почти во весь экран, как «large» sheet в iOS.
  static const _maxSize = 0.94;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: _maxSize,
      maxChildSize: _maxSize,
      // Отпустили ниже середины — шторка закрывается, выше — возвращается.
      minChildSize: 0.5,
      snap: true,
      builder: (context, controller) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
        child: ColoredBox(
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    builder(context, controller),
                    // «Ручка» поверх шапки — подсказка, что шторку можно смахнуть.
                    Positioned(
                      top: 6,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        child: Center(
                          child: Container(
                            width: 36,
                            height: 5,
                            decoration: BoxDecoration(
                              color: handleColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ?bottom,
            ],
          ),
        ),
      ),
    );
  }
}

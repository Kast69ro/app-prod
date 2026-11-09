import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Ввод цифр с системной клавиатуры поверх своего отображения
/// (поле телефона, ячейки SMS-кода, точки кода доступа).
///
/// Над [child] лежит невидимое `TextField`: тап по [child] открывает
/// клавиатуру, а изменения текста превращаются в те же вызовы [onKey],
/// что раньше шли от экранной клавиатуры: цифра или `null` — «стереть».
/// Так контроллерам всё равно, откуда пришли цифры: набор, вставка
/// или автозаполнение кода из SMS.
class DigitInput extends StatefulWidget {
  const DigitInput({
    super.key,
    required this.value,
    required this.maxLength,
    required this.onKey,
    required this.child,
    this.obscure = false,
    this.autofillHints,
    this.onSubmitted,
    this.keepLastDigits = false,
  });

  /// Текущее значение из контроллера. Если контроллер его сбросил
  /// (неверный код), поле подстраивается.
  final String value;
  final int maxLength;
  final ValueChanged<String?> onKey;
  final Widget child;

  /// Для кода доступа: клавиатура не запоминает и не подсказывает ввод.
  final bool obscure;
  final Iterable<String>? autofillHints;
  final VoidCallback? onSubmitted;

  /// Вставили или автозаполнили больше цифр, чем помещается
  /// (`+992 93 123 45 67`) — берём последние [maxLength].
  final bool keepLastDigits;

  @override
  State<DigitInput> createState() => _DigitInputState();
}

class _DigitInputState extends State<DigitInput> {
  late final _controller = TextEditingController(text: widget.value);
  final _focus = FocusNode();

  @override
  void didUpdateWidget(DigitInput old) {
    super.didUpdateWidget(old);
    if (widget.value != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: widget.value.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  /// Разница «было → стало» в виде нажатий: сначала стереть то, что
  /// изменилось, потом добавить новые цифры.
  void _onChanged(String text) {
    final old = widget.value;
    var common = 0;
    while (common < old.length &&
        common < text.length &&
        old[common] == text[common]) {
      common++;
    }
    for (var i = common; i < old.length; i++) {
      widget.onKey(null);
    }
    for (var i = common; i < text.length; i++) {
      widget.onKey(text[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: TextField(
            controller: _controller,
            focusNode: _focus,
            autofocus: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              _DigitsFormatter(widget.maxLength, widget.keepLastDigits),
            ],
            autofillHints: widget.autofillHints,
            obscureText: widget.obscure,
            autocorrect: false,
            enableSuggestions: false,
            enableIMEPersonalizedLearning: false,
            onChanged: _onChanged,
            onSubmitted: (_) => widget.onSubmitted?.call(),
            // Поле невидимо: цифры, курсор и рамку рисует [child].
            showCursor: false,
            style: const TextStyle(color: Colors.transparent, fontSize: 1),
            decoration: const InputDecoration.collapsed(hintText: null),
          ),
        ),
      ],
    );
  }
}

/// Только цифры, не больше [max].
class _DigitsFormatter extends TextInputFormatter {
  _DigitsFormatter(this.max, this.keepLast);

  final int max;
  final bool keepLast;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > max) {
      final pasted = digits.length - oldValue.text.length > 1;
      digits = keepLast && pasted
          ? digits.substring(digits.length - max)
          : digits.substring(0, max);
    }
    return TextEditingValue(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }
}

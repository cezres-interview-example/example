import 'package:example/utils/format_text_for_double.dart';
import 'package:example/widgets/global_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> showGlobalTextFieldsAlertDialog(
  BuildContext context, {
  String? title,
  required List<GlobalTextFieldsItem> items,
  required void Function(List values) onConfirm,
}) {
  return showGlobalBottomSheet(
    context,
    child: GlobalTextFieldsAlertDialog(
      title: title,
      items: items,
      onConfirm: onConfirm,
    ),
  );
}

class GlobalTextFieldsItem<T> {
  const GlobalTextFieldsItem({
    required this.title,
    this.placeholder,
    this.value,
    this.keyboardType,
    required this.encode,
    required this.decode,
  });

  final String title;
  final String? placeholder;
  final T? value;
  final TextInputType? keyboardType;
  final String Function(T value) encode;
  final T? Function(String text) decode;

  static GlobalTextFieldsItem doubleTextField({
    required String title,
    String? placeholder,
    double? value,
  }) {
    return GlobalTextFieldsItem(
      title: title,
      placeholder: placeholder,
      value: value,
      keyboardType: TextInputType.number,
      encode: (value) => formatTextForDouble(value),
      decode: (text) => double.tryParse(text),
    );
  }

  static GlobalTextFieldsItem intTextField({
    required String title,
    String? placeholder,
    int? value,
  }) {
    return GlobalTextFieldsItem(
      title: title,
      placeholder: placeholder,
      value: value,
      keyboardType: TextInputType.number,
      encode: (value) => value.toString(),
      decode: (text) => int.tryParse(text),
    );
  }

  static GlobalTextFieldsItem stringTextField({
    required String title,
    String? placeholder,
    String? value,
  }) {
    return GlobalTextFieldsItem(
      title: title,
      placeholder: placeholder,
      value: value,
      keyboardType: TextInputType.text,
      encode: (value) => value,
      decode: (text) => text.isEmpty ? null : text,
    );
  }
}

class GlobalTextFieldsAlertDialog extends StatelessWidget {
  GlobalTextFieldsAlertDialog({
    super.key,
    this.title,
    required this.items,
    required this.onConfirm,
  });

  final String? title;
  final ValueNotifier<Set<int>> errorIndex = ValueNotifier({});
  final List<GlobalTextFieldsItem> items;
  final void Function(List) onConfirm;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildTopLinearGradient1(),
        _buildTopLinearGradient2(),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 36,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildItems(context),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    final List<TextEditingController> controllers = [];
    final List<Widget> textFields = [];

    for (var i = 0; i < items.length; i++) {
      final element = items[i];
      final text = element.value == null ? '' : element.encode(element.value);
      final controller = TextEditingController(text: text);
      controllers.add(controller);
      textFields.add(Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _buildTextField(context, i, controller),
      ));
    }

    return [
      if (title != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            title!,
            style: const TextStyle(
              color: Color(0xff111111),
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'PingFang SC',
            ),
          ),
        ),
      ...textFields,
      CupertinoButton(
        padding: const EdgeInsets.only(top: 12),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xff007FFF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              "确定",
              style: TextStyle(
                fontFamily: 'PingFang SC',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        onPressed: () {
          final values = [];
          final newErrorIndex = <int>{};
          for (var i = 0; i < controllers.length; i++) {
            final value = items[i].decode(controllers[i].text);
            if (value == null) {
              newErrorIndex.add(i);
            }
            values.add(value);
          }
          if (newErrorIndex.isEmpty) {
            onConfirm(values);
            Navigator.pop(context);
          } else {
            errorIndex.value = newErrorIndex;
          }
        },
      ),
    ];
  }

  Widget _buildTextField(
    BuildContext context,
    int index,
    TextEditingController controller,
  ) {
    final item = items[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: [
              ValueListenableBuilder(
                valueListenable: errorIndex,
                builder: (context, value, child) => value.contains(index)
                    ? const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text(
                          '*',
                          style: TextStyle(color: Color(0xffFF7D7D)),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 4,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF7F7F7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: item.placeholder ?? item.title,
                border: InputBorder.none,
              ),
              keyboardType: item.keyboardType,
              style: const TextStyle(
                fontFamily: 'PingFang SC',
                fontSize: 12,
                color: Color(0xff111111),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopLinearGradient1() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          gradient: LinearGradient(
            colors: [
              const Color(0xff007FFF).withOpacity(0.22),
              Colors.transparent
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildTopLinearGradient2() {
    return Positioned(
      right: -150,
      top: -150,
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          gradient: RadialGradient(
            colors: [
              const Color(0xff8F43F9).withOpacity(0.22),
              Colors.transparent
            ],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}

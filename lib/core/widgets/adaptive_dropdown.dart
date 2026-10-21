import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveDropdown<T> extends StatelessWidget {
  const AdaptiveDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemLabel,
    this.decoration,
    this.style,
    this.icon,
    this.isExpanded = false,
  });

  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabel;
  final InputDecoration? decoration;
  final TextStyle? style;
  final Widget? icon;
  final bool isExpanded;

  bool get _usesCupertino => defaultTargetPlatform == TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    if (!_usesCupertino) {
      final dropdownItems = items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item)),
            ),
          )
          .toList();

      if (decoration != null) {
        return DropdownButtonFormField<T>(
          initialValue: value,
          decoration: decoration,
          style: style,
          icon: icon,
          isExpanded: isExpanded,
          items: dropdownItems,
          onChanged: onChanged,
        );
      }

      return DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          style: style,
          icon: icon,
          isExpanded: isExpanded,
          items: dropdownItems,
          onChanged: onChanged,
        ),
      );
    }

    final selectedValue = value;
    final selectedText = selectedValue == null ? '' : itemLabel(selectedValue);
    final selectedStyle = style ?? Theme.of(context).textTheme.bodyLarge;
    final dropdownIcon = _usesCupertino
        ? const Icon(CupertinoIcons.chevron_down, size: 18)
        : icon ?? const Icon(Icons.arrow_drop_down);
    final displayedContent = Row(
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (isExpanded)
          Expanded(child: Text(selectedText, style: selectedStyle))
        else
          Text(selectedText, style: selectedStyle),
        dropdownIcon,
      ],
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _showCupertinoOptions(context),
      child: decoration == null
          ? displayedContent
          : InputDecorator(
              decoration: decoration!,
              isEmpty: value == null,
              child: displayedContent,
            ),
    );
  }

  Future<void> _showCupertinoOptions(BuildContext context) async {
    final selected = await showCupertinoModalPopup<T>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: items
            .map(
              (item) => CupertinoActionSheetAction(
                onPressed: () => Navigator.of(context).pop(item),
                child: Text(itemLabel(item)),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ),
    );

    if (selected != null) onChanged(selected);
  }
}

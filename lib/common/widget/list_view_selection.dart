import 'package:flutter/material.dart';

class ListViewSelection extends StatefulWidget {
  final Function(int index)? onTap;
  final VoidCallback? afteDissmis;
  final VoidCallback? whenBeOnSelectionMode;
  final int listLength;
  final Widget? leadingInSelection;
  final Widget? leadingUnSelection;
  final Widget Function(BuildContext, int) separatorBuilder;
  final Color selectedColor;
  final Color color;
  final Function(int index)? afterSelect;
  final Function(int index)? afterUnSelect;
  final Widget Function(BuildContext, int) listItem;
  const ListViewSelection(
      {super.key,
      this.onTap,
      required this.listLength,
      required this.selectedColor,
      this.color = Colors.white,
      required this.listItem,
      this.afterSelect,
      this.afterUnSelect,
      this.afteDissmis,
      this.leadingInSelection,
      this.leadingUnSelection,
      required this.separatorBuilder,
      this.whenBeOnSelectionMode});

  @override
  State<ListViewSelection> createState() => _ListViewSelectionState();
}

class _ListViewSelectionState extends State<ListViewSelection> {
  final List<int> _selectedIndices = [];
  bool inSelectionMode = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (inSelectionMode) {
          inSelectionMode = false;
          _selectedIndices.clear();
          setState(() {});
          if (widget.afteDissmis != null) {
            widget.afteDissmis!();
          }

          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: ListView.separated(
        itemCount: widget.listLength,
        separatorBuilder: widget.separatorBuilder,
        itemBuilder: (context, index) {
          return InkWell(
            onLongPress: () {
              if (inSelectionMode) {
                return;
              } else {
                inSelectionMode = true;
                _selectedIndices.add(index);
                setState(() {});
                if (widget.whenBeOnSelectionMode != null) {
                  widget.whenBeOnSelectionMode!();
                }
              }
            },
            onTap: () {
              if (inSelectionMode) {
                if (_selectedIndices.contains(index)) {
                  _selectedIndices.remove(index);
                  setState(() {});
                  if (widget.afterUnSelect != null) {
                    widget.afterUnSelect!(index);
                  }
                } else {
                  _selectedIndices.add(index);
                  setState(() {});
                  if (widget.afterUnSelect != null) {
                    widget.afterUnSelect!(index);
                  }
                }
              } else {
                if (widget.onTap != null) {
                  widget.onTap!(index);
                }
              }
            },
            child: Container(
              color: _selectedIndices.contains(index)
                  ? widget.selectedColor
                  : widget.color,
              child: Row(
                children: [
                  if (inSelectionMode && _selectedIndices.contains(index))
                    widget.leadingInSelection ?? const SizedBox()
                  else if (inSelectionMode && !_selectedIndices.contains(index))
                    widget.leadingUnSelection ?? const SizedBox(),
                  Expanded(child: widget.listItem(context, index))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

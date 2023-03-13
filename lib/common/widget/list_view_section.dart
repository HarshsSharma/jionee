import 'package:flutter/material.dart';

class ListViewSection extends StatelessWidget {
  final Widget Function(BuildContext, int) separatorBuilder;
  final Section Function(BuildContext, int) listItem;
  final int listLength;

  const ListViewSection({
    super.key,
    required this.separatorBuilder,
    required this.listLength,
    required this.listItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return listItem(context, index);
        },
        separatorBuilder: separatorBuilder,
        itemCount: listLength);
  }
}

class Section extends StatefulWidget {
  final List<Widget> children;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget collapseIcon;
  final Widget expandedIcon;
  final Widget child;
  final ValueChanged? oChanged;

  const Section(
      {super.key,
      required this.children,
      this.height,
      this.width,
      this.backgroundColor,
      this.padding,
      required this.child,
      required this.collapseIcon,
      required this.expandedIcon,
      this.oChanged});

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: widget.height,
      width: widget.width,
      color: widget.backgroundColor,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (widget.oChanged != null) {
                widget.oChanged!(!isOpen);
              }
              setState(() {
                isOpen = !isOpen;
              });
            },
            child: Row(
              children: [
                if (isOpen) widget.expandedIcon else widget.collapseIcon,
                widget.child,
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          if (isOpen)
            ...widget.children
                .map((e) => Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        children: [
                          e,
                          if (e.runtimeType != Section)
                            const Divider(
                              height: 1,
                              thickness: 1,
                            )
                        ],
                      ),
                    ))
                .toList()
        ],
      ),
    );
  }
}

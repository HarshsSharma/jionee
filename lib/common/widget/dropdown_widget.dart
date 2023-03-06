import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'infinty_list_view.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({
    Key? key,
    this.validator,
    required this.data,
    required this.multiSelection,
    required this.isRequired,
    required this.labelText,
    this.scrollController,
    required this.onScrollEnd,
    required this.loadData,
    this.onSingleSelection,
    this.onMultiSelection,
  }) : super(key: key);
  final FormFieldValidator<dynamic>? validator;
  final List<String> data;
  final bool multiSelection;
  final bool isRequired;
  final String labelText;
  final ScrollController? scrollController;
  final Future<void> Function(int nextPage) onScrollEnd;
  final AsyncCallback loadData;
  final ValueChanged<String?>? onSingleSelection;
  final ValueChanged<List<String>>? onMultiSelection;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  late ScrollController scrollController;
  late FormFieldState<Object> fieldState;
  bool _expanded = false;
  late GlobalKey _globalKey;
  OverlayEntry? entry;
  final LayerLink _layerLink = LayerLink();
  String _selectedTitle = '';
  final List<String> _selectedTitles = [];

  @override
  void initState() {
    scrollController = widget.scrollController ?? ScrollController();
    _globalKey = GlobalKey();
    super.initState();
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    entry = OverlayEntry(
      builder: (ctx) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: fieldState.hasError
                ? Offset(0.0, size.height - 50.0)
                : Offset(0.0, size.height - 27.0),
            child: TapRegion(
              groupId: _globalKey,
              child: _createOverlay(fieldState),
            ),
          ),
        );
      },
    );

    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  Widget _createOverlay([FormFieldState<Object>? field]) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        ),
        border: Border.all(
          color: field!.hasError
              ? Theme.of(context).colorScheme.error
              : AppColors.boDarkGrey,
          width: 1.0,
        ),
        color: Theme.of(context).colorScheme.brightness == Brightness.dark
            ? Colors.grey[850]!
            : Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 4.0,
      ),
      height: 250,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                helperStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppColors.tLightGrey),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10.0,
                ),
                prefixIcon: const Icon(Icons.search),
                border: _textFieldBorders(),
                enabledBorder: _textFieldBorders(),
                focusedBorder: _textFieldBorders(),
                disabledBorder: _textFieldBorders(),
              ),
            ),
            Expanded(
              child: RawScrollbar(
                radius: const Radius.circular(4),
                thumbVisibility: true,
                controller: scrollController,
                child: InfinityListViewWidget<String>(
                  // focusNode: _focusNode,
                  scrollController: scrollController,
                  data: widget.data,
                  separatorBuilder: const SizedBox(height: 10.0),
                  itemBuilder: (ctx, i) {
                    final title = widget.data[i];
                    return GestureDetector(
                      onTap: () {
                        _handleSelectedEvent(title, field);
                      },
                      child: Text(
                        title,
                        style: _selectedTitle == title ||
                                _selectedTitles.contains(title)
                            ? Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.grey)
                            : Theme.of(context).textTheme.labelMedium,
                      ),
                    );
                  },
                  onScrollEnd: (nextPage) => widget.onScrollEnd(nextPage),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      /// Through this [onTapOutside] prop I can close the dropdown menu when tapping any where outside it
      onTapOutside: (event) {
        setState(() {
          _expanded = false;
        });
        hideOverlay();
      },
      groupId: _globalKey,

      /// This [FormField] widget allows me to use the validation of the [Form] like [TextFormFiled]
      /// (1) I should pass the validator method to it
      /// (2) In anywhere I am passing a new data I must call field.didChange(pass the data here) to let the form field know
      /// that the data changed so check if its valid or not
      child: FormField(
        validator: widget.validator, // (1)
        initialValue: widget.multiSelection ? _selectedTitles : _selectedTitle,
        builder: (field) {
          fieldState = field;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.labelText,
                  style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 9.5),
              CompositedTransformTarget(
                link: _layerLink,
                child: Container(
                  height: 50.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(
                      color: field.hasError
                          ? Theme.of(context).colorScheme.error
                          : AppColors.boDarkGrey,
                      width: 2.0,
                    ),
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.dark
                        ? Colors.grey[850]!
                        : Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.multiSelection
                          ? _selectedTitles.isEmpty
                              ? _labetWidget()
                              : _multiSelectionItem(field)

                          //Single Selection Item
                          : _selectedTitle.isEmpty
                              ? _labetWidget()
                              : _singleSelectionItem(),
                      GestureDetector(
                        onTap: () {
                          _handleButtonPressed();

                          field.didChange(widget.multiSelection
                              ? _selectedTitles
                              : _selectedTitle);
                        },
                        child: Icon(
                          !_expanded
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up_outlined,
                          color: AppColors.tDarkGrey,
                          size: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (entry == null && field.hasError) ...[
                Visibility(
                  visible: (entry == null && field.hasError),
                  maintainSize: false,
                  maintainState: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5.0),
                      Text(
                        field.errorText!,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  OutlineInputBorder _textFieldBorders() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3.0)),
      borderSide: BorderSide(
        color: AppColors.boTextFieldGrey,
      ),
    );
  }

  Text _labetWidget() {
    return Text(
      'Select',
      style: Theme.of(context)
          .textTheme
          .labelSmall!
          .copyWith(color: AppColors.tLightGrey),
    );
  }

  Text _singleSelectionItem() {
    return Text(_selectedTitle,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium);
  }

  Expanded _multiSelectionItem(FormFieldState<dynamic> field) {
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          children: _selectedTitles
              .map(
                // Muilti Selection Item
                (e) => Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            e,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _deleteItem(e, field),
                          child: const Icon(
                            Icons.close,
                            size: 13.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _handleSelectedEvent(String title, FormFieldState<dynamic> field) {
    if (widget.multiSelection) {
      if (_selectedTitles.contains(title)) {
        _deleteItem(title, field);
      } else {
        setState(() {
          _selectedTitles.add(title);
          field.didChange(_selectedTitles);
          if (widget.onMultiSelection != null) {
            widget.onMultiSelection!(_selectedTitles);
          }
        });
      }
    } else {
      if (_selectedTitle == title) {
        setState(() {
          _selectedTitle = '';
          field.didChange(_selectedTitle);
          if (widget.onSingleSelection != null) {
            widget.onSingleSelection!(_selectedTitle);
          }
        });
      } else {
        setState(() {
          _selectedTitle = title;
          field.didChange(_selectedTitle);
          _expanded = false;
          hideOverlay();
          if (widget.onSingleSelection != null) {
            widget.onSingleSelection!(_selectedTitle);
          }
        });
      }
    }
  }

  void _deleteItem(String e, FormFieldState<dynamic> field) {
    setState(() {
      _selectedTitles.removeWhere((element) => element == e);
      field.didChange(_selectedTitles);
      if (widget.onMultiSelection != null) {
        widget.onMultiSelection!(_selectedTitles);
      }
    });
  }

  Future _showDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _handleButtonPressed() {
    if (!_expanded) {
      _showDialog();

      widget.loadData().then(
        (value) {
          _dismissDialog(context);
          _buttonHandlePressed();
        },
      ).catchError((error) {
        _dismissDialog(context);
        _showErrorDialog();
      });
    } else {
      _buttonHandlePressed();
    }
  }

  void _buttonHandlePressed() {
    if (_expanded && entry != null) {
      setState(() {
        _expanded = false;
      });
      hideOverlay();
    } else {
      setState(() {
        _expanded = true;
      });
      showOverlay();
    }
  }

  Future _showErrorDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Something went wrong'),
        content: const Text(
            'Something happend while loading the data, please try again'),
        actions: [
          TextButton(
            onPressed: () {
              _dismissDialog(context);
            },
            child: const Text('ok'),
          ),
        ],
      ),
    );
  }

  void _dismissDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

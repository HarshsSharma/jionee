import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

enum ButtonFocusState {
  initial,
  focused,
  unFocused,
}

class _DropDownWidgetState extends State<DropDownWidget> {
  late ScrollController scrollController;
  final FocusNode _focusNode = FocusNode();
  late FormFieldState<Object> fieldState;
  bool _expanded = false;
  ButtonFocusState _focused = ButtonFocusState.initial;
  late FocusAttachment _nodeAttachment;
  OverlayEntry? _overlayEntry;
  GlobalKey globalKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  String _selectedTitle = '';
  final List<String> _selectedTitles = [];

  @override
  void initState() {
    super.initState();
    OverlayState? overlayState = Overlay.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalKey;
    });
    scrollController = widget.scrollController ?? ScrollController();
    _focusNode.addListener(() => _handleFocusChange(overlayState));
    _nodeAttachment = _focusNode.attach(context, onKey: _handleKeyPress);
  }

  KeyEventResult _handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      debugPrint(
          'Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  void _handleFocusChange(OverlayState overlayState) {
    debugPrint('${_focusNode.hasFocus}');
    if (_focusNode.hasFocus) {
      _overlayEntry = _createOverlay(fieldState);

      overlayState.insert(_overlayEntry!);
      setState(() {
        _focused = ButtonFocusState.focused;
      });
    } else {
      _overlayEntry!.remove();
      setState(() {
        _focused = ButtonFocusState.unFocused;
        _expanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _nodeAttachment.reparent();
    return TapRegion(
      /// Through this [onTapOutside] prop I can close the dropdown menu when tapping any where outside it
      onTapOutside: (event) {
        if (event.position.dy < 82.0 || event.position.dy > 313.0) {
          setState(() {
            _expanded = false;
          });
          _focusNode.unfocus();
        }
      },

      /// This [FormField] widget allows me to use the validation of the [Form] like [TextFormFiled]
      /// (1) I should pass the validator method to it
      /// (2) In anywhere I am passing a new data I must call field.didChange(pass the data here) to let the form field know
      /// that the data changed so check if its valid or not
      child: FormField(
        validator: widget.validator, // (1)
        initialValue: widget.multiSelection ? _selectedTitles : _selectedTitle,
        builder: (field) {
          fieldState = field;
          return CompositedTransformTarget(
            link: _layerLink,
            child: Focus(
              focusNode: _focusNode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70.0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: field.hasError
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.brightness ==
                                    Brightness.dark
                                ? Colors.grey[700]!
                                : AppColors.boGrey,
                        width: 2.0,
                      ),
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.dark
                          ? Colors.grey[850]!
                          : Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: _selectedTitle.isNotEmpty ? 3 : 5,
                          child: widget.multiSelection
                              ? _selectedTitles.isEmpty
                                  ? _labetWidget(context)
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _labetWidget(context),
                                        const SizedBox(height: 2),
                                        _multiSelectionItem(field),
                                      ],
                                    )

                              //Single Selection Item
                              : _selectedTitle.isEmpty
                                  ? _labetWidget(context)
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _labetWidget(context),
                                        const SizedBox(height: 2),
                                        _singleSelectionItem(),
                                      ],
                                    ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (_selectedTitle.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedTitle = '';

                                      field.didChange(_selectedTitle); // (2)
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 20.0,
                                  ),
                                ),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                  (_focused == ButtonFocusState.initial ||
                                              _focused ==
                                                  ButtonFocusState.unFocused) &&
                                          _expanded == false
                                      ? Icons.arrow_drop_down
                                      : Icons.arrow_drop_up,
                                  color: AppColors.tDarkGrey,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  _handleButtonPressed();
                                  field.didChange(widget.multiSelection
                                      ? _selectedTitles
                                      : _selectedTitle);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!(_focused == ButtonFocusState.focused && _expanded))
                    if ((_focused == ButtonFocusState.unFocused ||
                            _focused == ButtonFocusState.initial) &&
                        field.hasError) ...[
                      const SizedBox(height: 5.0),
                      Text(
                        field.errorText!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  OverlayEntry? _createOverlay([FormFieldState<Object>? field]) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Colors.grey[850]!
                : Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 4.0,
            ),
            height:
                _focused == ButtonFocusState.focused && _expanded ? 150.0 : 0,
            child: InfinityListViewWidget<String>(
              focusNode: _focusNode,
              data: widget.data,
              separatorBuilder: const SizedBox(height: 20.0),
              itemBuilder: (ctx, i) {
                final title = widget.data[i];
                return GestureDetector(
                  onTap: () {
                    _handleSelectedEvent(title, field!);
                  },
                  child: Text(
                    title,
                    style: _selectedTitle == title ||
                            _selectedTitles.contains(title)
                        ? const TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          )
                        : TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.brightness ==
                                    Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                  ),
                );
              },
              onScrollEnd: (nextPage) => widget.onScrollEnd(nextPage),
            ),
          ),
        ),
      ),
    );
  }

  Row _labetWidget(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (widget.isRequired)
          Text(
            '*',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
      ],
    );
  }

  Text _singleSelectionItem() {
    return Text(
      _selectedTitle,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18.0,
      ),
    );
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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
          _expanded = !_expanded;
          _focusNode.unfocus();
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
    if ((_focused == ButtonFocusState.initial ||
            _focused == ButtonFocusState.unFocused) &&
        !_expanded) {
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
    if (_focused == ButtonFocusState.focused && _expanded) {
      _focusNode.unfocus();
      setState(() {
        _focused = ButtonFocusState.initial;
        _expanded = false;
      });
    } else {
      _focusNode.requestFocus();
      _expanded = !_expanded;
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

import 'package:flutter/material.dart';

import '../constants/constants.dart';

extension ShowOverlayExtension on BuildContext {
  Size get widgetSize => (findRenderObject() as RenderBox).size;
  Offset currentOverlayOffset({FormFieldState<Object>? fieldState}) {
    /// From [fullScreen] we will get the full screen height
    final RenderBox fullScreen =
        Navigator.of(this).overlay!.context.findRenderObject()! as RenderBox;

    /// From [renderBox] we will get the current Overlay height
    RenderBox renderBox = findRenderObject() as RenderBox;
    var size = renderBox.size;

    double dropdownHeight = fieldState != null
        ? fieldState.hasError
            ? size.height - 48.5
            : size.height - 26.5
        : size.height - 26.5;
    // The defalut position for the overlay widget
    Offset offset = Offset(0.0, dropdownHeight);
    // The reversed position for the overlay widget
    Offset reverseOffset =
        Offset(0.0, -dropdownHeight - (overlayHeight - dropdownHeight));

    /// From [position] we will get how far the current overlay from the bottom
    /// depending on the default [offset] and [fullScreen]
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(offset, ancestor: fullScreen),
        renderBox.localToGlobal(
          renderBox.size.bottomRight(Offset.zero) + offset,
          ancestor: fullScreen,
        ),
      ),
      Offset.zero & fullScreen.size,
    );
    // Here we check if the full height of the overlay will appear through
    // calculating "How far the current Overlay from the bottom(A)" and "The Over lay height(B)"
    // if B > A that's mean there is no enough space to desplay the current overlay in default position
    // so display it in a reversed way
    return position.bottom <= (overlayHeight - dropdownHeight)
        ? reverseOffset
        : offset;
  }
}

    // var overlayHeight = fullScreen.size.height >
    //         700 // This condition we determine we are in a small or a large phone
    //     ? fieldState != null
    //         ? fieldState.hasError
    //             ? renderBox.size.height + 50
    //             : renderBox.size.height + 70
    //         : renderBox.size.height + 70
    //     : fieldState != null
    //         ? fieldState.hasError
    //             ? renderBox.size.height
    //             : renderBox.size.height + 20
    //         : renderBox.size.height + 20;
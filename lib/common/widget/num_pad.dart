import 'package:flutter/material.dart';

import '../styles/colors.dart';

class NumPad extends StatelessWidget {
  final double buttonSize;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const NumPad({
    Key? key,
    this.buttonSize = 70,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color iconColor =
        Theme.of(context).colorScheme.brightness == Brightness.dark
            ? Colors.white
            : AppColors.primaryColor;
    double iconSize = 35.0;
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // implement the number keys (from 0 to 9) with the NumberButton widget
            // the NumberButton widget is defined in the bottom of this file
            children: List.generate(
              3,
              (index) {
                return NumberButton(
                  number: index + 1,
                  size: buttonSize,
                  controller: controller,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) {
                int z = 3;
                return NumberButton(
                  number: z + index + 1,
                  size: buttonSize,
                  controller: controller,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) {
                int z = 6;
                return NumberButton(
                  number: z + index + 1,
                  size: buttonSize,
                  controller: controller,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // this button is used to delete the last number
              IconButton(
                onPressed: () => delete(),
                icon: Icon(
                  Icons.backspace,
                  color: iconColor,
                ),
                iconSize: iconSize,
              ),
              NumberButton(
                number: 0,
                size: buttonSize,
                controller: controller,
              ),
              // this button is used to submit the entered value
              IconButton(
                onPressed: () => onSubmit(),
                icon: Icon(
                  Icons.done_rounded,
                  color: iconColor,
                ),
                iconSize: iconSize,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// define NumberButton widget
// its shape is round
class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.brightness == Brightness.dark
        ? AppColors.darkModePrimaryColor
        : AppColors.primaryColor;
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size / 2),
          ),
        ),
        onPressed: () {
          controller.text += number.toString();
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

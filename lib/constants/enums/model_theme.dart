enum TextScaleFactorValue {
  small('Small', 0.8),
  reqular('Regular', 1.0),
  medium('Medium', 1.2),
  large('Large', 1.5);

  final String type;
  final double scaleValue;
  const TextScaleFactorValue(this.type, this.scaleValue);
}

typedef RetryCallback = void Function();

typedef OnScrollEndCallbackWithText = void Function(int nextPage, String? value);
typedef OnScrollEndCallback = Future<void> Function(int nextPage);


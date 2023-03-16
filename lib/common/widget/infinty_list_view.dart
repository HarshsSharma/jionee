import 'dart:developer';

import 'package:flutter/material.dart';

import '../constants/typedefs.dart';

class InfinityListViewWidget<T> extends StatefulWidget {
  const InfinityListViewWidget({
    Key? key,
    required this.data,
    this.padding = const EdgeInsets.all(10.0),
    this.physics = const ClampingScrollPhysics(),
    required this.itemBuilder,
    this.separatorBuilder = const SizedBox(height: 10.0),
    this.scrollController,
    this.isEnd = false,
    this.focusNode,
    this.initalLoaderWidget = const Center(child: CircularProgressIndicator()),
    this.startPage = 1,
    required this.onScrollEnd,
    required this.loadData,
  }) : super(key: key);

  final List<T> data;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget separatorBuilder;
  final ScrollController? scrollController;
  final bool isEnd;
  final FocusNode? focusNode;
  final Widget initalLoaderWidget;
  final int startPage;
  final OnScrollEndCallback onScrollEnd;
  final OnScrollEndCallback loadData;

  @override
  State<InfinityListViewWidget<T>> createState() =>
      _InfinityListViewWidgetState<T>();
}

enum LoadingStatus {
  initial,
  loading,
  loaded,
  failure,
}

class _InfinityListViewWidgetState<T> extends State<InfinityListViewWidget<T>> {
  LoadingStatus _loadingStatus = LoadingStatus.loading;
  bool _firstLoading = false;
  bool preventCall = false;
  late int startPage;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = widget.scrollController ?? ScrollController();
    startPage = widget.startPage;
    if (startPage == widget.startPage) {
      _setFirstLoading(true);
      _fetchingFirstData().then((value) {
        _setFirstLoading(false);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('InfinityListViewWidget rebuild and data length is: ${widget.data.length}');
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.extentAfter == 0) {
          if (!preventCall) {
            _fetchingData();
            preventCall = true;
          }
        }
        return false;
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: widget.physics,
        slivers: widget.data.isEmpty && _firstLoading
            ? [
                const SliverToBoxAdapter(
                  child: Center(
                    child: Text('No Data!'),
                  ),
                ),
              ]
            : [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      if (widget.data.isNotEmpty) ...[
                        ListView.separated(
                          shrinkWrap: true,
                          padding: widget.padding,
                          physics: widget.physics,
                          itemCount: widget.data.length,
                          itemBuilder: widget.itemBuilder,
                          separatorBuilder: (_, __) => widget.separatorBuilder,
                        ),
                        if ((_loadingStatus == LoadingStatus.loading ||
                                _loadingStatus == LoadingStatus.initial) &&
                            !_firstLoading)
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        else if (_loadingStatus == LoadingStatus.failure)
                          Column(
                            children: [
                              Text(
                                'Something went wrong',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _fetchingData();
                                },
                                icon: Icon(
                                  Icons.restart_alt,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              )
                            ],
                          ),
                      ],
                    ],
                  ),
                ),
              ],
      ),
    );
  }

  Future<void> _fetchingData() async {
    if (!_firstLoading) _setLoadingStatus(LoadingStatus.loading);
    widget.onScrollEnd(startPage).then((value) {
      if (!_firstLoading) _setLoadingStatus(LoadingStatus.loaded);
      preventCall = false;
      startPage++;
    }).catchError((error) {
      if (!_firstLoading) _setLoadingStatus(LoadingStatus.failure);
      preventCall = true;
    });
  }

  Future<void> _fetchingFirstData() async {
    if (!_firstLoading) _setLoadingStatus(LoadingStatus.loading);
    widget.loadData(startPage).then((value) {
      if (!_firstLoading) _setLoadingStatus(LoadingStatus.loaded);
      preventCall = false;
      startPage++;
    }).catchError((error) {
      if (!_firstLoading) _setLoadingStatus(LoadingStatus.failure);
      preventCall = true;
    });
  }

  void _setLoadingStatus(LoadingStatus value) {
    if (startPage != widget.startPage) {
      setState(() {
        _loadingStatus = value;
      });
    }
  }

  void _setFirstLoading(bool value) => setState(() {
        _firstLoading = value;
      });
}

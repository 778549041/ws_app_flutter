import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GifHeader extends RefreshIndicator {
  GifHeader() : super(height: 80, refreshStyle: RefreshStyle.Follow);
  @override
  GifHeaderState createState() => GifHeaderState();
}

class GifHeaderState extends RefreshIndicatorState<GifHeader>
    with SingleTickerProviderStateMixin {
  GifController _gifController;

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return GifImage(
      controller: _gifController,
      image: AssetImage(''),
      height: 80,
      width: 100,
    );
  }

  @override
  void onModeChange(RefreshStatus mode) {
    if (mode == RefreshStatus.refreshing) {
      _gifController.repeat(
          min: 0, max: 29, period: Duration(milliseconds: 500));
    }
    super.onModeChange(mode);
  }

  @override
  Future<void> endRefresh() {
    _gifController.value = 30;
    return _gifController.animateTo(59, duration: Duration(milliseconds: 500));
  }

  @override
  void resetValue() {
    _gifController.value = 0;
    super.resetValue();
  }

  @override
  void initState() {
    _gifController = GifController(vsync: this, value: 1);
    super.initState();
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(GifHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}

class GifFooter extends StatefulWidget {
  GifFooter() : super();
  @override
  GifFooterState createState() => GifFooterState();
}

class GifFooterState extends State<GifFooter>
    with SingleTickerProviderStateMixin {
  GifController _gifController;

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      height: 80,
      builder: (context, mode) {
        return GifImage(
          image: AssetImage(""),
          controller: _gifController,
          height: 80.0,
          width: 100.0,
        );
      },
      loadStyle: LoadStyle.ShowWhenLoading,
      onModeChange: (mode) {
        if (mode == LoadStatus.loading) {
          _gifController.repeat(
              min: 0, max: 29, period: Duration(milliseconds: 500));
        }
      },
      endLoading: () async {
        _gifController.value = 30;
        return _gifController.animateTo(59,
            duration: Duration(milliseconds: 500));
      },
    );
  }

  @override
  void initState() {
    _gifController = GifController(
      vsync: this,
      value: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(GifFooter oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}

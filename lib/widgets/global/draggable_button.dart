library draggable_floating_button;

import 'package:flutter/material.dart';

const BoxConstraints _kSizeConstraints = BoxConstraints.tightFor(
  width: 56.0,
  height: 56.0,
);

const BoxConstraints _kMiniSizeConstraints = BoxConstraints.tightFor(
  width: 40.0,
  height: 40.0,
);

/*
const BoxConstraints _kExtendedSizeConstraints = BoxConstraints(
  minHeight: 48.0,
  maxHeight: 48.0,
);
*/

const Offset _kDefaultOffset = Offset(0, 0);

class _DefaultHeroTag {
  const _DefaultHeroTag();
  @override
  String toString() => '<default FloatingActionButton tag>';
}

class DraggableButton extends StatefulWidget {
  DraggableButton({
    Key? key,
    this.child,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.heroTag = const _DefaultHeroTag(),
    this.elevation = 6.0,
    this.highlightElevation = 12.0,
    required this.onPressed,
    this.mini = false,
    this.shape = const CircleBorder(),
    this.clipBehavior = Clip.none,
    this.materialTapTargetSize,
    this.isExtended = false,
    required this.appContext,
    this.appBarHeight = 0,
    this.bottomBarHeight = 0,
    this.data = 'dfab',
    this.offset = _kDefaultOffset,
  })  : _sizeConstraints = mini ? _kMiniSizeConstraints : _kSizeConstraints,
        super(key: key);

  final Widget? child;

  final String? tooltip;

  final Color? foregroundColor;

  final Color? backgroundColor;

  final Object heroTag;

  final VoidCallback onPressed;

  final double elevation;

  final double highlightElevation;

  final bool mini;

  final ShapeBorder shape;

  final Clip clipBehavior;

  final bool isExtended;

  final MaterialTapTargetSize? materialTapTargetSize;

  final BuildContext appContext;

  final double appBarHeight;

  final double bottomBarHeight;

  final Offset offset;

  final BoxConstraints _sizeConstraints;

  final String data;

  @override
  State<StatefulWidget> createState() => _DraggableButtonState();
}

class _DraggableButtonState extends State<DraggableButton> {
  Offset? dynamicOffset;

  @override
  Widget build(BuildContext context) {
    if (dynamicOffset == null) {
      dynamicOffset = widget.offset;
    }

    FloatingActionButton _floatingActionButton = new FloatingActionButton(
        key: widget.key,
        child: widget.child,
        tooltip: widget.tooltip,
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.foregroundColor,
        heroTag: widget.heroTag,
        elevation: widget.elevation,
        highlightElevation: widget.highlightElevation,
        onPressed: widget.onPressed,
        shape: widget.shape,
        isExtended: widget.isExtended,
        materialTapTargetSize: widget.materialTapTargetSize,
        clipBehavior: widget.clipBehavior,
        mini: widget.mini);

    return Positioned(
        left: dynamicOffset!.dx,
        top: dynamicOffset!.dy,
        child: Draggable(
          data: widget.data,
          child: _floatingActionButton,
          feedback: _floatingActionButton,
          childWhenDragging: Container(),
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            setState(() {
              var dy = offset.dy -
                  widget.appBarHeight -
                  MediaQuery.of(widget.appContext).padding.top;
              var dx = offset.dx;

              var maxDy = MediaQuery.of(widget.appContext).size.height -
                  MediaQuery.of(widget.appContext).padding.bottom -
                  widget.appBarHeight -
                  widget.bottomBarHeight -
                  MediaQuery.of(widget.appContext).padding.top -
                  widget._sizeConstraints.maxHeight;

              if (dy < 0) {
                dy = 0;
              } else if (dy > maxDy) {
                dy = maxDy;
              }
              if (dx < 0 ||
                  (dx + widget._sizeConstraints.maxWidth / 2) <
                      MediaQuery.of(widget.appContext).size.width / 2) {
                dx = 0;
              } else if ((dx + widget._sizeConstraints.maxWidth) >
                      MediaQuery.of(widget.appContext).size.width ||
                  (dx + widget._sizeConstraints.maxWidth / 2) >
                      MediaQuery.of(widget.appContext).size.width / 2) {
                dx = MediaQuery.of(widget.appContext).size.width -
                    widget._sizeConstraints.maxWidth;
              }

              Offset newOffset = new Offset(dx, dy);
              dynamicOffset = newOffset;
            });
          },
        ));
  }
}

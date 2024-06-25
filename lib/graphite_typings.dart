import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:graphite/core/typings.dart';

typedef NodeCellBuilder = Widget Function(BuildContext context, NodeInput node);

typedef OverlayBuilder = List<Widget> Function(
  BuildContext context,
  List<NodeInput> nodes,
  List<Edge> edges,
);

typedef EdgeLabelBuilder = Widget Function(
    BuildContext context, Edge edge, bool isVertical);

typedef ContentWrapperBuilder = Widget Function(
    BuildContext context, Size size, Widget child);

enum EdgeLabelTextAlignment {
  before,
  after,
}

enum EdgeLabelPositionPriority { horizontal, vertical, none }

/// List of params to draw labels on top or above the edges. Useful to comment
/// relations between entities.
class EdgeLabels {
  /// Label widget's builder function. Provides [Edge] details.
  final EdgeLabelBuilder builder;

  /// If set to [EdgeLabelTextAlignment.before] draws label before edge's line. Default value.
  /// If set to [EdgeLabelTextAlignment.after] draws label after edge's line.
  final EdgeLabelTextAlignment alignment;

  /// [EdgeLabelPositionPriority.horizontal] means to stick label to horizontal
  /// line inside edge path if possible.
  /// [EdgeLabelPositionPriority.vertical] means to stick label to vertical
  /// line inside edge path if possible.
  /// [EdgeLabelPositionPriority.none] default value, means to stick label to
  /// vertical line if graph's orientation is [MatrixOrientation.Horizontal]
  /// and to horizontal line of graph's orientation is [MatrixOrientation.Vertical].
  final EdgeLabelPositionPriority positionPriority;

  const EdgeLabels({
    required this.builder,
    this.alignment = EdgeLabelTextAlignment.before,
    this.positionPriority = EdgeLabelPositionPriority.none,
  });
}

typedef GestureNodeTapDownCallback = void Function(
    TapDownDetails details, MatrixNode node, Rect rect);
typedef GestureNodeTapUpCallback = void Function(
    TapUpDetails details, MatrixNode node, Rect rect);

typedef GestureNodeLongPressStartCallback = void Function(
    LongPressStartDetails details, MatrixNode node, Rect rect);
typedef GestureNodeLongPressEndCallback = void Function(
    LongPressEndDetails details, MatrixNode node, Rect rect);
typedef GestureNodeLongPressMoveUpdateCallback = void Function(
    LongPressMoveUpdateDetails details, MatrixNode node, Rect rect);
typedef GestureNodeForcePressStartCallback = void Function(
    ForcePressDetails details, MatrixNode node, Rect rect);
typedef GestureNodeForcePressEndCallback = void Function(
    ForcePressDetails details, MatrixNode node, Rect rect);
typedef GestureNodeForcePressPeakCallback = void Function(
    ForcePressDetails details, MatrixNode node, Rect rect);
typedef GestureNodeForcePressUpdateCallback = void Function(
    ForcePressDetails details, MatrixNode node, Rect rect);
typedef GestureNodePanStartCallback = void Function(
    DragStartDetails details, MatrixNode node, Rect rect);
typedef GestureNodePanUpdateCallback = void Function(
    DragUpdateDetails details, MatrixNode node, Rect rect);
typedef GestureNodePanDownCallback = void Function(
    DragDownDetails details, MatrixNode node, Rect rect);

typedef GestureBackgroundTapCallback = void Function(TapDownDetails details);
typedef EdgeStyleBuilder = EdgeStyle Function(Edge edge);
typedef GestureEdgeTapDownCallback = void Function(
    TapDownDetails details, Edge edge);
typedef GestureEdgeTapUpCallback = void Function(
    TapUpDetails details, Edge edge);

typedef GestureEdgeLongPressStartCallback = void Function(
    LongPressStartDetails details, Edge edge);
typedef GestureEdgeLongPressEndCallback = void Function(
    LongPressEndDetails details, Edge edge);
typedef GestureEdgeLongPressMoveUpdateCallback = void Function(
    LongPressMoveUpdateDetails details, Edge edge);
typedef GestureEdgeForcePressStartCallback = void Function(
    ForcePressDetails details, Edge edge);
typedef GestureEdgeForcePressEndCallback = void Function(
    ForcePressDetails details, Edge edge);
typedef GestureEdgeForcePressPeakCallback = void Function(
    ForcePressDetails details, Edge edge);
typedef GestureEdgeForcePressUpdateCallback = void Function(
    ForcePressDetails details, Edge edge);
typedef GestureEdgeDragStartCallback = void Function(
    DragStartDetails details, Edge edge);
typedef GestureEdgeDragUpdateCallback = void Function(
    DragUpdateDetails details, Edge edge);
typedef GestureEdgeDragDownCallback = void Function(
    DragDownDetails details, Edge edge);

typedef EdgePathBuilder = Path Function(NodeInput income, NodeInput node,
    List<List<double>> points, EdgeStyle style);

enum LineStyle { solid, dashed, dotted, dashDotted }

class EdgeStyle {
  /// [LineStyle] of edges to draw.
  final LineStyle lineStyle;

  /// [Paint] of edges to use in drawing.
  final Paint linePaint;

  /// border radius of edges angles.
  final double borderRadius;

  /// length of dash in [LineStyle.dashed]
  /// and [LineStyle.dashDotted] styles. Ignored if
  /// style is [LineStyle.solid] or [LineStyle.dotted].
  final double dashLength;

  /// length of a gap in [LineStyle.dotted], [LineStyle.dashed]
  /// and [LineStyle.dashDotted] styles. Ignored if
  /// style is [LineStyle.solid].
  final double gapLength;

  /// diameter of dot in [LineStyle.dotted]
  /// and [LineStyle.dashDotted] styles. Ignored if
  /// style is [LineStyle.solid] or [LineStyle.dashed].
  final double dotLength;

  /// the type of arrows on the edge.
  final EdgeArrowType arrowType;

  /// is the length (in pixels) of each of the 2 lines making the arrow.
  /// Ignored if using custom [pathBuilder] is set.
  final double tipLength;

  /// [tipAngle] is the angle (in radians) between each of the 2 lines making the arrow and the curve at this point.
  /// Ignored if using custom [pathBuilder] is set.
  final double tipAngle;

  EdgeStyle({
    Paint? linePaint,
    this.lineStyle = LineStyle.solid,
    this.borderRadius = 0,
    this.dashLength = 10,
    this.gapLength = 5,
    this.dotLength = 2,
    this.arrowType = EdgeArrowType.one,
    this.tipAngle = pi * 0.1,
    this.tipLength = 10.0,
  }) : this.linePaint = linePaint ??
            (Paint()
              ..color = Color(0xFF000000)
              ..style = PaintingStyle.stroke
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round
              ..strokeWidth = 2);
}

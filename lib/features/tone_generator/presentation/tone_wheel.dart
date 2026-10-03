import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/frequency_mapper.dart';
import '../domain/wheel_angle.dart';
import 'tone_generator_controller.dart';
import 'tone_wheel_painter.dart';

/// The circular dial: dragging around it retunes the frequency
/// continuously, while a click/tap (little or no movement) toggles playback.
class ToneWheel extends ConsumerStatefulWidget {
  const ToneWheel({super.key, this.size = 260});

  final double size;

  @override
  ConsumerState<ToneWheel> createState() => _ToneWheelState();
}

class _ToneWheelState extends ConsumerState<ToneWheel> {
  /// How far the pointer may move before a press counts as a drag instead
  /// of a tap. Deliberately the same for mouse and touch: Flutter's default
  /// pan slop for a mouse is only ~2 px, which turned slightly shaky clicks
  /// into drags so playback never toggled on desktop.
  static const double _dragThreshold = 10;

  Offset? _pointerDownPosition;
  bool _isDragging = false;

  void _updateFrequencyFromLocalPosition(Offset localPosition) {
    final center = Offset(widget.size / 2, widget.size / 2);
    final angle = WheelAngle.angleFromOffset(localPosition - center);
    final fraction = WheelAngle.fractionFromAngle(angle);
    ref
        .read(toneGeneratorControllerProvider.notifier)
        .setFrequencyFromWheelFraction(fraction);
  }

  void _onPointerDown(PointerDownEvent event) {
    _pointerDownPosition = event.localPosition;
    _isDragging = false;
  }

  void _onPointerMove(PointerMoveEvent event) {
    final downPosition = _pointerDownPosition;
    if (downPosition == null) {
      return;
    }
    if (!_isDragging &&
        (event.localPosition - downPosition).distance > _dragThreshold) {
      _isDragging = true;
    }
    if (_isDragging) {
      _updateFrequencyFromLocalPosition(event.localPosition);
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    final wasTap = _pointerDownPosition != null && !_isDragging;
    _pointerDownPosition = null;
    _isDragging = false;
    if (wasTap) {
      ref.read(toneGeneratorControllerProvider.notifier).toggle();
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _pointerDownPosition = null;
    _isDragging = false;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(toneGeneratorControllerProvider);
    final fraction = FrequencyMapper.fractionFromFrequency(state.frequencyHz);

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CustomPaint(
          painter: ToneWheelPainter(
            fraction: fraction,
            isPlaying: state.isPlaying,
          ),
        ),
      ),
    );
  }
}

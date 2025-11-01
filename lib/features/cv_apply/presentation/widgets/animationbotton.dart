import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isDisabled;

  const AnimatedButton({
    required this.label,
    required this.onPressed,
    required this.isPrimary,
    this.isDisabled = false,
  });

  @override
  __AnimatedButtonState createState() => __AnimatedButtonState();
}

class __AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isDisabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = kIsWeb && !widget.isDisabled),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: widget.isDisabled ? null : (_) => _scaleController.forward(),
        onTapUp: widget.isDisabled ? null : (_) {
          _scaleController.reverse();
          widget.onPressed?.call();
        },
        onTapCancel: widget.isDisabled ? null : () => _scaleController.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.isDisabled
                    ? [Colors.grey.shade400, Colors.grey.shade600]
                    : widget.isPrimary
                    ? (_isHovered
                    ? [Colors.blue.shade500, Colors.blue.shade700]
                    : [Colors.blue.shade700, Colors.blue.shade900])
                    : (_isHovered
                    ? [Colors.grey.shade300, Colors.grey.shade400]
                    : [Colors.grey.shade200, Colors.grey.shade300]),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: widget.isDisabled
                      ? Colors.grey.withOpacity(0.2)
                      : widget.isPrimary
                      ? Colors.blue.withOpacity(_isHovered ? 0.4 : 0.2)
                      : Colors.grey.withOpacity(_isHovered ? 0.4 : 0.2),
                  blurRadius: _isHovered ? 12 : 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                color: widget.isDisabled
                    ? Colors.white70
                    : widget.isPrimary
                    ? Colors.white
                    : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Envelope focavel por D-pad/toque. Aplica escala + brilho no foco
/// (padrao Leanback). Usa [FocusableActionDetector] nativo do Flutter,
/// sem dependencias externas.
class FocusableCard extends StatefulWidget {
  const FocusableCard({
    super.key,
    required this.child,
    required this.onSelected,
    this.focusScale = 1.08,
    this.borderRadius = 12,
    this.autofocus = false,
    this.padding = const EdgeInsets.all(6),
  });

  final Widget child;
  final VoidCallback onSelected;
  final double focusScale;
  final double borderRadius;
  final bool autofocus;
  final EdgeInsets padding;

  @override
  State<FocusableCard> createState() => _FocusableCardState();
}

class _FocusableCardState extends State<FocusableCard> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: FocusableActionDetector(
        autofocus: widget.autofocus,
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onSelected();
              return null;
            },
          ),
          ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
            onInvoke: (_) {
              widget.onSelected();
              return null;
            },
          ),
        },
        onShowFocusHighlight: (v) => setState(() => _focused = v),
        onShowHoverHighlight: (v) => setState(() => _focused = v),
        child: GestureDetector(
          onTap: widget.onSelected,
          child: AnimatedScale(
            scale: _focused ? widget.focusScale : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: _focused
                    ? [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.45),
                          blurRadius: 20,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
                border: Border.all(
                  color: _focused ? Colors.white : Colors.transparent,
                  width: _focused ? 3 : 0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Intencao de ativacao por botao (OK/Enter no controle).
class ButtonActivateIntent extends Intent {
  const ButtonActivateIntent();
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBuilderAndTransformPage extends StatefulWidget {
  const AnimatedBuilderAndTransformPage({super.key});

  @override
  State<AnimatedBuilderAndTransformPage> createState() => _AnimatedBuilderAndTransformPageState();
}

class _AnimatedBuilderAndTransformPageState extends State<AnimatedBuilderAndTransformPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String _axis = 'Y';
  Alignment _alignment = Alignment.center;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _setAxis(String axis) {
    setState(() {
      _axis = axis;
    });
  }

  void _setAlignment(Alignment alignment) {
    setState(() {
      _alignment = alignment;
    });
  }

  ButtonStyle _getButtonStyle(bool isActive) {
    return ElevatedButton.styleFrom(
      backgroundColor: isActive ? Colors.deepPurple : Colors.grey.shade300,
      foregroundColor: isActive ? Colors.white : Colors.black87,
      textStyle: TextStyle(
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter AnimatedBuilder and Transform')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          spacing: 10,
          children: <Widget>[
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => _setAxis('X'),
                  style: _getButtonStyle(_axis == 'X'),
                  child: const Text("X Rotate"),
                ),
                ElevatedButton(
                  onPressed: () => _setAxis('Y'),
                  style: _getButtonStyle(_axis == 'Y'),
                  child: const Text("Y Rotate"),
                ),
                ElevatedButton(
                  onPressed: () => _setAxis('Z'),
                  style: _getButtonStyle(_axis == 'Z'),
                  child: const Text("Z Rotate"),
                ),
              ],
            ),
            Divider(),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildAlignmentButton("Center", Alignment.center),
                _buildAlignmentButton("centerLeft", Alignment.centerLeft),
                _buildAlignmentButton("centerRight", Alignment.centerRight),
                _buildAlignmentButton("topCenter", Alignment.topCenter),
                _buildAlignmentButton("topLeft", Alignment.topLeft),
                _buildAlignmentButton("topRight", Alignment.topRight),
                _buildAlignmentButton("bottomCenter", Alignment.bottomCenter),
                _buildAlignmentButton("bottomLeft", Alignment.bottomLeft),
                _buildAlignmentButton("bottomRight", Alignment.bottomRight),
              ],
            ),
            Divider(),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                Matrix4 transform = Matrix4.identity();
                switch (_axis) {
                  case 'X':
                    transform.rotateX(_animation.value);
                    break;
                  case 'Y':
                    transform.rotateY(_animation.value);
                    break;
                  case 'Z':
                    transform.rotateZ(_animation.value);
                    break;
                }

                return Transform(
                  alignment: _alignment,
                  transform: transform,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlignmentButton(String label, Alignment alignment) {
    return ElevatedButton(
      onPressed: () => _setAlignment(alignment),
      style: _getButtonStyle(_alignment == alignment),
      child: Text(label),
    );
  }
}

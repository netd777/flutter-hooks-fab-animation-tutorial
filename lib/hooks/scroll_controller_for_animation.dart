import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_hooks/hooks/lifecycle_hook.dart';

ScrollController useScrollControllerForAnimation(
  AnimationController animationController,
) {
  return Hook.use(LifecycleHook<ScrollController>(
    initHook: (hook) {
      hook.state = ScrollController();
      hook.state.addListener(() {
        switch (hook.state.position.userScrollDirection) {
          case ScrollDirection.forward:
            animationController.forward();
            break;
          case ScrollDirection.reverse:
            animationController.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      });
      debugPrint('Init AnimationController!');
    },
    dispose: (hook) {
      hook.state.dispose();
      debugPrint('Disposed AnimationController!');
    }
  ));
}
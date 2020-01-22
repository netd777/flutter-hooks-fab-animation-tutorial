import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LifecycleHook<T> extends Hook<T> {
  final Function(BuildContext, LifecycleHookState<T>) builder;
  final void Function(LifecycleHookState<T>) initHook;
  final void Function(LifecycleHookState<T>) dispose;
  final void Function(LifecycleHookState<T>) didBuild;
  final void Function(LifecycleHookState<T>, LifecycleHook<T> oldHook) didUpdateHook;

  const LifecycleHook({
    this.builder,
    this.initHook,
    this.dispose,
    this.didBuild,
    this.didUpdateHook,
  }) : super();

  @override
  LifecycleHookState<T> createState() => LifecycleHookState<T>();
}

class LifecycleHookState<T> extends HookState<T, LifecycleHook<T>> {
  T state;

  // Build doesn't return a Widget but rather the Lifecycle
  @override
  T build(BuildContext context) => (hook.builder ?? (_, __) => state)(context, this);

  @override
  void initHook() => (hook.initHook != null) ? hook.initHook(this) : null;

  @override
  void dispose() => (hook.dispose != null) ? hook.dispose(this) : null;

  @override
  void didBuild() => (hook.didBuild != null) ? hook.didBuild(this) : null;

  @override
  void didUpdateHook(LifecycleHook<T> oldHook) =>
      (hook.didUpdateHook != null) ? hook.didUpdateHook(this, oldHook) : null;
}

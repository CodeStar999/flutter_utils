import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controller/lifecycle_mixin.dart';
import 'lifecycle_observer_widget.dart';
import 'provider_context_extension.dart';

class ProviderStateBuilder<T extends LifecycleMixin> extends StatelessWidget {
  final int? pageIndex;
  final T Function(BuildContext context)? create;
  final T? value;
  final Widget child;

  const ProviderStateBuilder({
    super.key,
    this.pageIndex,
    this.create,
    this.value,
    required this.child,
  }) : assert(
            (create == null && value != null) ||
                (create != null && value == null),
            'create or value can not be null');

  @override
  Widget build(BuildContext context) {
    final builder = Builder(builder: (cxt) {
      return LifecycleObserverWidget<T>(
        pageIndex: pageIndex,
        controller: cxt.rc<T>(),
        builder: (BuildContext context) {
          return child;
        },
      );
    });

    if (value != null) {
      return ChangeNotifierProvider<T>.value(
        value: value!,
        child: builder,
      );
    }

    return ChangeNotifierProvider<T>(
      create: create!,
      child: builder,
    );
  }
}

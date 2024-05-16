import 'package:flutter/material.dart';

import '../provider/controller/lifecycle_mixin.dart';
import '../provider/widget/provider_context_extension.dart';

abstract class CommonState<T extends StatefulWidget, C extends LifecycleMixin>
    extends State<T> {
  @override
  Widget build(BuildContext context) {
    return providerStateBuild(context, context.rc<T>());
  }

  Widget providerStateBuild(BuildContext context, T controller);
}

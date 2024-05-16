import 'package:flutter/material.dart';

import '../provider/controller/lifecycle_mixin.dart';
import '../provider/widget/provider_context_extension.dart';

abstract class CommonPage<T extends LifecycleMixin> extends StatelessWidget {
  const CommonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return providerStateBuild(context, context.rc<T>());
  }

  Widget providerStateBuild(BuildContext context, T controller);
}

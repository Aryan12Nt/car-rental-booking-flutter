import 'package:flutter/material.dart';

import 'text_extension.dart';

/// Common AppBar widget for the app
/// Provides consistent styling and navigation actions
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title.titleMedium(context: context),
      actions: actions,
      automaticallyImplyLeading: showBackButton,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      leading: showBackButton && onBackPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed,
              tooltip: 'Back',
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

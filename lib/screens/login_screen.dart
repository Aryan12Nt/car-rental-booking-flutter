import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/ui_provider.dart';
import '../router/app_routes.dart';
import '../utils/app_strings.dart';
import '../utils/app_theme.dart';
import '../utils/back_button_handler.dart';
import '../widgets/text_extension.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final uiProvider = context.watch<UIProvider>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, r) {
        if (!didPop) {
          if (BackButtonHandler.handleDoubleBackPress(context)) {
            // Exit app
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              controller: uiProvider.scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingXL,
                vertical: AppTheme.spacingXL,
              ),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingXXL),
                  child: Form(
                    key: uiProvider.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // App Icon/Logo
                        Icon(
                          Icons.directions_car,
                          size: AppTheme.iconSizeXXL,
                          color: AppTheme.primaryColor(context),
                        ),
                        const SizedBox(height: AppTheme.spacingXL),

                        // Title
                        AppStrings.loginTitle.headlineMedium(
                          context: context,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppTheme.spacingS),

                        // Subtitle
                        AppStrings.loginSubtitle.bodyMedium(
                          context: context,
                          variant: true,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppTheme.spacingXXL),

                        // Email/Phone Number Field
                        TextFormField(
                          controller: uiProvider.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: AppStrings.emailOrPhoneLabel,
                            hintText: AppStrings.emailOrPhoneHint,
                            prefixIcon: const Icon(Icons.person_outline),
                            errorMaxLines: 2,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppTheme.borderRadiusM,
                              ),
                            ),
                          ),
                          validator: uiProvider.validateEmail,
                        ),
                        const SizedBox(height: AppTheme.spacingL),

                        // Password Field
                        TextFormField(
                          controller: uiProvider.passwordController,
                          obscureText: uiProvider.obscurePassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submitLogin(context),
                          decoration: InputDecoration(
                            labelText: AppStrings.passwordLabel,
                            hintText: AppStrings.passwordHint,
                            prefixIcon: const Icon(Icons.lock_outline),
                            errorMaxLines: 2,
                            suffixIcon: IconButton(
                              icon: Icon(
                                uiProvider.obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: () {
                                context
                                    .read<UIProvider>()
                                    .togglePasswordVisibility();
                              },
                              tooltip: uiProvider.obscurePassword
                                  ? AppStrings.showPassword
                                  : AppStrings.hidePassword,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppTheme.borderRadiusM,
                              ),
                            ),
                          ),
                          validator: uiProvider.validatePassword,
                        ),
                        const SizedBox(height: AppTheme.spacingXXL),

                        // Login Button
                        FilledButton(
                          onPressed: authProvider.isLoading
                              ? null
                              : () => _submitLogin(context),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppTheme.spacingL,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppTheme.borderRadiusM,
                              ),
                            ),
                          ),
                          child: authProvider.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : AppStrings.loginButton.custom(
                                  context: context,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.surfaceColor(context),
                                ),
                        ),
                        // Extra bottom padding to ensure error text is visible
                        const SizedBox(height: AppTheme.spacingL),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitLogin(BuildContext context) {
    final uiProvider = context.read<UIProvider>();
    final authProvider = context.read<AuthProvider>();

    uiProvider.submitLogin(
      authProvider,
      onSuccess: () {
        if (context.mounted) {
          context.go(AppRoutes.cars);
        }
      },
      onError: (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppStrings.loginFailed}$error'),
              backgroundColor: AppTheme.errorColor(context),
            ),
          );
        }
      },
    );
  }
}

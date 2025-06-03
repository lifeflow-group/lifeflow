import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controllers/login_controller.dart';
import 'widgets/social_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final obscureText = ref.watch(obscureTextProvider);
    final controller = ref.read(loginControllerProvider);

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180,
                        child: Center(
                          child: Image.asset(
                            'assets/logos/lifeflow_circle.png',
                            width: 64,
                            height: 64,
                          ),
                        ),
                      ),
                      Text(
                        l10n.loginTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 24),
                      TextField(
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          hintText: l10n.usernameHint,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.normal),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                              width: 0.4,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Password field
                      TextField(
                        obscureText: obscureText,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          hintText: l10n.passwordHint,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.normal),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                              width: 0.4,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 0.8,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                            onPressed: controller.toggleObscureText,
                          ),
                        ),
                      ),

                      SizedBox(height: 32),

                      // Log in button
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Implement login functionality
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          l10n.loginButton,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      SizedBox(height: 4),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () async {
                          // Di chuyển tất cả tracking sang controller
                          final userId = await controller.loginAsGuest();

                          // Navigate to the main screen if login successful
                          if (userId != null && context.mounted) {
                            context.goNamed(
                                'main'); // Sử dụng goNamed của GoRouter
                          }
                        },
                        child: Text(
                          l10n.continueAsGuest,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: 4),
                      // Reset password
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            // TODO: Implement reset password functionality
                          },
                          child: Text(
                            l10n.forgotPassword,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionHandleColor),
                          ),
                        ),
                      ),

                      // OR separator
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(l10n.orSeparator),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Social buttons
                      SocialButton(
                        color: Theme.of(context).colorScheme.surface,
                        textColor: Theme.of(context).colorScheme.onSurface,
                        text: l10n.continueWithFacebook,
                        iconWidget: Image.asset(
                          'assets/logos/facebook.png',
                          width: 32,
                          height: 32,
                        ),
                        border: BorderSide(
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
                        onPressed: () {
                          // TODO: Implement Login with Facebook functionality
                        },
                      ),
                      SizedBox(height: 16),
                      SocialButton(
                        color: Theme.of(context).colorScheme.surface,
                        text: l10n.continueWithGoogle,
                        iconWidget: Image.asset(
                          'assets/logos/google.png',
                          width: 32,
                          height: 32,
                        ),
                        textColor: Theme.of(context).colorScheme.onSurface,
                        border: BorderSide(
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
                        onPressed: () {
                          // TODO: Implement Login with Google functionality
                        },
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.noAccount,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              // TODO: Navigate to the Sign Up screen
                            },
                            child: Text(
                              l10n.signUpButton,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionHandleColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

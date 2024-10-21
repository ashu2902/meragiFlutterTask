import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_state.dart';
import 'widgets/login_form.dart';
import 'widgets/social_login_buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(MediaQuery.of(context).size.width.toString());

    log(MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.desktop ||
                sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
              return _buildWideLayout(context);
            } else {
              return _buildNarrowLayout(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: const Color(0xffF5DBC4),
            child: Center(
              child: SvgPicture.asset(
                'assets/travel_illustration.svg',
                width: 300,
                height: 300,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: _buildLoginContent(context),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: const Color(0xFF029664),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/travalizer_logo.svg',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Travalizer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                AspectRatio(
                  aspectRatio: 428 / 200,
                  child: Container(
                    color: const Color(0xFFF5DBC4),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/travel_illustration.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildLoginContent(context),
        ],
      ),
    );
  }

  Widget _buildLoginContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AutoSizeText(
            'Artificial Intelligence giving you travel recommendations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff355B3E),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          const AutoSizeText(
            'Welcome Back, Please login to your account',
            style: TextStyle(fontSize: 16, color: Color(0xff58745E)),
            maxLines: 1,
          ),
          const SizedBox(height: 24),
          const LoginForm(),
          const SizedBox(height: 16),
          const AutoSizeText(
            'Or, login with',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff58745E)),
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          const SocialLoginButtons(),
          const SizedBox(height: 16),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator();
              } else if (state is AuthFailure) {
                return AutoSizeText(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                  maxLines: 2,
                );
              } else if (state is AuthSuccess) {
                return AutoSizeText('Welcome, ${state.user.email}!',
                    maxLines: 1);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

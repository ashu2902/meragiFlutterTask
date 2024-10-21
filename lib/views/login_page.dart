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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome, ${state.user.email}!'),
              backgroundColor: Colors.green,
            ),
          );
          // TODO: Navigate to home page or dashboard
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                body: SafeArea(
                  child: ResponsiveBuilder(
                    builder: (context, sizingInformation) {
                      if (sizingInformation.deviceScreenType ==
                              DeviceScreenType.desktop ||
                          sizingInformation.deviceScreenType ==
                              DeviceScreenType.tablet ||
                          MediaQuery.of(context).orientation ==
                              Orientation.landscape) {
                        return _buildWideLayout(context);
                      } else {
                        return _buildNarrowLayout(context);
                      }
                    },
                  ),
                ),
              ),
              if (state is AuthLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF029664)),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: SvgPicture.asset(
                          'assets/travalizer_logo.svg',
                          width: 24,
                          height: 24,
                          color: Color(0xff355B3E),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Travalizer',
                        style: TextStyle(
                          color: Color(0xFF355B3E),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildLoginContent(context),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: const Color(0xFFF5DBC4),
              child: SvgPicture.asset(
                'assets/travel_illustration.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
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
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AutoSizeText(
            'Artificial Intelligence giving you travel recommendations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff355B3E),
            ),
            maxLines: 2,
          ),
          SizedBox(height: 12),
          AutoSizeText(
            'Welcome Back, Please login to your account',
            style: TextStyle(fontSize: 16, color: Color(0xff58745E)),
            maxLines: 1,
          ),
          SizedBox(height: 24),
          LoginForm(),
          SizedBox(height: 16),
          AutoSizeText(
            'Or, login with',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff58745E)),
            maxLines: 1,
          ),
          SizedBox(height: 8),
          SocialLoginButtons(),
        ],
      ),
    );
  }
}

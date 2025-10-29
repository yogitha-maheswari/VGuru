import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';


class SignUp5 extends StatefulWidget {
  const SignUp5({super.key});

  @override
  State<SignUp5> createState() => _SignUp5State();
}

class _SignUp5State extends State<SignUp5> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  bool _isOtpInvalid = false;
  bool _nonNumericEntered = false;
  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _onContinue() {
    String otp = _otpControllers.map((e) => e.text).join();

    if (otp.length < 6 || _nonNumericEntered) {
      setState(() {
        _isOtpInvalid = true;
      });
      return;
    }

    setState(() {
      _isOtpInvalid = false;
    });

    // TODO: Add OTP validation logic here
    Navigator.pushReplacementNamed(context, '/signup6');
  }

  Widget _buildOtpField(int index, ThemeData theme) {
    return SizedBox(
      width: 45,
      child: TextField(
        focusNode: _focusNodes[index],
        controller: _otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: _isOtpInvalid
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.onSurface.withOpacity(0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: _isOtpInvalid
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.primary,
              width: 2,
            ),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _nonNumericEntered =
                value.isNotEmpty && !RegExp(r'^[0-9]$').hasMatch(value);
            if (_nonNumericEntered) _isOtpInvalid = true;
          });

          if (value.isNotEmpty && index < 5 && !_nonNumericEntered) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
        onSubmitted: (_) => _onContinue(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProvider = Provider.of<UserProvider>(context);

    // Format number (e.g., +91 9876543210)
    final displayNumber =
        "${userProvider.countryCode ?? ""} ${userProvider.phoneNumber ?? ""}";

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pushNamed(context, '/signup4'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              "4/10",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxContentWidth =
                constraints.maxWidth < 600 ? constraints.maxWidth : 480;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "OTP Verification",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: LayoutBuilder(
                      builder: (context, constraints) {
                        bool shouldWrap = constraints.maxWidth < 350;
                        return Text(
                        "Enter the 6-digit OTP sent to your number: $displayNumber",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                        softWrap: shouldWrap,
                        overflow: shouldWrap ? TextOverflow.visible : TextOverflow.ellipsis,
                        );
                      },
                      ),
                    ),

                    const SizedBox(height: 32),

                    // OTP Fields
                    SizedBox(
                      width: 320,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          6,
                          (index) => Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: SizedBox(
                                height: 56,
                                child: _buildOtpField(index, theme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    if (_isOtpInvalid)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _nonNumericEntered
                              ? "Only numeric values allowed"
                              : "Please enter a valid 6-digit OTP",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    const SizedBox(height: 32),

                    // Continue button
                    SizedBox(
                      width: 320,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _onContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "CONTINUE",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "$_secondsRemaining seconds remaining",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Resend OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't receive OTP? ",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("OTP resent")),
                            );
                            _startTimer();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(40, 20),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "RESEND",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

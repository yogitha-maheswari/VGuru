import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:vguru/pages/provider/user_provider.dart';

class SignUp4 extends StatefulWidget {
  const SignUp4({super.key});

  @override
  State<SignUp4> createState() => _SignUp4State();
}

class _SignUp4State extends State<SignUp4> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();

  String _selectedCode = "+91"; // default country code

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () {
            Navigator.pushNamed(context, '/signup3');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              "3/10",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "What's your phone number?",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Row with country code + phone input
                      Row(
                        children: [
                          // Country Code Picker Box
                          SizedBox(
                            height: 48, 
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: theme.colorScheme.onSurface.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: CountryCodePicker(
                                  onChanged: (code) {
                                    setState(() {
                                      _selectedCode = code.dialCode ?? "+91";
                                    });
                                  },
                                  initialSelection: "IN", // default India
                                  favorite: const ["+91", "IN", "+1", "US"],

                                  textStyle: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  dialogTextStyle: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  dialogBackgroundColor: theme.colorScheme.surface,

                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Phone Number Input
                          Expanded(
                            child: SizedBox(
                              height: 48, // same height
                              child: TextFormField(
                                controller: _numberController,
                                keyboardType: TextInputType.phone,
                                style: theme.textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  hintText: "Phone number",
                                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter your number";
                                  }
                                  if (value.length < 7) {
                                    return "Enter valid number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Save country code + number separately
                              Provider.of<UserProvider>(context, listen: false)
                                  .setPhoneNumber(
                                _selectedCode,
                                _numberController.text.trim(),
                              );

                              Navigator.pushReplacementNamed(
                                  context, '/signup5'); 
                            }
                          },
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

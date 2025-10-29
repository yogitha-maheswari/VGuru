import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:vguru/pages/provider/user_provider.dart';

class SignUp9 extends StatefulWidget {
  const SignUp9({super.key});

  @override
  State<SignUp9> createState() => _SignUp9State();
}

class _SignUp9State extends State<SignUp9> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentEmailController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();

  String _selectedParentCode = "+91"; // default India

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
            Navigator.pushNamed(context, '/signup8');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              "8/10",
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
                        "Parent's Details",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// Parent Name
                      TextFormField(
                        controller: _parentNameController,
                        textCapitalization: TextCapitalization.words,
                        style: theme.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: "Parent's Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Parent's name is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      /// Parent Email
                      TextFormField(
                        controller: _parentEmailController,
                        keyboardType: TextInputType.emailAddress,
                        style: theme.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: "Parent's Email ID",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Parent's email is required";
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      /// Parent Phone (country code + number)
                      Row(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: CountryCodePicker(
                                  onChanged: (code) {
                                    setState(() {
                                      _selectedParentCode =
                                          code.dialCode ?? "+91";
                                    });
                                  },
                                  initialSelection: "IN",
                                  favorite: const ["+91", "IN", "+1", "US"],
                                  textStyle: theme.textTheme.bodyMedium
                                      ?.copyWith(
                                          color: theme.colorScheme.onSurface),
                                  dialogTextStyle: theme.textTheme.bodyMedium,
                                  dialogBackgroundColor:
                                      theme.colorScheme.surface,
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: TextFormField(
                                controller: _parentPhoneController,
                                keyboardType: TextInputType.phone,
                                style: theme.textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  hintText: "Parent's Phone Number",
                                  hintStyle:
                                      theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Parent's phone number is required";
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

                      /// Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String parentName =
                                  _parentNameController.text.trim();
                              String parentEmail =
                                  _parentEmailController.text.trim();
                              String parentPhone =
                                  _parentPhoneController.text.trim();

                              // Save to UserProvider
                              Provider.of<UserProvider>(context, listen: false)
                                  .setParentDetails(
                                parentName,
                                parentEmail,
                                _selectedParentCode,
                                parentPhone,
                              );

                              Navigator.pushReplacementNamed(
                                  context, '/signup10');
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

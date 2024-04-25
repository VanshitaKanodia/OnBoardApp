import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios),
          actions: [
            TextButton(onPressed: () {}, child: const Text('Change Number'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enter authentication code',
                style: TextStyle(
                  color: Color(0xFF090A0A),
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                'Enter the 4-digit code that we have sent via the phone number +91 1234567890',
                style: TextStyle(
                  color: Color(0xFF090A0A),
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: OtpTextField(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  fieldWidth: 60,
                  numberOfFields: 4,
                  borderColor: const Color(0xFF512DA8),
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    verificationCode = '';
                  }, // end onSubmit
                ),
              ),
              GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        width: 327,
                        height: 48,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF6A4DFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              height: 0.05,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Resend Code',
                            style: TextStyle(
                              color: Color(0xFF2563EB),
                              fontSize: 14,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              height: 0.11,
                            ),
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

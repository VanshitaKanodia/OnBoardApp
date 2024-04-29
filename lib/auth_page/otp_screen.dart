import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  OtpFieldController otpController = OtpFieldController();
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
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Enter authentication code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF090A0A),
                  fontSize: 24,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  height: 0.06,
                ),
              ),
              SizedBox(height: 20,),
              const Text(
                'Enter the 4-digit code that we have sent via the phone number +91 1234567890',
                style: TextStyle(
                  color: Color(0xFF090A0A),
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: OTPTextField(
                    controller: otpController,
                    length: 5,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 20,
                    fieldStyle: FieldStyle.underline,
                    style: TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      print("Changed: " + pin);
                    },
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    }),
              ),
                // OtpTextField(
                //   // borderRadius: const BorderRadius.all(Radius.circular(280)),
                //   fieldWidth: 55,
                //   numberOfFields: 6,
                //   borderColor: const Color(0xFF512DA8),
                //   showFieldAsBox: true,
                //   onCodeChanged: (String code) {},
                //   onSubmit: (String verificationCode) {
                //     verificationCode = '';
                //   }, // end onSubmit
                // ),
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
      )
    );
  }
}

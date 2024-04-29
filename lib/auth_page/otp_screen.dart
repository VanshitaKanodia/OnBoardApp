import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  OtpFieldController otpController = OtpFieldController();

  var code = "";

  // Assume expectedOTP is the OTP received from the server
  String expectedOTP = "654321"; // Example OTP, replace it with your actual OTP
  void verifyOTP() {
    String enteredOTP = otpController.toString();

    if (enteredOTP == expectedOTP) {
      // OTP verification successful
      print("OTP verification successful");
      // Proceed with login process
      // Call your login function here or navigate to the next screen
    } else {
      // OTP verification failed
      print("OTP verification failed");
      // Show error message or handle accordingly
    }
  }

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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: OTPTextField(
                    controller: otpController,
                    length: 6,
                    // Set the length to 6 digits
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 30,
                    // Increase the field width to accommodate 6 digits
                    fieldStyle: FieldStyle.underline,
                    style: TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      print("Changed: " + pin);
                    },
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                      verifyOTP();
                    },
                  ),

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
                    onTap: () {
                      verifyOTP();
                    },
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

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.phoneNum});
  final String phoneNum;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  OtpFieldController _otpController = OtpFieldController();

  Future<void> resendVerificationCode(String userPhoneNum) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = await http.Request(
          'POST', Uri.parse('https://dev.iwayplus.in/auth/otp/send'));
      request.body = json.encode({
        "username": userPhoneNum // Use the provided phone number directly
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response);

      if (response.statusCode == 200) {
        print('=====----OTP Resent Successfully---=======');
        // No need to navigate to OTP page again here
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('-----Error occurred while sending OTP---:-> $e');
    }
  }


  void verifyOTP(String otp) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('https://dev.iwayplus.in/auth/otp/token'));
      request.body = json.encode({
        'username': '${widget.phoneNum}',
        'otp': otp
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('-----OTP Verified Successfully------:  ${response.statusCode}');
        await Navigator.pushNamed(context, 'home_page');
        print(await response.stream.bytesToString());
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP Verification failed. Please try again'),
            ));
        print('---------otp failed $response.reasonPhrase');
      }
    }
    catch (e) {
      print('Error Occured while Verify OTP====: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext Context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },);
              },
            ),
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
                  'Enter the 4-digit code that we have sent via the phone number',
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
                    controller: _otpController,
                    length: 6,
                    // Set the length to 6 digits
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 30,
                    // Increase the field width to accommodate 6 digits
                    fieldStyle: FieldStyle.underline,
                    style: TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      print("=====Changed======: " + pin);
                    },
                    onCompleted: (pin) {
                      print("------Completed-----: " + pin);
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
                    onTap: () async {
                      String enteredOTP = _otpController.toString();
                      verifyOTP(enteredOTP);
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
                        Semantics(
                          label: 'Resend button',
                          hint: 'Double tap to resend',
                          child: TextButton(
                              onPressed: () {
                                print('printing number');
                                print(widget.phoneNum.toString());
                                resendVerificationCode(widget.phoneNum);
                              },
                              child: const Text(
                                'Resend Code',
                                style: TextStyle(
                                  color: Color(0xFF2563EB),
                                  fontSize: 14,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        )
    );
  }
}

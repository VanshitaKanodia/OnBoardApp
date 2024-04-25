import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwayplus_bluetooth/auth_page/otp_screen.dart';

class SignInPage extends StatefulWidget {

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final countryPicker = FlCountryCodePicker();
  late CountryCode countryCode;
  // TextEditingController countryCode = TextEditingController();
 // Default country code
  @override

  void initState() {
    // TODO: implement initState
    // countryCode.text = "+91";
    super.initState();
  }

  var phone = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage()));
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back.',
              style: TextStyle(
                color: Color(0xFF090A0A),
                fontSize: 16,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                height: 0.06,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Log in to your account',
              style: TextStyle(
                color: Color(0xFF090A0A),
                fontSize: 16,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                height: 0.06,
              ),
            ),
            SizedBox(height: 46,),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: DropdownButton<String>(
                    // value: _selectedCountryCode,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        // _selectedCountryCode = newValue!;
                      });
                    },
                    items: <String>['+1', '+91', '+44', '+81'] // Add your country codes here
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              //   TextFormField(
              //     keyboardType: TextInputType.phone,
              //     decoration: InputDecoration(
              //       hintText: 'Enter your phone number',
              //     ),
              //   ),
              // );
              // InputDecoration(
              //   labelText: 'Mobile Number',
              //   hintText: 'Enter your phone number',
              //   border: OutlineInputBorder(),
              // ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Text(
                'You will receive an SMS verification that may apply message and data rates.',
                style: TextStyle(
                  color: Color(0xFF6C7072),
                  fontSize: 12,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2, // Set the maximum number of lines to 2
                overflow: TextOverflow.ellipsis, // Specify how overflowing text should be handled
              ),
            ),
            GestureDetector(
                onTap: () {
                  print('Tapped');
                },
                child: Column(
                  children: [
                    Container(
                      width: 327,
                      height: 48,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: ShapeDecoration(
                        color: Color(0xFF6A4DFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(48),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Log in',
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account? ',
                            style: TextStyle(
                              color: Color(0xFF71717A),
                              fontSize: 14,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              height: 0.11,
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text( 'Sign up',
                                style: TextStyle(
                                  color: Color(0xFF2563EB),
                                  fontSize: 14,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  height: 0.11,
                                ),
                              )
                          )]),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

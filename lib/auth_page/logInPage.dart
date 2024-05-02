import 'dart:convert';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iwayplus_bluetooth/auth_page/otp_screen.dart';
import 'package:http/http.dart' as http;

class LogInPage extends StatefulWidget {


  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final countryPicker = FlCountryCodePicker();
  CountryCode? countrycode;
  TextEditingController countryCode = TextEditingController();
  TextEditingController authPhoneNumber = TextEditingController();

  Future<void> login(String userPhoneNum) async {
   try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = await http.Request('POST', Uri.parse('https://dev.iwayplus.in/auth/otp/send'));
      request.body = json.encode({
        "username": '+919729391756'
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response);

      if (response.statusCode == 200) {
        print('=====----Account Logged In Successfully---=======');
        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(phoneNum: '${userPhoneNum}')));
        print(response.request);
      }
      else {
        print(response.reasonPhrase);
      }
   } catch(e){
     print('-----Error occurred while sending OTP---:-> $e');
   }
  }
 // Default country code
  @override

  void initState() {
    // TODO: implement initState
    countryCode.text = "+91";
    super.initState();
  }

  var phone = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(phoneNum: )));
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
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
    //         Container(
    //           height: 50,
    //           width: MediaQuery.sizeOf(context).width,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(8),
    //             border: Border.all(width: 1, color: Color(0xFFE3E4E5),),
    //           ),
    //           child:
    //           Row(
    //             children: [
    //               GestureDetector(
    //                 onTap: () async {
    //                   final code = await countryPicker.showPicker(context: context);
    //                   setState(() {
    //                     countrycode = code;
    //                   });
    //                 },
    // child:
    //               Row(
    //                 children: [
    //                   Container(
    //               alignment: Alignment.center,
    //                     height: 40,
    //                     width: 78,
    //                     child: Row(
    //                       children: [
    //                         Icon(Icons.expand_more_outlined,
    //                         size: 20,
    //                         color: Color(0xFF090A0A),),
    //                         Text(countrycode != null ? countrycode!.dialCode : countryCode.text,
    //                         style: TextStyle(
    //                           color: Color(0xFF090A0A),
    //                           fontSize: 16,
    //                           fontFamily: 'Open Sans',
    //                           fontWeight: FontWeight.w400,
    //                         ),),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(width: 10,),
    //                   Expanded(child: TextField(
    //                     onChanged: (value)
    //                     {
    //                       phone = value;
    //                     },
    //                     // controller: authPhoneNumber,
    //                     keyboardType: TextInputType.phone,
    //                     decoration: InputDecoration(
    //                       labelText: 'Mobile number',
    //                       border: OutlineInputBorder(
    //                           borderRadius: BorderRadius.all(Radius.circular(10))
    //                       ),
    //                       prefixIcon: DropdownButton<String>(
    //                         // value: _selectedCountryCode,
    //                         icon: Icon(Icons.arrow_drop_down),
    //                         onChanged: (String? newValue) {
    //                           setState(() {
    //                             // _selectedCountryCode = newValue!;
    //                           });
    //                         },
    //                         items: <String>['+1', '+91', '+44', '+81'] // Add your country codes here
    //                             .map<DropdownMenuItem<String>>((String value) {
    //                           return DropdownMenuItem<String>(
    //                             value: value,
    //                             child: Text(value),
    //                           );
    //                         }).toList(),
    //                       ),
    //                     ),
    //                     //   TextFormField(
    //                     //     keyboardType: TextInputType.phone,
    //                     //     decoration: InputDecoration(
    //                     //       hintText: 'Enter your phone number',
    //                     //     ),
    //                     //   ),
    //                     // );
    //                     // InputDecoration(
    //                     //   labelText: 'Mobile Number',
    //                     //   hintText: 'Enter your phone number',
    //                     //   border: OutlineInputBorder(),
    //                     // ),
    //                   ),)
    //                 ],
    //               ),
    //               )
    //             ],
    //           ),
    //   ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final code =
                      await countryPicker.showPicker(context: context);
                      setState(() {
                        countrycode = code;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 40,
                          width: 78,
                          child: Row(
                            children: [
                              Text(
                                countrycode != null
                                    ? countrycode!.dialCode
                                    : countryCode.text,
                                style: TextStyle(
                                  color: Color(0xFF090A0A),
                                  fontSize: 16,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 0.06,
                                ),),
                              Icon(Icons.expand_more_outlined,
                                size: 25,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),),
                  SizedBox  (width: 10,),
                  Expanded(
                    child: TextField(
                      onChanged: (value)
                      {
                        phone = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Mobile Number',
                        hintStyle: TextStyle(
                          color: Color(0xFF72777A),
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  )
                ],
              ),
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
                Column(
                  children: [
                    GestureDetector(
                        onTap: (){
                          // Construct complete phone number with country code
                          String completePhoneNumber = '${countrycode != null ? countrycode!.dialCode : (countryCode.text + authPhoneNumber.text)}';
                          // Call login function with complete phone number
                          print(completePhoneNumber + phone);
                          login((completePhoneNumber + phone)).then((value) =>
                          {
                            print("func completed"),
                          });
                        },
                        child: Container(
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
                              onPressed: () {
                                Navigator.pushNamed(context, 'signUp_page');
                              },
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
      ])
      ),
    );
  }
}

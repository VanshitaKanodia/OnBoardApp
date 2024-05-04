import 'dart:convert';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final countryPicker = FlCountryCodePicker();
  CountryCode? countrycode;
  TextEditingController countryCode = TextEditingController();
  TextEditingController authPhoneNumber = TextEditingController();


  // Default country code
  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = "+91";
    super.initState();
  }

  var phone = "";


  Future<void> signup(String name, String phoneNum) async {
    try {
      var response = await http.post(
          Uri.parse('https://dev.iwayplus.in/auth/signup'),
          body: {
            'username' : '${phoneNum}',
            'name' : '${name}',
          });
      print(name);
      print(phoneNum);

      if(response.statusCode == 201)
      {
        var data = jsonDecode(response.body);
        print('Account created successfully with ${response.statusCode}:');
        Navigator.pushNamed(context, 'home_page');
        print(data);
      }
      else if(response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        print('Account created successfully with ${response.statusCode}:');
        Navigator.pushNamed(context, 'home_page');
        print(data);
      }else
      {
        print('!!!!!Failed to create account!!!!: ${response.statusCode}');
        print(response.body);
      }
    } catch(e){
      print('Error occurred while signing up: $e');
    }
  }
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: MaterialLocalizations
              .of(context)
              .openAppDrawerTooltip,
        );
      }
    ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            //SIGN UP TEXT
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 312,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF090A0A),
                        fontSize: 16,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                        height: 0.06,
                      ),
                    ),
                  ),
                  SizedBox(height: 32,),


                  //FIRST AND LAST NAME
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Container(
                      width: 327,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: const Color(0xFFE3E4E5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          hintMaxLines: 1,
                          labelText: 'First & Last Name',
                          labelStyle: const TextStyle(
                              color: Color(0xFF72777A),
                              fontSize: 16,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(color: Colors.black),
                        maxLines: 1,
                        minLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    // child: Container(
                    //   width: 327,
                    //   height: 50,
                    //   child: TextFormField(
                    //     controller: _phoneController,
                    //     keyboardType: TextInputType.phone,
                    //     decoration: InputDecoration(
                    //       counterText: '',
                    //       fillColor: const Color(0xFFE3E4E5),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(8.0),
                    //         borderSide: const BorderSide(color: Colors.black),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12.0),
                    //         borderSide: const BorderSide(color: Colors.black),
                    //       ),
                    //       // hintText: 'Mobile Number',
                    //       hintStyle: const TextStyle(
                    //         fontSize: 16.0,
                    //         color: Colors.grey,
                    //       ),
                    //       hintMaxLines: 1,
                    //       labelText: 'Mobile Number',
                    //       labelStyle: TextStyle(
                    //         color: Color(0xFF72777A),
                    //         fontSize: 16,
                    //         fontFamily: 'Open Sans',
                    //         fontWeight: FontWeight.w400,
                    //         height: 0.06,
                    //       ),
                    //     ),
                    //     autovalidateMode: AutovalidateMode.onUserInteraction,
                    //     textAlignVertical: TextAlignVertical.center,
                    //     style: const TextStyle(color: Colors.black),
                    //     maxLines: 1,
                    //     minLines: 1,
                    //   ),
                    // ),

                    //MOBILE CONTAINER FIELD
                    child: Container(
                      width: MediaQuery
                          .sizeOf(context)
                          .width,
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
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                phone = value;
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                // hintText: 'Mobile Number',
                                labelText: 'Mobile Number',
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
                  ),
                  SizedBox(height: 16,),


                  //CHECK BUTTON
                  Row(
                    children: [
                      Checkbox(value: isChecked, onChanged: (changed){
                        setState(() {
                          isChecked = !isChecked;
                        });
                      }),
                        Row(
                          children: [
                            Text(
                              'I agree with the ',
                              style: TextStyle(
                                color: Color(0xFF080814),
                                fontSize: 10,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400,
                              ),),
                            GestureDetector(
                                onTap: (){
                                  print('Terms and condition tapped');
                                },
                                child: Text(
                                  'Terms & Conditions ',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.deepPurpleAccent),
                                )),
                            Text(
                              'of dddd',
                              style: TextStyle(
                                color: Color(0xFF080814),
                                fontSize: 10,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400,
                              ),),
                          ],
                        ),
                      // Text('I agree with the '),
                      // Text(' of dddd'),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(height: 300,),

            //SIGN UP BUTTON
            Padding(
              padding: const EdgeInsets.only(top: 320),
              child: GestureDetector(
                  onTap: () {
                    // if(_phoneController != '' && _nameController != '') {
                      print(_nameController.text.toString());
                      print(countryCode.text + phone.toString());
                      signup(_nameController.text.toString(),
                          (countryCode.text + phone.toString()));
                      // signup('Hey', '+919856789986');
                    // } else if(_phoneController == '') {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: Text('Enter the Phone number'),
                    //   ));
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: Text('Please enter your name'),
                    //   ));
                    // }
                  },
                  child: Container(
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
                        'Sign Up',
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
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}

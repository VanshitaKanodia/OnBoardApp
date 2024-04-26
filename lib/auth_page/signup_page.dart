import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                SizedBox(
                  width: 340,
                  child: Container(
                    width: 327,
                    height: 48,
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: '',
                        fillColor: const Color(0xFFDFDFDF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        hintText: 'First & Last Name',
                        hintStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                        hintMaxLines: 1,
                        labelText: 'Name',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
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
                  width: 340,
                  child: Container(
                    width: 327,
                    height: 48,
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        counterText: '',
                        fillColor: const Color(0xFFDFDFDF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        hintText: 'Mobile Number',
                        hintStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                        hintMaxLines: 1,
                        labelText: 'Mobile Number',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
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
                SizedBox(height: 16,),
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
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: GestureDetector(
                onTap: () {},
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
                      'SignUp',
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
    ));
  }
}

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Sign Up'),
                SizedBox(height: 15,),
                SizedBox(
                  width: 340,
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
                SizedBox(height: 15,),
                SizedBox(
                  width: 340,
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
                Row(
                  children: [
                    Checkbox(value: isChecked, onChanged: (changed){
                      setState(() {
                        isChecked = !isChecked;
                      });
                    }),
                    Text('I agree with the '),
                    GestureDetector(onTap: (){}, child: Text('Terms & Conditions', style: TextStyle(color: Colors.deepPurpleAccent),)),
                    Text(' of dddd'),
                  ],
                ),
              ],
            ),
            GestureDetector(
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
          ],
        ),
      ),
    ));
  }
}

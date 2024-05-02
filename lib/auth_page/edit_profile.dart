import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {

  TextEditingController firstName = TextEditingController();
  TextEditingController phnNum = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController disability = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/profile_img.png'),
                ),
              ),
            ),
            SizedBox(height: 20),

            //First and Last Name
            Container(
              width: 304,
              height: 48,
              child: TextFormField(
                controller: firstName,
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
            SizedBox(height: 10),

            //Phone Number
            Container(
              width: 304,
              height: 48,
              child: TextFormField(
                controller: phnNum,
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
                  labelText: 'Phone Number',
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
            SizedBox(height: 10),

            //Email
            Container(
              width: 304,
              height: 48,
              child: TextFormField(
                controller: email,
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
                  labelText: 'Email',
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
            SizedBox(height: 10),

            //Disability
            Container(
              width: 304,
              height: 48,
              child: TextFormField(
                controller: disability,
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
                  labelText: 'Type of Disability',
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
            SizedBox(height: 10),

            //Password
            Container(
              width: 304,
              height: 48,
              child: TextFormField(
                controller: password,
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
                  labelText: 'Password',
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement save functionality
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

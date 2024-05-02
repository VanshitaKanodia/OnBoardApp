import 'package:flutter/material.dart';


class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 412.96,
                height: 412.96,
                child: Image.asset("assets/init_img.png"),
              ),
              GestureDetector(
                  onTap: () {
                    print('Tapped');
                    Navigator.pushNamed(context, 'logIn_page');
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
                                onPressed: () {
                                  Navigator.pushNamed(context, 'signUp_screen');
                                },
                                child: Text('Sign up',
                                  style: TextStyle(
                                    color: Color(0xFF2563EB),
                                    fontSize: 14,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 0.11,
                                  ),
                                )
                            )
                          ]),
                    ],
                  )
              ),
            ])
    );
  }
}

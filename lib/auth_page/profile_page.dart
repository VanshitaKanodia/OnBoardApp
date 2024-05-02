import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 25,
          color: Color(0xFF72777A),
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IconButton(
            //   iconSize: 23,
            //   color: Color(0xFF72777A),
            //   icon: Icon(Icons.clear_rounded),
            //   onPressed: () {
            //     // Handle back button pressed
            //   },
            // ),
            Text(
              'Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF72777A),
                  fontSize: 18,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  height: 0.05,
                )
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_active),
                  onPressed: () {
                    // Handle notification button pressed
                  },
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    // Handle profile button pressed
                    Navigator.pushNamed(context, 'profile_page');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'John Doe', // Replace with the actual name
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Account',
              style: TextStyle(
                color: Color(0xFF090A0A),
                fontSize: 18,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            buildSubHeading(context, Icons.account_circle_rounded, 'Profile', () {
              // Navigate to personal information page
              Navigator.pushNamed(context, 'edit_profile');
            }),
            buildSubHeading(context, Icons.favorite_rounded, 'My Routes', () {
              // Navigate to security page
            }),
            buildSubHeading(context, Icons.notifications_active, 'Notifications', () {
              // Navigate to notifications page
            }),
            SizedBox(height: 38,),
            // Add more subheadings as needed
            Text(
              'More',
              style: TextStyle(
                color: Color(0xFF090A0A),
                fontSize: 18,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            buildSubHeading(context, Icons.star_outline_sharp, 'Rate & Review', () {
              // Navigate to personal information page
            }),
            buildSubHeading(context, Icons.help_outline_rounded, 'Help', () {
              // Navigate to security page
            }),
          ],
        ),
      ),
    );
  }

  Widget buildSubHeading(BuildContext context, IconData icon, String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon,
            size: 23,),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Color(0xFF090A0A),
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
            size: 20,
            color: Color(0xFF090A0A),
            ),
          ],
        ),
      ),
    );
  }
}

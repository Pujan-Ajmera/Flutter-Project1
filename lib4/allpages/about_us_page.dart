import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(13, 24, 33, 1),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(color: Color.fromRGBO(13, 24, 33, 1)),
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/about_us_logo.png',
                        height: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'JeevanSaathi',
                        style: GoogleFonts.satisfy(
                          textStyle: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(180, 205, 237, 1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meet Our Team',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Changed to white
                          ),
                        ),
                        SizedBox(height: 10),
                        InfoRow(
                            title: 'Developed by',
                            value: 'Ajmera Pujan (23010101401)',
                            b: true),
                        InfoRow(
                            title: 'Mentored by',
                            value:
                            'Prof. Mehul Bhundiya (Computer Engineering Department), School of Computer Science'),
                        InfoRow(
                            title: 'Explored by',
                            value:
                            'ASWDC, School Of Computer Science, School of Computer Science'),
                        InfoRow(
                            title: 'Eulogized by',
                            value: 'Darshan University, Rajkot, Gujarat - INDIA'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(180, 205, 237, 1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About ASWDC',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Changed to white
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.',
                          style: TextStyle(fontSize: 16, color: Colors.white), // Changed to white
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Sole purpose of ASWDC is to bridge gap between university curriculum & industry demands. Students learn cutting edge technologies, develop real world application & experiences professional environment @ ASWDC under guidance of industry experts & faculty members.',
                          style: TextStyle(fontSize: 16, color: Colors.white), // Changed to white
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(180, 205, 237, 1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Changed to white
                          ),
                        ),
                        SizedBox(height: 10),
                        InfoRow(title: 'Email', value: 'aswdc@darshan.ac.in'),
                        InfoRow(title: 'Phone', value: '+91-9727747317'),
                        InfoRow(title: 'Website', value: 'www.darshan.ac.in'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(180, 205, 237, 1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.share, color: Colors.white), // Changed to white
                              SizedBox(width: 8),
                              Text('Share App',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white)), // Changed to white
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.apps, color: Colors.white), // Changed to white
                              SizedBox(width: 8),
                              Text('More Apps',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white)), // Changed to white
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.star_rate, color: Colors.white), // Changed to white
                              SizedBox(width: 8),
                              Text('Rate Us',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white)), // Changed to white
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.thumb_up, color: Colors.white), // Changed to white
                              SizedBox(width: 8),
                              Text('Like us on Facebook',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white)), // Changed to white
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.update, color: Colors.white), // Changed to white
                              SizedBox(width: 8),
                              Text('Check For Update',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white)), // Changed to white
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    '© 2025 Darshan University\nAll Rights Reserved - Privacy Policy\nMade with ❤ in India',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white), // Changed to white
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildInfoRow(String title, String content) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title : ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Changed to white
        ),
        Expanded(
          child: Text(
            content,
            style: TextStyle(color: Colors.white), // Changed to white
          ),
        ),
      ],
    ),
  );
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final bool? b;
  InfoRow({required this.title, required this.value, this.b = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Changed to white
          ),
          Expanded(
            child: Text(
              value,
              style: b!
                  ? GoogleFonts.birthstone(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
                  : TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Changed to white
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../utils/style/colors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: white),
        centerTitle: true,
        title: const Text(
          'About Us',
          style: TextStyle(color: white),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'WebsiteName is a Professional WebsiteType Platform. Here we will provide you only interesting content, which you will like very much. We are dedicated to providing you the best of WebsiteType, with a focus on dependability and WebsiteSpeciality. We are working to turn our passion for WebsiteType into a booming online website. We hope you enjoy our WebsiteType as much as we enjoy offering them to you.',
        // maxLines: 20, // Set the maximum number of lines
        textAlign: TextAlign.justify,
        // overflow: TextOverflow
        //     .ellipsis, // Optionally, add an ellipsis (...) for overflow
      ),
    );
  }
}
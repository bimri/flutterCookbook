import 'package:chap04/star.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('assets/khufu.jpg'),
          Transform.translate(
            offset: const Offset(0, 5),
            child: Column(children: <Widget>[
              _buildProfileImage(context),
              _buildProfileDetails(context),
              _buildActions(context),
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: ClipOval(
        child: Image.asset(
          'assets/profile.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const Text(
            'Pharaoh Khufu',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
          ),
          const StarRating( 
            value: 5,
          ),
          _buildDetailsRow('Age', '678909'),
          _buildDetailsRow('Status', 'DemiGod'),
        ],
      ),
    );
  }

  Widget _buildDetailsRow(String heading, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          '$heading: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildIcon(Icons.temple_buddhist_rounded, 'Religion'),
        _buildIcon(Icons.architecture, 'Pyramids'),
        _buildIcon(Icons.directions_boat, 'Nile'),
      ],
    );
  }

  Widget _buildIcon(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 40,
          ),
          Text(text)
        ],
      ),
    );
  }
}

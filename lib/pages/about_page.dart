import 'package:flutter/material.dart';
import '../tools/screen/screen_config.dart';
import '../tools/screen/screen_extension.dart';
import '../widgets/base_widget.dart';
import '../widgets/pulse.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenConfig(
      builder: () => Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(title: Text('About')),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 200),
                _bottomAction(),
                _madeWithLove(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _madeWithLove() => Row(
        children: [
          lExpanded(),
          lText(
            'Made with ',
            bold: true,
            size: 18,
            color: Colors.grey[600],
          ),
          Pulse(
            child: Icon(
              Icons.favorite,
              size: 30,
              color: Colors.red,
            ),
          ),
          lExpanded(),
        ],
      );

  Widget _bottomAction() => Row(
        children: [
          lExpanded(),
          lText(
            'Powered by AhaClub',
            bold: true,
            size: 18,
            color: Colors.grey[600],
          ),
          lWidth(5.vw),
          FlutterLogo(size: 8.vw),
          Icon(
            Icons.close,
            size: 5.vw,
            color: Colors.black54,
          ),
          Image.asset(
            'assets/images/flame.png',
            width: 8.vw,
          ),
          lExpanded(),
        ],
      );
}

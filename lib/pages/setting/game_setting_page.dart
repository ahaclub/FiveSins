import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../game/game_setting.dart';
import '../../game/game_state.dart';
import '../../game/level/levels.dart';
import '../../tools/dialog_tool.dart';
import '../../tools/navigator_tool.dart';
import '../../tools/screen/screen_config.dart';
import '../../tools/screen/screen_extension.dart';
import '../../widgets/base_widget.dart';
import 'more_setting_page.dart';

class GameSettingPage extends StatefulWidget {
  final bool fromHome;
  GameSettingPage({@required this.fromHome});
  @override
  _GameSettingPageState createState() => _GameSettingPageState();
}

class _GameSettingPageState extends State<GameSettingPage> {
  void _back() {
    NavigatorTool.pop();
  }

  void _goHome() {
    NavigatorTool.pop(); //pop setting page
    if (GameState.gameStatus != GameStatus.pause) {
      NavigatorTool.pop(); //pop gameover page
    }
    NavigatorTool.pop(); //pop game page
  }

  Future<void> _more() async {
    if (!widget.fromHome) {
      await DialogTool.show(
        context,
        title: '提示',
        content: '只能从首页进入高级设置',
        actionText: '首页',
        action: _goHome,
      );
      return;
    }
    await Levels.init();
    await NavigatorTool.push(MoreSettingPage());
  }

  GameSetting get setting => GameState.gameSetting;

  String get _levelUp => setting.levelUp ? 'FiveSins' : 'Small';

  String get _random => setting.random
      ? 'Random'
      : setting.levelUp
          ? 'Small'
          : 'Big';

  @override
  Widget build(BuildContext context) {
    return ScreenConfig(
      builder: () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                _topAction(),
                lExpanded(),
                _switchItem(_levelUp, value: setting.levelUp,
                    onChanged: (v) async {
                  if (!widget.fromHome) {
                    await DialogTool.show(
                      context,
                      title: 'Tip',
                      content:
                          'This option can only be accessed from the home page',
                      actionText: 'HomePage',
                      action: _goHome,
                    );
                    return;
                  }
                  setting.levelUp = v;
                  await setting.update();
                }),
                _switchItem(_random, value: setting.random,
                    onChanged: (v) async {
                  setting.random = v;
                  await setting.update();
                }),
                if (!kIsWeb)
                  _switchItem('重力感应', value: setting.gravity,
                      onChanged: (v) async {
                    setting.gravity = v;
                    await setting.update();
                  }),
                _switchItem('Sound Effect', value: setting.music,
                    onChanged: (v) async {
                  setting.music = v;
                  await setting.update();
                }),
                _switchItem('Animation', value: setting.bloom,
                    onChanged: (v) async {
                  setting.bloom = v;
                  await setting.update();
                }),
                lExpanded(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topAction() => Container(
        padding: EdgeInsets.all(5.vw),
        child: Row(
          children: [
            lIconButton(
              Icons.chevron_left,
              size: 10.vw,
              color: Colors.black,
              onTap: _back,
            ),
            lExpanded(),
            lButton(
              '高级设置',
              onTap: _more,
              height: 5.vw * 2.2,
              colorBg: Colors.black,
              colorText: Colors.white,
            ),
          ],
        ),
      );

  Widget _switchItem(String lable, {bool value, Function(bool) onChanged}) =>
      lExpanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            lButton(
              lable,
              height: 5.vw * 2.2,
              colorBg: Colors.black,
              colorText: Colors.white,
            ),
            CupertinoSwitch(
                value: value,
                onChanged: (v) {
                  onChanged(v);
                  setState(() {});
                }),
          ],
        ),
      );
}

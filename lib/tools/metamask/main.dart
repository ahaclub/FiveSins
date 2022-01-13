import 'package:FiveSins/tools/metamask/metamask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetamaskPage extends StatefulWidget {
  const MetamaskPage({Key key}) : super(key: key);

  @override
  State<MetamaskPage> createState() => _MetamaskPageState();
}

class _MetamaskPageState extends State<MetamaskPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MetaMaskProvider()..init(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.yellow,
          body: Center(
            child: Consumer<MetaMaskProvider>(
              builder: (context, provider, child) {
                String text;

                if (provider.isConnected && provider.isInOperatingChain) {
                  text = 'Connected';
                } else if (provider.isConnected &&
                    !provider.isInOperatingChain) {
                  text = 'Wrong chain. Please connect to Polygon';
                } else if (provider.isEnabled) {
                  return Column(
                    children: [
                      CupertinoButton(
                        onPressed: () =>
                            context.read<MetaMaskProvider>().connect(),
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        pressedOpacity: 0.8,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              'https://i0.wp.com/kindalame.com/wp-content/uploads/2021/05/metamask-fox-wordmark-horizontal.png?fit=1549%2C480&ssl=1',
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  text = 'Please use a Web3 supported browser.';
                }

                return ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.purple, Colors.blue, Colors.red],
                  ).createShader(bounds),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

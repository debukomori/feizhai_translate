import 'package:flutter/material.dart';
import 'package:moe_code/LocalStorage.dart';

class Lingva_Widget extends StatefulWidget {
  Lingva_Widget({Key? key}) : super(key: key);

  @override
  State<Lingva_Widget> createState() => _Lingva_WidgetState();
}

class _Lingva_WidgetState extends State<Lingva_Widget> {
  var LingvaSwitch;

  @override
  void initState() {
    super.initState();
    LingvaSwitch = LocalStorage.get('LingvaSwitch') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Column(
            children: [
              ListTile(
                title: Text('Lingva'),
                trailing: Switch(
                    value: LingvaSwitch,
                    onChanged: (v) {
                      setState(() {
                        LingvaSwitch = !LingvaSwitch;
                        LocalStorage.savebool('LingvaSwitch', LingvaSwitch);
                      });
                    }),
              ),
            ],
          ),
        ));
  }
}

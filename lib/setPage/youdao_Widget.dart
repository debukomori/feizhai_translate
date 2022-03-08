import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../LocalStorage.dart';

//youdao_Switch
//youdao_ID
//youdao_KEY

class youdao_Widget extends StatefulWidget {
  youdao_Widget({Key? key}) : super(key: key);

  @override
  State<youdao_Widget> createState() => _youdao_WidgetState();
}

class _youdao_WidgetState extends State<youdao_Widget> {
  bool _youdao_Switch = true; //有道开关
  TextEditingController _youdao_ID = TextEditingController(); //有道账号
  TextEditingController _youdao_KEY = TextEditingController(); //有道密码
  bool youdao_TextField_enable = true;
  @override
  void initState() {
    super.initState();
    _youdao_Switch = LocalStorage.get('youdao_Switch') ?? false;
    _youdao_ID.text = LocalStorage.get('youdao_ID') ?? '';
    _youdao_KEY.text = LocalStorage.get('youdao_KEY') ?? '';
    youdao_TextField_enable =
        LocalStorage.get('youdao_TextField_enable') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            TextField(
              enabled: youdao_TextField_enable,
              onChanged: (_) {
                LocalStorage.save('youdao_ID', _youdao_ID.text);
              },
              controller: _youdao_ID,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        FlutterClipboard.paste().then((v) {
                          _youdao_ID.text = v;
                          LocalStorage.save('youdao_ID', _youdao_ID.text);
                        });
                      },
                      icon: const Icon(Icons.paste)),
                  labelText: '有道应用ID',
                  border: const OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              enabled: youdao_TextField_enable,
              onChanged: (_) {
                LocalStorage.save('youdao_KEY', _youdao_KEY.text);
              },
              controller: _youdao_KEY,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        FlutterClipboard.paste().then((v) {
                          _youdao_KEY.text = v;
                          LocalStorage.save('youdao_KEY', _youdao_KEY.text);
                        });
                      },
                      icon: const Icon(Icons.paste)),
                  labelText: '有道应用密钥',
                  border: const OutlineInputBorder()),
            ),
            ButtonBar(
              children: [
                Switch(
                    value: _youdao_Switch,
                    onChanged: (v) {
                      if (v == false) {
                        youdao_TextField_enable = true;
                        LocalStorage.savebool('youdao_TextField_enable', true);
                      } else if (v == true) {
                        youdao_TextField_enable = false;
                        LocalStorage.savebool('youdao_TextField_enable', false);
                      }

                      setState(() {
                        _youdao_Switch = v;
                        LocalStorage.savebool('youdao_Switch', _youdao_Switch);
                        LocalStorage.save('youdao_ID', _youdao_ID.text);
                        LocalStorage.save('youdao_KEY', _youdao_KEY.text);
                      });
                    }),
                //   OutlinedButton(
                //       onPressed: () {
                //         // LocalStorage.savebool('youdao_Switch', _youdao_Switch);
                //         // LocalStorage.save('youdao_ID', _youdao_ID.text);
                //         // LocalStorage.save('youdao_KEY', _youdao_KEY.text);
                //       },
                //       child: Text('保存'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

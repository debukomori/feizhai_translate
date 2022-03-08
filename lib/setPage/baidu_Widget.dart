import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../LocalStorage.dart';

//baidu_Switch
//baidu_ID
//baidu_KEY

class baidu_Widget extends StatefulWidget {
  baidu_Widget({Key? key}) : super(key: key);

  @override
  State<baidu_Widget> createState() => _baidu_WidgetState();
}

class _baidu_WidgetState extends State<baidu_Widget> {
  bool _baidu_Switch = true;
  TextEditingController _baidu_ID = TextEditingController();
  TextEditingController _baidu_KEY = TextEditingController();
  bool baidu_TextField_enable = true;

  @override
  void initState() {
    super.initState();
    _baidu_Switch = LocalStorage.get('baidu_Switch') ?? false;
    _baidu_ID.text = LocalStorage.get('baidu_ID') ?? '';
    _baidu_KEY.text = LocalStorage.get('baidu_KEY') ?? '';
    baidu_TextField_enable = LocalStorage.get('baidu_TextField_enable') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            TextField(
              enabled: baidu_TextField_enable,
              onChanged: (_) {
                LocalStorage.save('baidu_ID', _baidu_ID.text);
              },
              controller: _baidu_ID,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        FlutterClipboard.paste().then((v) {
                          _baidu_ID.text = v;
                          LocalStorage.save('baidu_ID', _baidu_ID.text);
                        });
                      },
                      icon: Icon(Icons.paste)),
                  labelText: '百度APPID',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              enabled: baidu_TextField_enable,
              onChanged: (_) {
                LocalStorage.save('baidu_KEY', _baidu_KEY.text);
              },
              controller: _baidu_KEY,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        FlutterClipboard.paste().then((v) {
                          _baidu_KEY.text = v;
                          LocalStorage.save('baidu_KEY', _baidu_KEY.text);
                        });
                      },
                      icon: Icon(Icons.paste)),
                  labelText: '百度密钥',
                  border: OutlineInputBorder()),
            ),
            ButtonBar(
              children: [
                Switch(
                    value: _baidu_Switch,
                    onChanged: (v) {
                      if (v == false) {
                        baidu_TextField_enable = true;
                        LocalStorage.savebool('baidu_TextField_enable', true);
                      } else if (v == true) {
                        baidu_TextField_enable = false;
                        LocalStorage.savebool('baidu_TextField_enable', false);
                      }
                      setState(() {
                        _baidu_Switch = v;
                        LocalStorage.savebool('baidu_Switch', _baidu_Switch);
                        LocalStorage.save('baidu_ID', _baidu_ID.text);
                        LocalStorage.save('baidu_KEY', _baidu_KEY.text);
                      });
                    }),
                //   OutlinedButton(
                //       onPressed: () {
                //         // LocalStorage.savebool('baidu_Switch', _baidu_Switch);
                //         // LocalStorage.save('baidu_ID', _baidu_ID.text);
                //         // LocalStorage.save('baidu_KEY', _baidu_KEY.text);
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

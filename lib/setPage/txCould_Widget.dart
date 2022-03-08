import 'package:flutter/material.dart';

import '../LocalStorage.dart';

//txCould_Switch
//txCould_ID
//txCould_KEY

class txCould_Widget extends StatefulWidget {
  txCould_Widget({Key? key}) : super(key: key);

  @override
  State<txCould_Widget> createState() => txCould_WidgetState();
}

class txCould_WidgetState extends State<txCould_Widget> {
  bool _txCould_Switch = false;
  TextEditingController _txCould_ID = TextEditingController();
  TextEditingController _txCould_KEY = TextEditingController();

  @override
  void initState() {
    super.initState();
    _txCould_Switch = LocalStorage.get('txCould_Switch') ?? false;
    _txCould_ID.text = LocalStorage.get('txCould_ID') ?? '';
    _txCould_KEY.text = LocalStorage.get('txCould_KEY') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _txCould_ID,
          decoration: const InputDecoration(
              labelText: '腾讯云SecretId', border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _txCould_KEY,
          decoration: const InputDecoration(
              labelText: '腾讯云SecretKey', border: OutlineInputBorder()),
        ),
        ButtonBar(
          children: [
            Switch(
                value: _txCould_Switch,
                onChanged: (v) {
                  setState(() {
                    _txCould_Switch = v;
                  });
                }),
            OutlinedButton(
                onPressed: () {
                  LocalStorage.savebool('txCould_Switch', _txCould_Switch);
                  LocalStorage.save('txCould_ID', _txCould_ID.text);
                  LocalStorage.save('txCould_KEY', _txCould_KEY.text);
                },
                child: Text('保存'))
          ],
        ),
      ],
    );
  }
}

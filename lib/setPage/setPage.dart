// ignore_for_file: avoid_print, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:moe_code/LocalStorage.dart';
import 'package:moe_code/setPage/Lingva_Widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'baidu_Widget.dart';
import 'txCould_Widget.dart';
import 'youdao_Widget.dart';

class setPage extends StatelessWidget {
  const setPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('引擎设置'),
      ),
      body: ListView(padding: EdgeInsets.all(10), children: [
        Lingva_Widget(),
        youdao_Widget(),
        baidu_Widget(),
      ]), //手动排序
    );
  }
}

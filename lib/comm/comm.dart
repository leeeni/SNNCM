import 'package:flutter/material.dart';

//左右上角圆弧边框
BoxDecoration boxDecorationTLF = BoxDecoration(
  color: Colors.blue[50],
  border: Border.all(
    color: Colors.blue[100],
  ),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(8.0),
    topRight: Radius.circular(8.0),
  ),
  boxShadow: [
    BoxShadow(
        color: Colors.grey[300],
        offset: Offset(3.0, 3.0), //阴影y轴偏移量
        blurRadius: 3, //阴影模糊程度
        spreadRadius: 3 //阴影扩散程度
        ),
  ],
);

//左右下角圆弧边框
BoxDecoration boxDecorationBLF = BoxDecoration(
  color: Colors.blue[50],
  border: Border.all(
    color: Colors.blue[100],
  ),
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(8.0),
    bottomRight: Radius.circular(8.0),
  ),
  boxShadow: [
    BoxShadow(
        color: Colors.grey[300],
        offset: Offset(3.0, 3.0), //阴影y轴偏移量
        blurRadius: 3, //阴影模糊程度
        spreadRadius: 3 //阴影扩散程度
        ),
  ],
);

//四角圆弧边框
BoxDecoration boxDecorationALL = BoxDecoration(
  color: Colors.blue[50],
  border: Border.all(
    color: Colors.blue[100],
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(8.0),
  ),
  boxShadow: [
    BoxShadow(
        color: Colors.grey[300],
        offset: Offset(3.0, 3.0), //阴影y轴偏移量
        blurRadius: 3, //阴影模糊程度
        spreadRadius: 3 //阴影扩散程度
        ),
  ],
);

//四角边框
BoxDecoration boxDecorationNONE = BoxDecoration(
  color: Colors.blue[50],
  border: Border.all(
    color: Colors.blue[100],
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(0),
  ),
  boxShadow: [
    BoxShadow(
        color: Colors.grey[300],
        offset: Offset(3.0, 3.0), //阴影y轴偏移量
        blurRadius: 3, //阴影模糊程度
        spreadRadius: 3 //阴影扩散程度
        ),
  ],
);

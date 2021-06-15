import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";

import 'package:snns_cm/components/toolsbar/menu.dart';
import 'package:snns_cm/components/toolsbar/topbar.dart';
import 'package:snns_cm/components/toolsbar/bottombar.dart';

class HomeComponent extends StatelessWidget {
//   @override
//   _HomeComponentState createState() => _HomeComponentState();
// }

// class _HomeComponentState extends State<HomeComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: HStack([
          GcMenu(''),
          VStack(
            [
              GcTopBar('Home'), //主界面导航栏,
              VStack(
                [
                  HeightBox(35),
                  '百万级神经元类脑计算系统'
                      .text
                      .color(Vx.orange700)
                      .size(60)
                      .bold
                      .make()
                      .centered(),
                ],
                alignment: MainAxisAlignment.start,
                crossAlignment: CrossAxisAlignment.center,
              )
                  .box
                  .bgImage(
                    DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/login_bg.jpg'),
                    ),
                  )
                  .shadowXs
                  .make()
                  .p(5)
                  .expand(),
              GcBottomBar(),
            ],
          ).expand()
        ]),
      ).color(Vx.gray100).make(),
    );
  }
}

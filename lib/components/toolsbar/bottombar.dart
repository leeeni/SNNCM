import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";

import 'package:snns_cm/comm/comm.dart';

class GcBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gcbbar = VxBox(
            child: "Copyright 2020 鹏城实验室 All Rights Reserved."
                .text
                .color(Vx.blue500)
                .make()
                .centered())
        .height(30)
        .withDecoration(boxDecorationBLF)
        .shadowXs
        .make()
        .p(5);
    return gcbbar;
  }
}

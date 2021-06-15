import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:liquid_ui/liquid_ui.dart';
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/config/routes.dart';

class Constants {
  static const String appName = '类脑原型机集群管理平台';
  static const String logoTag = 'near.huscarl.loginsample.logo';
  static const String titleTag = 'near.huscarl.loginsample.title';
}

class LoginChooseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: HStack(
          [
            VStack(
              [
                VStack(
                  [
                    HeightBox(35),
                    '类脑原型机集群管理平台'
                        .text
                        .color(Vx.orange700)
                        .size(40)
                        .bold
                        .make()
                        .centered(),
                    SizedBox(height: 150),
                    SizedBox(
                      width: 150,
                      height: 70,
                      child: LFlatButton(
                        child: const Text(
                          '本地用户入口',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          Application.router.navigateTo(context, Routes.login);
                        },
                      ),
                    ),
                    SizedBox(height: 140),
                    SizedBox(
                      width: 150,
                      height: 70,
                      child: LFlatButton(
                        child: const Text(
                          '云脑用户入口',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          Application.router
                              .navigateTo(context, Routes.pcllogin);
                        },
                      ),
                    ),
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
              ],
            ).expand(),
          ],
        ),
      ).color(Vx.gray100).make(),
    );
  }
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/config/routes.dart';

class Gcdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    final gcd = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('集群监控', textAlign: TextAlign.center),
          ),
          ListTile(
            leading: Icon(Icons.ac_unit_sharp),
            title: Text('集群监控'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.ac_unit_sharp),
            title: Text('集群监控'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.ac_unit_sharp),
            title: Text('Item 2'),
            onTap: null,
          ),
        ],
      ),
    );
    return gcd;
  }
}

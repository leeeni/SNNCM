import 'package:flutter/material.dart';

import 'package:snns_cm/widget/expansion_title.dart';

class GcCenterScreen extends StatelessWidget {
  final String title;
  final String topTitle;
  final List<Widget> topContents;
  final List<Widget> topButtons;
  final Widget body;

  GcCenterScreen({
    this.title,
    this.topTitle,
    this.topContents,
    this.topButtons,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (ctx, size) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: size.maxWidth,
              height: size.maxHeight,
              constraints: const BoxConstraints(
                minHeight: 750,
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                GcExpansionTile(
                    title: topTitle,
                    children: topContents,
                    buttons: topButtons,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: body,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
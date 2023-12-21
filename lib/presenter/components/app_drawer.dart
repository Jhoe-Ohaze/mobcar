import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 60, 15, 15),
            child: Text(
              'Olá,\nAdmin',
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade700,
          ),
          const Expanded(child: SizedBox()),
          Divider(
            thickness: 1,
            color: Colors.grey.shade700,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            title: const Text(
              'Sair',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: (){},
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade700,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Ⓒ',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '   2020. ',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'All rights reserved to Mobcar.',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

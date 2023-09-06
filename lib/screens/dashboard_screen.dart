import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenidos Todos UwU'),
      ),
      drawer: createDrawer(),
    );
  }

  Widget createDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/21/06/da/2106dabd9a7d0a071ef737e419feb077.jpg'),
              ),
              accountName: Text('Jonathan Camacho'),
              accountEmail: Text('19030809@itcelaya.edu.mx')),
          ListTile(
            leading: Image.network(
                'https://www.pngmart.com/files/2/Scarlet-Witch-PNG-HD.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('BellakaApp'),
            subtitle: const Text('Carrousel'),
            onTap: () {},
          )

          /*DayNightSwitcher(
              isDarkModeEnabled: isDarkModeEnabled,
              onStateChanged: (isDarkModeEnabled) {
                setState(() {
                  this.isDarkModeEnabled = isDarkModeEnabled;
                });
              },
            ),*/
        ],
      ),
    );
  }
}

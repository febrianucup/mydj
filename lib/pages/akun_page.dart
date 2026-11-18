import 'package:flutter/material.dart';
import 'package:mydj/data/login_info.dart';
import 'package:mydj/components/password_field.dart';
import 'package:mydj/pages/login_page.dart';
class AkunPage extends StatefulWidget {
  const AkunPage({super.key, required this.title});
  final String title;
  @override
  State<AkunPage> createState()
  {
    return _AkunPageState(); // Seperti biasa, baris ini masih error.
  }
}

class _AkunPageState extends State<AkunPage> {
  _openLoginPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context) => LoginPage(),),
      (Route<dynamic> route) => false
    );
  }

  Future<void> _logout(BuildContext context) async {
    await LoginInfo.deleteFromSharedPreferences();
    _openLoginPage(context);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ganti Sandi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 2,),
                SizedBox(height: 10,),
                Text(
                  'Sandi Saat Ini'
                ),
                SizedBox(height: 10,),
                PasswordField(),
                SizedBox(height: 10,),
                Text(
                  'Sandi Baru'
                ),
                SizedBox(height: 10,),
                PasswordField(),
                SizedBox(height: 10,),
                Text(
                  'Konfirmasi Sandi Baru'
                ),
                SizedBox(height: 10,),
                PasswordField(),
                SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => {
                      
                    }, 
                    child: Text(
                      'Simpan'
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Keluar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 2,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => {
                      _logout(context)
                    }, 
                    child: Text('Keluar dari Aplikasi')
                  ),
                )
              ],
          )
        )
    );
  }
}
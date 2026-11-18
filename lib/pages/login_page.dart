import 'package:flutter/material.dart';
import 'package:mydj/data/data_provider.dart';
import 'package:mydj/components/password_field.dart';
import 'package:mydj/pages/simple_home_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{
  final String title = 'MyDJ - Welcome';

  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String namaPengguna = '';
  String sandi = '';

  Future<void> _login(BuildContext context) async{
    DataProvider provider = context.read<DataProvider>();

    if(namaPengguna == 'guru' && sandi == 'guru'){
      await provider.saveLoginInfo(namaPengguna, sandi);
      if(context.mounted){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SimpleHomePage(title: 'Beranda')), (Route<dynamic> route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/login_icon.png', width: 250,
                ),
                SizedBox(height: 20,),
                Text('Nama Pengguna: '),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Masukkan nama pengguna',
                  ),
                  onChanged: (value) {
                    setState(() {
                      namaPengguna = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                Text('Sandi'),
                PasswordField(onChanged: (value) {
                  setState(() {
                    sandi = value;
                  });
                }),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () => {
                    {_login(context)}
                  }, 
                  child: Text('Login')
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}
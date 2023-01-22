import 'package:ai_app/models/usermodel.dart';
import 'package:ai_app/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> addData() async {
    AuthProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  @override
  void initState() {
    addData();
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
    // FocusManager.instance.primaryFocus?.unfocus();
    // FocusScope.of(context).requestFocus(FocusNode());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<AuthProvider>(context).getuser;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(_user.username.toString()),
        titleTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: CupertinoColors.activeGreen,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                color: CupertinoColors.activeGreen,
                thickness: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

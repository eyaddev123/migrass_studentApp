import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/core/resource/image_manager.dart';
import 'package:student/core/widgets/green_container.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/NavigationScreen.dart';
import 'package:student/feature/ui/Screenes/Login/bloc/login_bloc.dart';
import 'package:student/feature/ui/Screenes/Login/bloc/login_eventes.dart';
import 'package:student/feature/ui/Screenes/Login/bloc/login_states.dart';


class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var formKey= GlobalKey<FormState>();
  bool mycode =true;
  bool centercode =true;


  var mycodecontroller = TextEditingController() ;
  var centercodecontroller = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LoginBloc(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {

                    if (state.status == LoginStatus.success) {

                      () async {
                        final prefs = await SharedPreferences.getInstance();
                        if (state.token != null) {
                          await prefs.setString('token', state.token!);
                          print(" Token saved to SharedPreferences: ${state.token}");
                        }
                        await prefs.setString('code_user', state.code_user ?? '');
                        await prefs.setString('mosque_code', state.mosque_code ?? '');


                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم تسجيل بنجاح')),
                        );

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const NavigationScreen()),
                              (route) => false,
                        );
                      }();
                    } else if (state.status == LoginStatus.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage ?? 'حدث خطأ')),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Stack(
                      children: [
                        Image(
                          image: AssetImage(ImageManager().leaves),
                           width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                          ),
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,

                              child: Form(
                                key:formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'تسجيل دخول',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 60.0,
                                    ),
                                    defaultTextFormField(
                                      controller: mycodecontroller,
                                      labelText: 'كودي',
                                      textStyle:ColorManager.black,
                                      fillColor:ColorManager.lightGray,
                                      isPassword: true,
                                      isObscure: mycode,
                                      onToggleVisibility: () {
                                        setState(() {
                                          mycode = !mycode;
                                        });
                                      },
                                      suffixIconPath: IconImageManager.Lock,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'your code must not be empty';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        final parsed = int.tryParse(value);
                                        if (parsed != null) {
                                          context.read<LoginBloc>().add(code_userloginvalue(parsed.toString()));
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    defaultTextFormField(
                                      controller: centercodecontroller,
                                      labelText: 'كود المركز',
                                      textStyle:ColorManager.black,
                                      fillColor:ColorManager.lightGray,
                                      isPassword: true,
                                      isObscure: centercode,
                                      onToggleVisibility: () {
                                        setState(() {
                                          centercode = !centercode;
                                        });
                                      },
                                      suffixIconPath: IconImageManager.Lock,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'code center must not be empty';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        final parsed = int.tryParse(value);
                                        if (parsed != null) {
                                          context.read<LoginBloc>().add( mosque_codeloginvalue(parsed.toString()));
                                        }
                                      },
                                    ),

                                     SizedBox(
                                      height: 60.0,
                                    ),

                                    state.status == LoginStatus.submitting
                                        ? const CircularProgressIndicator()
                                        : Center(
                                        child: defauilButton(
                                          background: ColorManager.lightGray,
                                          textcolorbutton: ColorManager.black,
                                          function:()
                                          {
                                            if (formKey.currentState!.validate()) {

                                              context.read<LoginBloc>().add(LoginSubmitted());

                                              print('login successful');
                                              print(mycodecontroller.text);
                                              print(centercodecontroller.text);
                                            }
                                          },
                                          text:  'تسجيل',
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }    ),
            ),
          ),
        ));
  }
}
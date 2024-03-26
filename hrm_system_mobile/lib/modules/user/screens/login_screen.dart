import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/core/shared/input_decoration.dart';
import 'package:human_resource_management_system/modules/user/stores/auth_store.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool isHidden = true;

  @override
  void dispose() {
    print("sign in screen gets disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.white,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Image.asset('assets/images/logo.png', width: 300),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    final auth = context.watch<AuthStore>();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Observer(
          builder: (context) {
            if (auth.loadingStatus == LoadingStatus.loading) {
              return const Padding(
                padding: EdgeInsets.all(80),
                child: LoadingScreen(),
              );
            } else {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  _buildEmailTextField(),
                  const SizedBox(height: 20),
                  _buildPasswordTextField(),
                  const SizedBox(height: 8),
                  _buildErrorText(),
                  const SizedBox(height: 20),
                  _buildSignInButton(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      onChanged: _onTextFieldChange,
      decoration:
          loginTextField.copyWith(labelText: "Email", hintText: "Email"),
      controller: _emailCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Invalid Email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      onChanged: _onTextFieldChange,
      obscureText: isHidden,
      decoration: loginTextField.copyWith(
        labelText: 'Password',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isHidden = !isHidden;
            });
          },
          icon: isHidden
              ? const Icon(FontAwesomeIcons.eye)
              : const Icon(FontAwesomeIcons.eyeSlash),
        ),
      ),
      controller: _passwordCtrl,
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Invalid Password';
        }
        return null;
      },
    );
  }

  void _onTextFieldChange(value) {
    context.read<AuthStore>().setLoadingStatus(LoadingStatus.none);
  }

  late bool _isVisible;

  Widget _buildErrorText() {
    _isVisible =
        context.watch<AuthStore>().loadingStatus == LoadingStatus.error;
    return Visibility(
      visible: _isVisible,
      child: Text(
        'Your Email and Password are incorrect!',
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Row(
      children: [
        Expanded(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await context.read<AuthStore>().signIn(
                        _emailCtrl.text.trim(),
                        _passwordCtrl.text.trim(),
                      );
                }
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0.0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text('Login'),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/auth_provider.dart';
import 'package:knitting_app/controllers/providers/supabase_provider.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Tığcık - Kaydol'),

      body: Column(
        children: [
          SizedBox(height: 5),

          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),

          SizedBox(height: 5),

          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Şifre',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),

          ElevatedButton(
            onPressed: () async {
              bool result = await context.read<SupabaseProvider>().signUpUser(
                email: emailController.text,
                password: passwordController.text,
              );

              if (result) {
                context.pop();
              }
            },
            child: const Text('Kaydol'),
          ),
        ],
      ),
    );
  }
}

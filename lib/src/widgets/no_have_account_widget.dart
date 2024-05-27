import 'package:flutter/material.dart';

class NoHaveAccount extends StatelessWidget {
  const NoHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Não possui conta?",
            style: TextStyle(color: Colors.white),
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                "Cadastrar",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              )),
        ],
      ),
    );
  }
}

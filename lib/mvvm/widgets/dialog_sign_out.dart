import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> showDialogSignOut(
    BuildContext context, GoogleSignInAccount user, Function()? onpress) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: GoogleUserCircleAvatar(identity: user)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          user.displayName!,
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: onpress,
                      icon: const Icon(Icons.logout),
                      label: const Text("sign out"))
                ],
              ),
            ));
      });
}

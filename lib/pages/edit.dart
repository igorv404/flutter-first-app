import 'package:flutter/material.dart';
import 'package:my_project/models/user.dart';
import 'package:my_project/pages/account.dart';
import 'package:my_project/pages/registration.dart';
import 'package:my_project/repositories/user_repository.dart';
import 'package:my_project/utils/validation.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  final UserRepository _userRepository = UserRepository();
  final Validation _validation = Validation();
  late Future<User?> _user;
  final User _newUser = User(1);

  @override
  void initState() {
    super.initState();
    _user = _userRepository.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<User?>(
          future: _user,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Edit info',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Form(
                  key: _editFormKey,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Enter your new name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (name) => name!.trim().length < 2
                              ? 'Name should be a least 2 symbols'
                              : null,
                          onSaved: (value) {
                            _newUser.firstName = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Enter your new surname',
                            border: OutlineInputBorder(),
                          ),
                          validator: (surname) => surname!.trim().length < 2
                              ? 'Surname should be a least 2 symbols'
                              : null,
                          onSaved: (value) {
                            _newUser.lastName = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Enter your new email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (email) =>
                              _validation.validateEmail(email!),
                          onSaved: (value) {
                            _newUser.email = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Enter your new password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (password) =>
                              _validation.validatePassword(password!),
                          onSaved: (value) {
                            _newUser.password = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (_editFormKey.currentState!.validate()) {
                              _editFormKey.currentState!.save();
                              _newUser.id = snapshot.data!.id;
                              _newUser.countOfReservations =
                                  snapshot.data!.countOfReservations;
                              _userRepository.saveInStorage(_newUser);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AccountPage(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                          ),
                          child: const Text('Save'),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            _userRepository.deleteData();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            'Delete account',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

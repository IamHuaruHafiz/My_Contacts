import 'package:flutter/material.dart';
import 'package:people/main.dart';

class NewContactView extends StatefulWidget {
  const NewContactView({super.key});

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _nameController;
  late final TextEditingController _numberController;
  @override
  void initState() {
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 7,
            ),
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Enter name",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Enter the number",
              ),
            ),
            TextButton(
                onPressed: () {
                  final contact = Contact(
                      name: _nameController.text,
                      number: _numberController.text);
                  ContactBook().add(contact: contact);
                  Navigator.of(context).pop();
                },
                child: const Text("Add contact"))
          ],
        ),
      ),
    );
  }
}

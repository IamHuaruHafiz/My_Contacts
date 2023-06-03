import 'package:flutter/material.dart';
import 'package:people/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Contacts",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (context, value, child) {
          final contacts = value;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Material(
                color: Colors.white,
                elevation: 5.0,
                child: ListTile(
                  trailing: IconButton(
                      onPressed: () async {
                        ContactBook().remove(contact: contact);
                      },
                      icon: const Icon(Icons.delete)),
                  title: Text(contact.name),
                  subtitle: Text(contact.number),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed("/new-contact");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

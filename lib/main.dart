import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/new-contact": (context) => const NewContactView()},
      home: const HomePage(),
    );
  }
}

class Contact {
  final String id;
  final String name;
  final String number;

  Contact({required this.name, required this.number}) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  int get lenght => value.length;

  void add({required Contact contact}) {
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    final contacts = value;
    if (contacts.contains(contact)) {
      contacts.remove(contact);
      notifyListeners();
    }
  }

  Contact? contact({required int atIndex}) =>
      value.length > atIndex ? value[atIndex] : null;
}

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

// Future<void> deleteDialog({required BuildContext context}) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text("Warning"),
//         content: const Text("Are you sure you want to delete this contact?"),
//         actions: [
//           Row(
//             children: [
//               TextButton(onPressed: () {}, child: const Text("No")),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text("Yes"),
//               ),
//             ],
//           )
//         ],
//       );
//     },
//   );
// }

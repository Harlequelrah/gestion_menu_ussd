import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact>? contacts;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      // Demande de permission
      if (await FlutterContacts.requestPermission()) {
        // Récupération des contacts
        List<Contact> fetchedContacts =
            await FlutterContacts.getContacts(withProperties: true);
        setState(() {
          contacts = fetchedContacts;
        });
      } else {
        // Permission refusée
        setState(() {
          contacts = [];
        });
        print('Permission refusée. Impossible d\'accéder aux contacts.');
      }
    } catch (e) {
      print('Erreur lors de la récupération des contacts : $e');
      setState(() {
        contacts = [];
      });
    }
  }
  String _getInitials(Contact contact) {
    final firstName =
        contact.name.first.isNotEmpty ? contact.name.first[0] : '';
    final lastName = contact.name.last.isNotEmpty ? contact.name.last[0] : '';
    return (firstName + lastName).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: contacts == null
          ? const Center(child: CircularProgressIndicator())
          : contacts!.isEmpty
              ? const Center(child: Text('Aucun contact disponible'))
              : ListView.builder(
                  itemCount: contacts!.length,
                  itemBuilder: (context, index) {
                    final contact = contacts![index];
                    return ListTile(
                      title: Text(contact.displayName),
                      subtitle: contact.phones.isNotEmpty
                          ? Text(contact.phones.first.number)
                          : const Text('Aucun numéro de téléphone'),
                      leading: contact.photo != null
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(contact.photo!))
                          : CircleAvatar(
                              child: Text(_getInitials(contact)),
                            ),
                    );
                  },
                ),
    );
  }
}

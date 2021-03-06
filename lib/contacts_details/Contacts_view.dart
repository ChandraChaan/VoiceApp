import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class View_Contacts extends StatefulWidget {
  @override
  _View_ContactsState createState() => _View_ContactsState();
}

class _View_ContactsState extends State<View_Contacts> {
  late Iterable<Contact> _contacts;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        final PermissionStatus permissionStatus = await _getPermission();
        if (permissionStatus == PermissionStatus.granted) {
          Container(
            child: _contacts != null
            //Build a list view of all contacts, displaying their avatar and
            // display name
                ? ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = _contacts.elementAt(index);
                var number = contact.phones;
                print(contact.phones!.length);
                return ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                  leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
                      ? CircleAvatar(
                    backgroundImage: MemoryImage(contact.avatar!),
                  )
                      : CircleAvatar(
                    child: Text(contact.initials()),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  title: Text(contact.displayName ?? ''),
                );
              },
            )
                : Center(child: const CircularProgressIndicator()),
          );
        } else {
          //If permissions have been denied show standard cupertino alert dialog
          showDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Permissions error'),
                content: Text('Please enable contacts access '
                    'permission in system settings'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
        }
      },
      child: Container(child: Text('Get Contacts')),
    );
  }
  }


  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.restricted;
    } else {
      return permission;
    }
  }

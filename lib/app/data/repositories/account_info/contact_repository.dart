import 'package:flutter_prismahr/app/data/models/account_info/contact_model.dart';
import 'package:flutter_prismahr/app/data/providers/account_info/contact_provider.dart';

class ContactRepository {
  final ContactProvider provider = ContactProvider();

  Future<List<Contact>> fetch() {
    return provider.fetch();
  }

  Future<dynamic> add(Map<String, dynamic> data) {
    return provider.add(data);
  }
}

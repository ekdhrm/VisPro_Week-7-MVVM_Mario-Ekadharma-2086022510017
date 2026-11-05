import 'package:flutter/material.dart';
import 'data/sample_data.dart';
import 'viewmodels/catalogue_view_model.dart';
import 'viewmodels/library_view_model.dart';
import 'views/library_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LibraryViewModel _library;
  late final CatalogueViewModel _catalogue;

  @override
  void initState() {
    super.initState();
    _library = LibraryViewModel(
      books: sampleBooks,
      loans: sampleLoans(DateTime.now()),
    );
    _catalogue = CatalogueViewModel(_library);
  }

  @override
  void dispose() {
    _catalogue.dispose();
    _library.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Library',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: LibraryScreen(
        library: _library,
        catalogue: _catalogue,
        studentId: kStudentId,
      ),
    );
  }
}

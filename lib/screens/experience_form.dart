import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _category = "Organization";
  String _description = "";
  String _thumbnail = "";
  DateTime? _endedAt;

  final List<String> _categories = [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
    'Organization',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Experience Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === 1. Title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Judul Pengalaman",
                    labelText: "Judul Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Judul pengalaman tidak boleh kosong!";
                    }
                    if (value.trim().length > 255) {
                      return "Judul pengalaman maksimal 255 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === 2. Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === 3. Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Pengalaman",
                    labelText: "Deskripsi Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi pengalaman tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === 4. Thumbnail URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Gambar Thumbnail (opsional)",
                    labelText: "Tautan Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value != null && value.trim().isNotEmpty) {
                      if (value.trim().length > 500) {
                        return "URL thumbnail maksimal 500 karakter!";
                      }
                      if (!value.trim().startsWith("http://") &&
                          !value.trim().startsWith("https://")) {
                        return "Format URL harus valid (diawali http:// atau https://)!";
                      }
                    }
                    return null;
                  },
                ),
              ),

              // === 5. Tanggal Selesai (showDatePicker) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _endedAt == null
                            ? "Tanggal Selesai: Masih Berlangsung (Ongoing)"
                            : "Tanggal Selesai: ${_endedAt!.year}-${_endedAt!.month.toString().padLeft(2, '0')}-${_endedAt!.day.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2035),
                        );
                        if (picked != null) {
                          setState(() {
                            _endedAt = picked;
                          });
                        }
                      },
                      child: const Text(
                        "Pilih Tanggal",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Pengalaman berhasil ditambahkan!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Judul: $_title'),
                                    Text('Kategori: $_category'),
                                    Text('Deskripsi: $_description'),
                                    Text(
                                      'Thumbnail: ${_thumbnail.isEmpty ? "(Kosong)" : _thumbnail}',
                                    ),
                                    Text(
                                      _endedAt == null
                                          ? 'Tanggal Selesai: Masih Berlangsung (Ongoing)'
                                          : 'Tanggal Selesai: ${_endedAt!.year}-${_endedAt!.month.toString().padLeft(2, '0')}-${_endedAt!.day.toString().padLeft(2, '0')}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _endedAt = null;
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

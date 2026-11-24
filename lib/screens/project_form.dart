import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _skillsUsed = "";
  String _projectUrl = "";
  String _projectImageUrl = "";
  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final loggedIn = await ensureLoggedIn(context);
    if (!mounted || !loggedIn) return;

    setState(() {
      _isSubmitting = true;
    });

    final token = context.read<AuthState>().token;
    if (token == null) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      return;
    }

    final newProject = Project(
      title: _title,
      description: _description,
      skillsUsed: _skillsUsed,
      projectUrl: _projectUrl,
      projectImageUrl: _projectImageUrl,
    );

    try {
      final createdProject = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );

      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Proyek Berhasil Dibuat! (201 Created)'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Judul: ${createdProject.title}'),
                Text('Deskripsi: ${createdProject.description}'),
                Text('Skills Used: ${createdProject.skillsUsed}'),
                Text('Tautan: ${createdProject.projectUrl}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi telah berakhir (401). Silakan login ulang.'),
            backgroundColor: Colors.red,
          ),
        );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal membuat proyek (${e.statusCode}): ${e.message}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project Form'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Nama / Judul Proyek",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => _title = value.trim(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title cannot be empty!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Deskripsi singkat tentang proyek",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => _description = value.trim(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description cannot be empty!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Skills Used
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Skills Used",
                  hintText:
                      "Contoh: Flutter, Django REST Framework, PostgreSQL",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => _skillsUsed = value.trim(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Skills Used cannot be empty!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Project URL
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Project URL",
                  hintText: "https://github.com/username/project",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => _projectUrl = value.trim(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Project URL cannot be empty!";
                  }
                  final uri = Uri.tryParse(value.trim());
                  if (uri == null ||
                      !uri.hasScheme ||
                      (!uri.isScheme('http') && !uri.isScheme('https'))) {
                    return "Format URL harus valid (diawali http:// atau https://)!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Project Image URL (Optional)
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Project Image URL (Optional)",
                  hintText: "https://example.com/image.png",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) => _projectImageUrl = value.trim(),
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Save Project",
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

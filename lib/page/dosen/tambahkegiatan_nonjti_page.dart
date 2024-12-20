import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm/widget/dosen/custom_bottomappbar.dart';
import 'package:intl/intl.dart';

class TambahKegiatanNonJTIPage extends StatefulWidget {
  const TambahKegiatanNonJTIPage({Key? key}) : super(key: key);

  @override
  _TambahKegiatanNonJTIPageState createState() => _TambahKegiatanNonJTIPageState();
}

class _TambahKegiatanNonJTIPageState extends State<TambahKegiatanNonJTIPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaKegiatanController = TextEditingController();
  final TextEditingController _jenisKegiatanController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _tanggalMulaiController = TextEditingController();
  final TextEditingController _tanggalSelesaiController = TextEditingController();
  final TextEditingController _tanggalAcaraController = TextEditingController();

  List<Map<String, String>> anggotaList = [
    {'jabatan': 'Anggota', 'nama': 'Albani Rajata Malik'},
  ];

  final List<String> jabatanOptions = ['PIC', 'Anggota'];
  final List<String> dosenOptions = ['Albani Rajata Malik'];

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void _saveKegiatan() {
    if (_formKey.currentState!.validate()) {
      final newKegiatan = {
        'nama_kegiatan': _namaKegiatanController.text,
        'jenis_kegiatan': _jenisKegiatanController.text,
        'deskripsi': _deskripsiController.text,
        'tanggal_mulai': _tanggalMulaiController.text,
        'tanggal_selesai': _tanggalSelesaiController.text,
        'tanggal_acara': _tanggalAcaraController.text,
        'anggota': anggotaList,
      };
      print(newKegiatan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 103, 119, 239),
        title: Text(
          'Tambah Kegiatan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 5, 167, 170),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Detail Kegiatan',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                // Card Body
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailField('Nama Kegiatan', _namaKegiatanController),
                      _buildDetailField('Jenis Kegiatan', _jenisKegiatanController),
                      _buildDetailField('Deskripsi Kegiatan', _deskripsiController, isDescription: true),
                      _buildDateField('Tanggal Mulai', _tanggalMulaiController),
                      _buildDateField('Tanggal Selesai', _tanggalSelesaiController),
                      _buildDateField('Tanggal Acara', _tanggalAcaraController),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Card Jabatan and Anggota
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 5, 167, 170),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Jabatan dan Anggota',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      // Card Body
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ..._buildAnggotaFields(),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: _saveKegiatan,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 5, 167, 170),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const CustomBottomAppBar().buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }

  List<Widget> _buildAnggotaFields() {
    return List.generate(anggotaList.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: jabatanOptions.contains(anggotaList[index]['jabatan']) ? anggotaList[index]['jabatan'] : null,
              items: jabatanOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  anggotaList[index]['jabatan'] = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Jabatan',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mohon pilih jabatan';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: 'Albani Rajata Malik',
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Nama Anggota',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDetailField(String title, TextEditingController controller, {bool isDescription = false, Color titleColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: titleColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            maxLines: isDescription ? 5 : 1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mohon isi $title';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
            onTap: () => _selectDate(context, controller),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mohon isi $title';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
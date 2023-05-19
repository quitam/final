// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/modules/auth/components/border_button.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({super.key});

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final TextEditingController _dateController = TextEditingController();

  late String selectedValue;
  PlatformFile? pickedBanner;
  PlatformFile? pickedPoster;
  UploadTask? uploadTask;

  List<String> genreNames = [
    'action',
    'adventure',
    'cartoon',
    'comedy',
    'drama',
    'fantasy',
    'fiction',
    'horror',
    'musicals',
    'mystery',
    'romance',
    'sports',
    'thriller'
  ];

  @override
  void initState() {
    super.initState();
    _dateController.text = '';
  }

  Future selectBanner() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }

    setState(() {
      pickedBanner = result.files.first;
    });
  }

  Future selectPoster() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }

    setState(() {
      pickedPoster = result.files.first;
    });
  }

  bool loading = false;
  String _movieName = '';
  String _duration = '';
  String _synopsis = '';
  String _trailer = '';
  String dropdownvalue = 'action';
  handleAddMovie() async {
    setState(() {
      loading = true;
    });

    //handle upload banner
    final pathBanner =
        'banners/${_movieName.toLowerCase().replaceAll(' ', '_')}.${pickedBanner!.extension}';
    final fileBanner = File(pickedBanner!.path!);
    final refBanner = FirebaseStorage.instance.ref().child(pathBanner);
    refBanner.putFile(fileBanner);

    //handle upload poster
    final pathPoster =
        'posters/${_movieName.toLowerCase().replaceAll(' ', '_')}.${pickedPoster!.extension}';
    final filePoster = File(pickedPoster!.path!);
    final refPoster = FirebaseStorage.instance.ref().child(pathPoster);
    refPoster.putFile(filePoster);

    Map<String, dynamic> data = {
      'id': _movieName.toLowerCase().replaceAll(' ', '_'),
      'name': _movieName,
      'duration': int.parse(_duration),
      'synopsis': _synopsis,
      'trailer': _trailer,
      'genres': ['cartoon', 'adventure'],
      'banner_image': pathBanner,
      'poster_image': pathPoster,
      'release_date': Timestamp.fromDate(DateTime.parse(_dateController.text))
    };
    try {
      await FirebaseFirestore.instance
          .collection('Movie')
          .doc(_movieName.toLowerCase().replaceAll(' ', '_'))
          .set(data);
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      toast('Thêm thành công');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Thêm phim',
            style: AppTextStyles.heading28,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: size.height * 0.05,
                    width: size.height * 0.05,
                    child: loading
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator())
                        : null,
                  ),
                ),
                buildNameMovieField(),
                DropdownButton(
                  dropdownColor: AppColors.darkGrey,
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: genreNames.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: AppTextStyles.normal16,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                buildDurationField(),
                buildSynopsisField(),
                buildTrailerField(),
                Row(
                  children: [
                    if (pickedBanner != null)
                      Expanded(child: Text(pickedBanner!.name.toString())),
                    ElevatedButton(
                        onPressed: selectBanner,
                        child: Text(pickedBanner != null
                            ? 'Đổi banner'
                            : 'Chọn banner'))
                  ],
                ),
                Row(
                  children: [
                    if (pickedPoster != null)
                      Expanded(child: Text(pickedPoster!.name.toString())),
                    ElevatedButton(
                        onPressed: selectPoster,
                        child: Text(pickedPoster != null
                            ? 'Đổi poster'
                            : 'Chọn poster'))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                      controller: _dateController,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025));

                        if (pickedDate != null) {
                          //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          setState(() {
                            _dateController.text = formattedDate;
                          });
                          print(_dateController.text);
                        } else {
                          print("Date is not selected");
                        }
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.calendarDay,
                          color: AppColors.white,
                        ),
                        labelText: 'Thời gian công chiếu',
                        labelStyle: AppTextStyles.heading18
                            .copyWith(color: AppColors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.blueMain)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.white)),
                      )),
                ),
                BorderButton(
                    size: size,
                    onTap: () => handleAddMovie(),
                    text: 'Thêm',
                    backgroundColor: AppColors.blueMain,
                    borderColor: AppColors.blueMain),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildNameMovieField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
          onChanged: (value) {
            setState(() {
              _movieName = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Tên phim',
            labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.blueMain)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.white)),
          )),
    );
  }

  Padding buildDurationField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
          onChanged: (value) {
            setState(() {
              _duration = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Thời lượng',
            labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.blueMain)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.white)),
          )),
    );
  }

  Padding buildSynopsisField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
          maxLines: 5,
          onChanged: (value) {
            setState(() {
              _synopsis = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Mô tả phim',
            labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.blueMain)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.white)),
          )),
    );
  }

  Padding buildTrailerField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
          onChanged: (value) {
            setState(() {
              _trailer = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Trailer',
            labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.blueMain)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.white)),
          )),
    );
  }
}

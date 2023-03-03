import 'package:get/get.dart';
import 'package:storebase/db_helper.dart';
import 'package:storebase/user.dart';
import 'package:flutter/material.dart';

class DetailController extends GetxController {
  RxList<User> _allData = <User>[].obs;
  bool _isLoading = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  final RxString name = ''.obs;
  get _name => name.value;
  final RxString age = ''.obs;
  get _age => age.value;

  final RxString salary = ''.obs;
  get _salary => name.value;

  void _refreshData() async {
    final data = await SQLHelper.getAllData();

    _allData = data as RxList<User>;
    _isLoading = false;
  }

  @override
  void initState() {
    _refreshData();
  }

  Future<void> _addData() async {
    await SQLHelper.createData(
        _nameController.text, _ageController.text, _salaryController.text);
    Get.snackbar('Store Base', 'Data created',
        backgroundColor: Color(0xFF1D76BE),
        backgroundGradient:
            LinearGradient(colors: [Color(0xFF6CA5D3), Color(0xFF105D9C)]),
        barBlur: 5);

    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
        id, _nameController.text, _ageController.text, _salaryController.text);
    Get.snackbar('Store Base', 'Data Updataed',
        backgroundColor: Colors.green,
        backgroundGradient:
            LinearGradient(colors: [Color(0xFF72BB74), Color(0xFF0D8011)]),
        barBlur: 5);
    _refreshData();
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    Get.snackbar('Store base', 'Data is deleted',
        backgroundColor: Color(0xFFEC5B4E),
        backgroundGradient:
            LinearGradient(colors: [Color(0xFFF1958E), Color(0xFFCE2519)]),
        barBlur: 15);

    _refreshData();
  }
}

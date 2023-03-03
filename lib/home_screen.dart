import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storebase/controller/detail_controller.dart';
import 'package:storebase/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  DetailController detailController = DetailController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _nameController.text = existingData['name'];
      _ageController.text = existingData['age'];
      _salaryController.text = existingData['salary'];
    }

    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 30,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Enter Name of Employee',
                  label: Text('Name'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Enter Age',
                  label: Text('Age'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _salaryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Enter Salary',
                  label: Text('Salary'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 5,
                    backgroundColor: Color(0xFF1D76BE),
                  ),
                  onPressed: () async {
                    if (id == null) {
                      await Get.find()._addData();
                    }
                    if (id != null) {
                      await Get.find()._updateData(id);
                    }

                    _nameController.text = "";
                    _ageController.text = "";
                    _salaryController.text = "";

                    Navigator.of(context).pop();
                    print("Data Added");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      id == null ? "Add Data" : "Update",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFD7E1E9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEAF4),
      appBar: AppBar(
        backgroundColor: Color(0xFF1D76BE),
        title: Text('Store Base'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GetBuilder(
              init: DetailController(),
              builder: (controller) => ListView.builder(
                itemCount: _allData.length,
                itemBuilder: (context, index) => Card(
                  margin: EdgeInsets.all(15),
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Obx(
                        () => Text(
                          '${controller.name}',
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF1D76BE)),
                        ),
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Obx(
                          () => Text('${controller.age}'),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Obx(
                          () => Text('salary: ${controller.salary}'),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showBottomSheet(_allData[index]['id']);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Color(0xFF1D76BE),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.find()._deleteData(index);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: Container(
        width: 170,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: Color(0xFF1D76BE),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: () => showBottomSheet(null),
          tooltip: 'Add Data',
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Add Data",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

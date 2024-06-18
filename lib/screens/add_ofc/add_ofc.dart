import 'package:flutter/material.dart';

import '../../firebase/firebase_service.dart';
import '../../utils/app_utils.dart';

class AddOfficeForm extends StatefulWidget {
  const AddOfficeForm({super.key});

  @override
  State<AddOfficeForm> createState() => _AddOfficeFormState();
}

class _AddOfficeFormState extends State<AddOfficeForm> {
  final _formKey = GlobalKey<FormState>();


  String _ofcName = '';
  int _pinCode = 0;
  String _taluk = '';
  String _destrict = '';
  String _state = '';
  int _teleNo = 0;
  String _ofcType = '';
  String _delivStat = '';
  String _headOfc = '';
  String _division = '';
  String _region = '';
  String _circle = '';

  final FirebaseService _service = FirebaseService();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _service.addOfc(
          ofcName: _ofcName,
          pinCode: _pinCode,
          taluka: _taluk,
          district: _destrict,
          state: _state,
          teleNo: _teleNo,
          ofcType: _ofcType,
          delivStat: _delivStat,
          headOfc: _headOfc,
          division: _division,
          region: _region,
          circle: _circle,
          context: context).then(
            (value) {
          if (value) {
            print('Office added successfully');
            Navigator.pop(context);
          } else {}
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Office Name'),
                    onSaved: (value) {
                      _ofcName = value ?? '';
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Pincode'),
                    onSaved: (value) {
                      _pinCode = int.parse(value ?? '0');
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Taluk'),
                    onSaved: (value) {
                      _taluk = value ?? '';
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'District'),
                    onSaved: (value) {
                      _destrict = value ?? '';
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'State'),
                    onSaved: (value) {
                      _state = value ?? '';
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Telephone'),
                    onSaved: (value) {
                      _teleNo = int.parse(value ?? '0');
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Office Type'),
                    onSaved: (value) {
                      _ofcType = value ?? '';
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Delivery Status'),
                    onSaved: (value) {
                      _delivStat = value ?? '';
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Head Office'),
                    onSaved: (value) {
                      _headOfc = value ?? '';
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Division'),
                    onSaved: (value) {
                      _division = value ?? '';
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Region'),
                    onSaved: (value) {
                      _region = value ?? '';
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Circle'),
                    onSaved: (value) {
                      _circle = value ?? '';
                    },
                    validator: (value) {
                      return AppUtil.validateName(value);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FilledButton(
                    onPressed: () {
                      _submitForm(context);
                    },
                    child: Text('Add Office'),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.red.shade400),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

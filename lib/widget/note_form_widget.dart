import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:intl/intl.dart';

class NoteFormWidget extends StatefulWidget {

  final bool? isImportant;
  final int? number;
  final String? title;
  final String? phone;
  final String? status;
  final String? description;
  final String? dateToRedeem;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedPhone;
  final ValueChanged<String> onChangedStatus;
  final ValueChanged<String> onChangedDate;

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.phone = '',
    this.status = '',
    this.description = '',
    this.dateToRedeem = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDate,
    required this.onChangedDescription,
    required this.onChangedPhone,
    required this.onChangedStatus,
  }) : super(key: key);

  @override
  _NoteFormWidgetState createState() => _NoteFormWidgetState();
}

class _NoteFormWidgetState extends State<NoteFormWidget> {
  String _selectedDate = 'Tap to select date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2120),

    );

    if (d != null)
      print(d);
      _selectedDate=d.toString();
      setState(() {
        _selectedDate = new DateFormat.yMMMMd("en_US").format(d!);
      });
  }
  String _valueChanged = '';

  String _valueToValidate = '';

  String _valueSaved = '';
  String _initialValue ='';

  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();

  TextEditingController? _status;

  final List<Map<String, dynamic>> _statusItems = [
    {
      'value': 'Redeemed 😌',
      'label': 'Redeemed',

    },
    {
      'value': 'Pending ⏳',
      'label': 'Pending',

    },

  ];

  @override
  void initState() {
    super.initState();

    _status = TextEditingController(text: '2');


    _getValue();
  }
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = 'circleValue';
        _status?.text = '';

      });
    });
  }
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row(
              //   children: [
              //     Switch(
              //       value: isImportant ?? false,
              //       onChanged: onChangedImportant,
              //     ),
              //     Expanded(
              //       child: Slider(
              //         value: (number ?? 0).toDouble(),
              //         min: 0,
              //         max: 5,
              //         divisions: 5,
              //         onChanged: (number) => onChangedNumber(number.toInt()),
              //       ),
              //     )
              //   ],
              // ),
              buildTitle(),
              SizedBox(height: 8),
              Divider(color: Colors.white,),
              buildPhone(),
              SizedBox(height: 8),
              Divider(color: Colors.white,),
              buildDescription(),
              Divider(color: Colors.white,),
              SizedBox(height: 16),
              buildDate(),
              Divider(color: Colors.white,),
              SizedBox(height: 16),
              buildStatus()
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: widget.title,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Name',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: widget.onChangedTitle,
      );

  Widget buildStatus() => SelectFormField(
    type: SelectFormFieldType.dropdown,

    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Status ',
      hintStyle: TextStyle(color: Colors.white70),
    ),

    dialogTitle: 'Set Status',
    dialogCancelBtn: 'CANCEL',
    items: _statusItems,
    onChanged: widget.onChangedStatus,
      validator: (title) =>
      title != null && title.isEmpty ? 'The status cannot be empty' : null,

    onSaved: (val) => setState(() => _valueSaved = val ?? ''),
  );

  Widget buildPhone() => TextFormField(
    maxLines: 1,
    keyboardType: TextInputType.number,
    initialValue: widget.phone,
    style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Phone ',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The phone cannot be empty' : null,
    onChanged: widget.onChangedPhone,
  );

  Widget buildDate() => TextFormField(
    maxLines: 1,
    readOnly: true,
    initialValue: widget.dateToRedeem,
    style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Date To Redeem ',
      hintStyle: TextStyle(color: Colors.white70),
      suffixIcon:   IconButton(
        icon: Icon(Icons.calendar_today),
        tooltip: 'Tap to open date picker',
        onPressed: () {
          _selectDate(context);
        },
      ),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The date cannot be empty' : null,
    onChanged: widget.onChangedDate,
  );

  Widget buildDescription() => TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        initialValue: widget.description,
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Number of Copies ',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Number of Copies cannot be empty'
            : null,
        onChanged: widget.onChangedDescription,
      );
}

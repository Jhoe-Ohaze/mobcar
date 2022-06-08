import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>?> listStream;
  final Stream<Map<String, dynamic>?> itemStream;
  final Function(Map<String, dynamic>?) onChanged;
  final GlobalKey<FormFieldState> buttonKey;
  final String fieldName;
  const DropdownField({
    required this.fieldName,
    required this.listStream,
    required this.itemStream,
    required this.onChanged,
    required this.buttonKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: StreamBuilder<List<Map<String, dynamic>>?>(
        stream: listStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? dropdownContainer(snapshot.data!)
              : emptyDropdown();
        },
      ),
    );
  }

  Widget emptyDropdown() {
    return DropdownButtonFormField<Map<String, dynamic>?>(
      key: buttonKey,
      decoration: InputDecoration(label: Text(fieldName)),
      items: const [],
      onChanged: null,
    );
  }

  Widget dropdownContainer(List<Map<String, dynamic>> list) {
    return StreamBuilder<Map<String, dynamic>?>(
      stream: itemStream,
      builder: (context, snapshot) {
        return DropdownButtonFormField<Map<String, dynamic>>(
          key: buttonKey,
          decoration: InputDecoration(label: Text(fieldName)),
          value: snapshot.data,
          items: list
              .map<DropdownMenuItem<Map<String, dynamic>>>(
                (value) => DropdownMenuItem<Map<String, dynamic>>(
                  value: value,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      value['nome'],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}

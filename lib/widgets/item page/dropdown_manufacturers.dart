import 'package:flutter/material.dart';
import 'package:mobcar/core/car.dart';

class DropdownManufacturers extends StatefulWidget {
  final Stream<List<Manufacturer>?> stream;
  final Function(Manufacturer?) onChanged;
  final GlobalKey<FormFieldState> buttonKey;
  const DropdownManufacturers({
    required this.stream,
    required this.onChanged,
    required this.buttonKey,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownManufacturers> createState() => _DropdownManufacturersState();
}

class _DropdownManufacturersState extends State<DropdownManufacturers> {
  final String _fieldName = 'Fabricante';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Manufacturer>?>(
      stream: widget.stream,
      builder: (context, listSnapshot) {
        bool hasData = listSnapshot.hasData;

        return DropdownButtonFormField<Manufacturer>(
          key: widget.buttonKey,
          decoration: InputDecoration(label: Text(_fieldName)),
          items: hasData
              ? listSnapshot.data!
                  .map<DropdownMenuItem<Manufacturer>>(
                    (value) => DropdownMenuItem<Manufacturer>(
                      value: value,
                      child: Text(value.name),
                    ),
                  )
                  .toList()
              : [],
          onChanged: hasData ? widget.onChanged : null,
        );
      },
    );
  }
}

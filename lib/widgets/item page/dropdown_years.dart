import 'package:flutter/material.dart';
import 'package:mobcar/core/car.dart';

class DropdownYears extends StatelessWidget {
  final Stream<List<Year>?> stream;
  final Function(Year?) onChanged;
  final GlobalKey<FormFieldState> buttonKey;
  const DropdownYears({
    required this.stream,
    required this.onChanged,
    required this.buttonKey,
    Key? key,
  }) : super(key: key);

  final String _fieldName = 'Ano';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Year>?>(
      stream: stream,
      builder: (context, snapshot) {
        bool hasData = snapshot.hasData;

        return DropdownButtonFormField<Year>(
          key: buttonKey,
          decoration: InputDecoration(label: Text(_fieldName)),
          items: hasData
              ? snapshot.data!
                  .map<DropdownMenuItem<Year>>(
                    (value) => DropdownMenuItem<Year>(
                      value: value,
                      child: Text(value.name),
                    ),
                  )
                  .toList()
              : null,
          onChanged: hasData ? onChanged : null,
        );
      },
    );
  }
}

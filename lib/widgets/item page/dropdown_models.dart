import 'package:flutter/material.dart';
import 'package:mobcar/core/car.dart';

class DropdownModels extends StatelessWidget {
  final Stream<List<Model>?> stream;
  final Function(Model?) onChanged;
  final GlobalKey<FormFieldState> buttonKey;
  const DropdownModels({
    required this.stream,
    required this.onChanged,
    required this.buttonKey,
    Key? key,
  }) : super(key: key);

  final String _fieldName = 'Modelo';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Model>?>(
      stream: stream,
      builder: (context, snapshot) {
        bool hasData = snapshot.hasData;

        return DropdownButtonFormField<Model>(
          key: buttonKey,
          decoration: InputDecoration(label: Text(_fieldName)),
          items: hasData
              ? snapshot.data!
                  .map<DropdownMenuItem<Model>>(
                    (value) => DropdownMenuItem<Model>(
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

  reset() {}
}

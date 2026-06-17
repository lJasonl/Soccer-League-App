import 'package:flutter/material.dart';

import '../../models/division.dart';
import '../../services/division_data_service.dart';

class DivisionManagementScreen
    extends StatefulWidget {
  const DivisionManagementScreen({
    super.key,
  });

  @override
  State<DivisionManagementScreen>
      createState() =>
          _DivisionManagementScreenState();
}

class _DivisionManagementScreenState
    extends State<
        DivisionManagementScreen> {
  static const Color dcsaNavy =
      Color(0xFF0B2A5B);

  final TextEditingController
      _divisionController =
      TextEditingController();

  @override
  void dispose() {
    _divisionController.dispose();
    super.dispose();
  }

  Future<void> _addDivision() async {
    final name =
        _divisionController.text
            .trim();

    if (name.isEmpty) {
      return;
    }

    final exists =
        DivisionDataService.divisions
            .any(
      (division) =>
          division.name
              .toLowerCase() ==
          name.toLowerCase(),
    );

    if (exists) {
      return;
    }

    await DivisionDataService
        .addDivision(
      Division(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        name: name,
        isActive: true,
      ),
    );

    _divisionController.clear();

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final divisions =
        DivisionDataService.divisions;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Division Management',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(
          16,
        ),
        children: [
          Container(
            padding:
                const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
              color: dcsaNavy,
              borderRadius:
                  BorderRadius.circular(
                24,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.groups,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'League Divisions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${divisions.length} Divisions',
                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          TextField(
            controller:
                _divisionController,
            decoration:
                InputDecoration(
              labelText:
                  'Division Name',
              hintText:
                  'Example: U7',
              suffixIcon:
                  IconButton(
                icon: const Icon(
                  Icons.add,
                ),
                onPressed:
                    _addDivision,
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          const Text(
            'Current Divisions',
            style: TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          ...divisions.map(
            (division) => Card(
              child: ListTile(
                title: Text(
                  division.name,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  division.isActive
                      ? 'Active'
                      : 'Inactive',
                ),
                leading:
                    Switch(
                  value:
                      division.isActive,
                  onChanged:
                      (_) async {
                    await DivisionDataService
                        .toggleDivisionStatus(
                      division.id,
                    );

                    setState(
                      () {},
                    );
                  },
                ),
                trailing:
                    IconButton(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  onPressed:
                      () async {
                    await DivisionDataService
                        .deleteDivision(
                      division.id,
                    );

                    setState(
                      () {},
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
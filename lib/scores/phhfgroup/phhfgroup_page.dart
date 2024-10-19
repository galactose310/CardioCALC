/// Main page for PH-HFpEF Group
import 'package:flutter/material.dart';
import './view/phhfgroup_view.dart';
import 'phhfgroup_viewmodel.dart';

class PhhfGroupPage extends StatelessWidget {
  /// Calls the PhhfGroupViewModel and wrap it in PhhfGroupView.
  const PhhfGroupPage({super.key});

  @override
  Widget build(BuildContext context) => PhhfGroupView(PhhfGroupViewModel());
}
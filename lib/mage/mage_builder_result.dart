

import 'package:flutter/material.dart';

import 'mage_result.dart';
import 'mage_state.dart';

class MageBuilderResult {
  MageState _mageState;

  BuildContext _context;
  MageBuilderResult(BuildContext context, MageState state ) {
    this._context = context;
    this._mageState = state;

  }

  get state => _mageState?.state;
  get value => _mageState?.result?.value;
  get context => _context;
}


import 'package:flutter/material.dart';

import 'bloc_state.dart';



class CFBlocBuilderResult {
  CFBlocState _mageState;

  BuildContext _context;
  CFBlocBuilderResult(BuildContext context, CFBlocState state ) {
    this._context = context;
    this._mageState = state;

  }

  get state => _mageState?.state;
  get value => _mageState?.result?.value;
  get context => _context;
}
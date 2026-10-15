// SPDX-FileCopyrightText: 2026 Thomas "Seremptos"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:sqflite/sqlite_api.dart';

abstract class DbUpgrade {
  Future<void> upgrade(Database db, int oldVersion, int newVersion);
}

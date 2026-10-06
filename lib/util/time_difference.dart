// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

double timeDifferenceInDays(DateTime instant, DateTime baseline) =>
    instant.difference(baseline).inMicroseconds / Duration.microsecondsPerDay;

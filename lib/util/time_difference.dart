// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

double timeDifferenceInDays(DateTime instant, DateTime baseline) =>
    instant.difference(baseline).inMicroseconds / Duration.microsecondsPerDay;

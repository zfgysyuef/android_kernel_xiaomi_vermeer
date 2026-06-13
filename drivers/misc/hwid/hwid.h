/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef _HWID_H
#define _HWID_H

/* Hardware project IDs */
#define HARDWARE_PROJECT_M2  2
#define HARDWARE_PROJECT_M3  3
#define HARDWARE_PROJECT_N11 11

/* Country codes */
#define CountryCN 1
#define CountryGL 2

/* Stub functions */
static inline int get_hw_version_platform(void) { return 0; }
static inline int get_hw_country_version(void) { return 0; }

#endif

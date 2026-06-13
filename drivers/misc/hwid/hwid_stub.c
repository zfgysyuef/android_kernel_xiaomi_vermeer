// SPDX-License-Identifier: GPL-2.0-only
#include <linux/module.h>
#include <linux/kernel.h>

static int __init hwid_init(void) { return 0; }
static void __exit hwid_exit(void) { }

module_init(hwid_init);
module_exit(hwid_exit);
MODULE_LICENSE("GPL");

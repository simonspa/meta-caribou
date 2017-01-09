/*  Caribou module.
    Copyright (C) 2017  Adrian Fiergolski <Adrian.Fiergolski@cern.ch>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


#include <linux/module.h>

int init_module(void)
{
	printk("Hello World!\n");
	return 0;
}

void cleanup_module(void)
{
	printk("Goodbye Cruel World!\n");
}

MODULE_LICENSE("GPL");

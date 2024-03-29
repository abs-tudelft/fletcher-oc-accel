#
# Copyright 2017 International Business Machines
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FLETCHER_DIR=$(shell pwd)/../../fletcher
FLETCHER_OCACCEL_DIR=$(shell pwd)/../..
subdirs += sw

all: $(subdirs)

.PHONY: $(subdirs) hw

hw:
	echo "INFO: Patching Fletcher to ignore oc-accel's strange reset behavior in simulation..."
	#run some bash code to deal with the situation where the patch is already applied
	cd $(FLETCHER_DIR) && patch -i $(FLETCHER_OCACCEL_DIR)/fletcher_fail2warn.patch -p1 -f; \
	retcode=$?; \
	[[ $$retCode -gt 1 ]] && exit $$retCode; \
	exit 0
	echo "INFO: Generating Fletcher stringwrite example design..."
	rm -f ./hw/fletcher
	rm -f ./hw/stringwrite
	ln -fs $(FLETCHER_DIR)/hardware ./hw/fletcher
	ln -fs $(FLETCHER_DIR)/examples/stringwrite/hardware ./hw/stringwrite
	cd ./hw/stringwrite && python3 generate-input.py && \
fletchgen -i stringwrite.as -t memory.srec -l vhdl dot --axi --regs c:32:strlen_min c:32:strlen_mask


$(subdirs):
	@if [ -d $@ -a -f $@/Makefile ]; then			\
		$(MAKE) -C $@ || exit 1;			\
	else							\
		echo "INFO: No Makefile available in $@ ...";	\
	fi

# Cleanup for all subdirectories.
# Only dive into subdirectory if existent and if Makefile is there.
clean:
	rm -f ./hw/fletcher
	rm -f ./hw/stringwrite
	@for dir in $(subdirs); do	\
		if [ -d $$dir -a -f $$dir/Makefile ]; then	\
			$(MAKE) -C $$dir $@ || exit 1;		\
		fi						\
	done
	@find . -depth -name '*~'  -exec rm -rf '{}' \; -print
	@find . -depth -name '.#*' -exec rm -rf '{}' \; -print

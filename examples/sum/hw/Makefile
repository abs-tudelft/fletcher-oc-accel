#
# Copyright 2017, International Business Machines
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#	 http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FLETCHER_DIR=$(shell pwd)/../../../fletcher
FLETCHER_OCACCEL_DIR=$(shell pwd)/../../..

vhd_srcs=$(wildcard *.vhd_source)
vhd_files=$(vhd_srcs:.vhd_source=.vhd)

.PHONY: all config clean vhdl

all: config softlinks


softlinks:
	echo "INFO: Patching Fletcher to ignore oc-accel's strange reset behavior in simulation..."
	#run some bash code to deal with the situation where the patch is already applied
	cd $(FLETCHER_DIR) && patch -i $(FLETCHER_OCACCEL_DIR)/fletcher_fail2warn.patch -p1 -f; \
	retcode=$?; \
	[[ $$retCode -gt 1 ]] && exit $$retCode; \
	exit 0
	echo "INFO: Generating Fletcher sum example design..."
	rm -f ./fletcher
	rm -f ./sum
	ln -fs $(FLETCHER_DIR)/hardware ./fletcher
	ln -fs $(FLETCHER_DIR)/examples/sum/hardware ./sum
	cd ./sum && python3 generate-input.py && \
LD_LIBRARY_PATH= fletchgen -n Sum -r recordbatch.rb -s memory.srec -l vhdl --axi
#If a Xilinx toolchain is sourced (needed for oc-accel), its LD_LIBRARY_PATH can cause problems

config:
	$(info Call action_config.sh)
	./action_config.sh

clean:
	@$(RM) $(vhd_files)
	rm -f ./fletcher
	rm -f ./sum

vhdl:

#
# FIXME Consider moving the functionality from action_config.sh into
#	  this Makefile. This also allows to define a proper clean rule
#	  such that the directory gets properly cleaned up and git status
#	  shows not the generated files.
#

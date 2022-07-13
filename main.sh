#!/usr/bin/env bash

# Copyright 2022 Gunju Kim <gjkim042@gmail.com>.
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

set -o errexit
set -o nounset
set -o pipefail

findnotargs="-wholename './vendor' "
if [[ -f ".goverifyignore" ]]; then
	while IFS=$'\n,' read -r ignorefile; do
		findnotargs+="-o -wholename '${ignorefile}' "
	done < ".goverifyignore"
fi

find_files() {
	find . -not \( \
		\( \
			${findnotargs} \
		\) -prune \
	\) -name '*.go'
}

diff=$(find_files | xargs gofmt -d -s 2>&1) || true
if [[ -n "${diff}" ]]; then
	echo "${diff}" >&2
	echo >&2
	echo "Run gofmt" >&2
	exit 1
fi

go install golang.org/x/tools/cmd/goimports@latest
diff=$(find_files | xargs goimports -d 2>&1) || true
if [[ -n "${diff}" ]]; then
	echo "${diff}" >&2
	echo >&2
	echo "Run goimports" >&2
	exit 1
fi

if [[ "${INPUT_GO_MOD}" == "true" ]]; then
	go mod tidy
	diff=$(git diff -- go.mod go.sum 2>&1) || true
	if [[ -n "${diff}" ]]; then
		echo "${diff}" >&2
		echo >&2
		echo "Run go mod tidy" >&2
		exit 1
	fi
fi

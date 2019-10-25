# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


class SSDHashingMapper():
    def _hash_field(self, s):
        import hashlib
        return hashlib.sha256(s.strip().lower().encode('utf-8')).hexdigest()

    def _map_conversion(self, conversion):
        return {
            'hashedEmail': self._hash_field(conversion['email']),
            'time': conversion['time'],
            'amount': conversion['amount']
        }

    def map_conversions(self, conversions):
        return [self._map_conversion(conversion) for conversion in conversions]

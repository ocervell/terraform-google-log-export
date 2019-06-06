# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

log_export_map   = attribute('log_export_map')
destination_map  = attribute('destination_map')

control "gcloud" do
  title "Log exports - organization level bigquery destination - gcloud commands"

  describe command("gcloud logging sinks list --organization #{log_export_map['sink_parent_id']} --filter=\"name:#{log_export_map['sink_resource_names'][0]}\" --format json") do
    its('exit_status') { should eq 0 }
    its('stderr') { should eq '' }
    let(:sink) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout, symbolize_names: true)[0]
      else
        []
      end
    end

    it "does return the correct log sink" do
      expect(sink).to include(
        name: log_export_map["resource_names"][0]
      )
    end

    it "does contain the writerIdentity of #{log_export_map['writer_identity']}" do
      expect(sink).to include(
        writerIdentity: log_export_map["writer_identities"][0]
      )
    end

    it "does contain the destination of #{destination_map['destination_uris'][0]}" do
      expect(sink).to include(
        destination: destination_map["destination_uris"][0]
      )
    end

    it "does contain the filter of #{log_export_map['filters'][0]}" do
      expect(sink).to include(
        filter: log_export_map["filters"][0]
      )
    end
  end
end

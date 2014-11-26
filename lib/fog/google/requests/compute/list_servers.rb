module Fog
  module Compute
    class Google
      class Mock
        def list_servers(zone_name)
          get_zone(zone_name)
          zone = self.data[:zones][zone_name]
          servers = self.data[:servers].values.select{|s| s["zone"] == zone["selfLink"]}
          build_excon_response({
            "kind" => "compute#instanceList",
            "selfLink" => "https://www.googleapis.com/compute/#{api_version}/projects/#{@project}/zones/#{zone_name}/instances",
            "id" => "projects/#{@project}/zones/#{zone_name}/instances",
            "items" => servers
          })
        end
      end

      class Real
        def list_servers(zone_name_or_url)
          api_method = @compute.instances.list
          parameters = zone_request_parameters(zone_name_or_url)
          request(api_method, parameters)
        end
      end
    end
  end
end

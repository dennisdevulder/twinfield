module Twinfield
  module Request
	  module List
	    extend self

			def browsefields
				xml_doc = xml_wrap(Twinfield::Process.list(:browsefields))

				array = []
				xml_doc.css("browsefield").each do |xml|
					array << {
						code: xml.at_css("code").content,
						datatype: xml.at_css("datatype").content,
						finder: xml.at_css("finder").content,
						dropdown: xml.at_css("dropdown").css("option").map {|opt| opt[:name] },
						canorder: xml.at_css("canorder").content
					}
				end

				return array
			end

			def budgets
				raise NotImplementedError
			end

			def dimensions
				raise NotImplementedError
			end

			def offices
				xml_doc = xml_wrap(Twinfield::Process.list(:offices))

				array = []
				xml_doc.css("office").each do |xml|
					array << {
						name: xml[:name],
						shortname: xml[:shortname],
						code: xml.content
					}
				end

				return array
			end

			protected

			def xml_wrap(response)
				Nokogiri::XML(response.body[:process_xml_string_response][:process_xml_string_result])
			end
		end
	end
end
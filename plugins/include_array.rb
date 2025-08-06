# Jekyll 4 compatible include_array replacement
module Jekyll
  class IncludeArrayTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
      @variable_name = markup.strip
    end

    def render(context)
      site = context.registers[:site]
      array_name = @variable_name
      
      # 获取配置中的数组
      array = site.config[array_name] || []
      
      # 渲染每个包含文件
      output = ""
      array.each do |include_file|
        begin
          template = site.includes[include_file]
          if template
            output += template.render(context)
          else
            # 尝试读取文件
            include_path = File.join(site.source, "_includes", include_file)
            if File.exist?(include_path)
              content = File.read(include_path)
              template = Liquid::Template.parse(content)
              output += template.render(context)
            end
          end
        rescue => e
          Jekyll.logger.warn "Include Array:", "Could not include #{include_file}: #{e.message}"
        end
      end
      output
    end
  end
end

Liquid::Template.register_tag('include_array', Jekyll::IncludeArrayTag)
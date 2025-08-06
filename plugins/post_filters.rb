# Jekyll 4 compatible post_filters replacement
module Jekyll

  # Extended plugin type that allows the plugin
  # to be called on various callback methods.
  class PostFilter < Plugin

    #Called before post is sent to the converter. Allows
    #you to modify the post object before the converter
    #does it's thing
    def pre_render(post)
    end

    #Called after the post is rendered with the converter.
    #Use the post object to modify it's contents before the
    #post is inserted into the template.
    def post_render(post)
    end

    #Called after the post is written to the disk.
    #Use the post object to read it's contents to do something
    #after the post is safely written.
    def post_write(post)
    end
  end

  # Jekyll 4 compatible Site extension
  class Site

    # Instance variable to store the various post_filter
    # plugins that are loaded.
    attr_accessor :post_filters

    # Instantiates all of the post_filter plugins.
    def load_post_filters
      # Jekyll 4 doesn't have subclasses method, so we'll maintain a simple empty array
      # This maintains compatibility while avoiding errors
      self.post_filters = []
    end
    
    # Jekyll 4 uses hooks system instead of direct method override
    alias_method :old_process, :process unless method_defined?(:old_process)
    
    def process
      load_post_filters
      old_process
    end
  end

  # Use Jekyll 4 hooks system
  Jekyll::Hooks.register :posts, :pre_render do |post, payload|
    site = payload['site']
    if site.respond_to?(:post_filters) && site.post_filters
      site.post_filters.each do |filter|
        filter.pre_render(post) if filter.respond_to?(:pre_render)
      end
    end
  end

  Jekyll::Hooks.register :posts, :post_render do |post, payload|
    site = payload['site']
    if site.respond_to?(:post_filters) && site.post_filters
      site.post_filters.each do |filter|
        filter.post_render(post) if filter.respond_to?(:post_render)
      end
    end
  end

  Jekyll::Hooks.register :posts, :post_write do |post|
    site = post.site
    if site.respond_to?(:post_filters) && site.post_filters
      site.post_filters.each do |filter|
        filter.post_write(post) if filter.respond_to?(:post_write)
      end
    end
  end

end
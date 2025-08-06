# Rouge replacement for Pygments compatible code
require 'rouge'

PYGMENTS_CACHE_DIR = File.expand_path('../../.rouge-cache', __FILE__)
FileUtils.mkdir_p(PYGMENTS_CACHE_DIR)

module HighlightCode
  def highlight(str, lang)
    str = str.to_s.gsub(/\A\n+|\n+\z/, '')
    
    if defined?(Octopress) && Octopress.config['pygments'] == false
      return "<pre><code>#{str}</code></pre>"
    else
      begin
        # 使用 Rouge 替代 Pygments
        rouge(str, lang).match(/<pre[^>]*>(.*?)<\/pre>/m)[1].to_s.gsub(/ *$/, '')
      rescue => e
        Jekyll.logger.warn "Rouge Error:", e.message
        "<pre><code>#{str}</code></pre>"
      end
    end
  end

  def rouge(code, lang)
    # Compatibility mapping: map common language aliases to Rouge-supported names
    lang_map = {
      'objc' => 'objective_c',
      'bash' => 'shell',
      'console' => 'shell',
      'html' => 'html',
      'xml' => 'xml'
    }
    
    lang = lang_map[lang] || lang
    
    # Get corresponding lexer
    lexer = Rouge::Lexer.find_fancy(lang, code) || Rouge::Lexers::PlainText
    
    # Use HTML formatter
    formatter = Rouge::Formatters::HTML.new(
      css_class: "highlight",
      line_numbers: false,
      wrap: true
    )
    
    formatter.format(lexer.lex(code))
  rescue => e
    Jekyll.logger.warn "Rouge Lexer Error:", "#{e.message} for language '#{lang}'"
    Rouge::Formatters::HTML.new.format(Rouge::Lexers::PlainText.new.lex(code))
  end

  def tableize_code(str, lang = '')
    table = '<div class="highlight"><table><tr><td class="gutter"><pre class="line-numbers">'
    code_lines = str.split(/\n/)
    numbers = (1..code_lines.length).to_a
    numbers.each { |i| table += "<span class='line-number'>#{i}</span>\n" }
    table += '</pre></td><td class="code"><pre><code class="'+ lang + '">'
    table += str
    table += '</code></pre></td></tr></table></div>'
  end
end
## What is Octopress?

Octopress is [Jekyll](https://github.com/mojombo/jekyll) blogging at its finest.

1. **Octopress sports a clean responsive theme** written in semantic HTML5, focused on readability and friendliness toward mobile devices.
2. **Code blogging is easy and beautiful.** Embed code (with [Solarized](http://ethanschoonover.com/solarized) styling) in your posts from gists, jsFiddle or from your filesystem.
3. **Third party integration is simple** with built-in support for Pinboard, Delicious, GitHub Repositories, Disqus Comments and Google Analytics.
4. **It's easy to use.** A collection of rake tasks simplifies development and makes deploying a cinch.
5. **Ships with great plug-ins** some original and others from the Jekyll community &mdash; tested and improved.

**Note**: This installation has been upgraded to Jekyll 4.3.4 with modern dependencies and security fixes.

## 🚀 Modern Upgrade (2025)

This Octopress installation has been successfully modernized with the following improvements:

### ✅ Security Vulnerabilities Fixed
- **RedCloth**: Updated to 4.3.4 (CVE-2023-31606 fixed)
- **yajl-ruby**: Updated to 1.3.1 (CVE-2017-16516, CVE-2022-24795 fixed)
- **rack**: Updated to 2.2.17 (Multiple CVEs fixed)
- **kramdown**: Updated to 2.3.2 (CVE-2020-14001 fixed)
- **sinatra**: Updated to 2.2.4 (CVE-2022-29970, CVE-2024-21510 fixed)
- **jQuery**: Updated to 1.12.4 (CVE-2015-9251, CVE-2019-11358 fixed)

### ✅ Technical Modernization
- **Jekyll**: 3.6.3 → 4.3.4
- **Syntax Highlighting**: Pygments → Rouge
- **CSS Processing**: Compass → Standard Sass
- **Markdown Processing**: Enhanced kramdown with GFM support

### ✅ Plugin System Updates
1. **post_filters.rb**: Rewritten using Jekyll 4 Hooks system
2. **include_array.rb**: Created Jekyll 4 compatible version
3. **pygments_code.rb**: Complete rewrite using Rouge instead of Pygments
4. **Template Updates**: Converted `include_array` tags to standard Liquid syntax

## Getting Started

### Prerequisites
- Ruby 2.6.0 or higher
- Bundler gem

### Installation & Usage

```bash
# Install dependencies
bundle install

# Start development server
bundle exec jekyll serve
# Visit http://localhost:4000

# Build static site
bundle exec jekyll build
# Output in public/ directory

# Using Octopress rake tasks (optional)
bundle exec rake generate
bundle exec rake preview
```

### Project Structure
```
octopress/
├── _config.yml          # Jekyll 4 configuration
├── Gemfile              # Modern dependencies
├── plugins/             # Updated Jekyll 4 plugins
├── source/              # Blog source files
├── public/              # Generated static site
└── sass/                # Style source files
```

## Compatibility Notes

### Maintained Features
- All original blog posts and pages
- Original URL structure
- Website appearance and theme
- Sidebar functionality (GitHub repos, Douban reads, etc.)

### Known Limitations
- Some Octopress-specific plugins have been disabled for compatibility
- Advanced plugin features may require further adaptation

## Maintenance

### Regular Updates
```bash
# Update dependencies
bundle update

# Check for security issues
bundle audit
```

### Cache Management
The following cache directories are automatically ignored:
- `.pygments-cache` / `.rouge-cache`
- `.sass-cache`
- `.jekyll-cache`

## Documentation

Check out [Octopress.org](http://octopress.org/docs) for guides and documentation.
Note that some instructions may need adaptation for this Jekyll 4 modernized version.

## Contributing

[![Build Status](https://travis-ci.org/imathis/octopress.png?branch=master)](https://travis-ci.org/imathis/octopress)

We love to see people contributing to Octopress, whether it's a bug report, feature suggestion or a pull request. At the moment, we try to keep the core slick and lean, focusing on basic blogging needs, so some of your suggestions might not find their way into Octopress. For those ideas, we started a [list of 3rd party plug-ins](https://github.com/imathis/octopress/wiki/3rd-party-plugins), where you can link your own Octopress plug-in repositories. For the future, we're thinking about ways to easier add them into our main releases.


## License
(The MIT License)

Copyright © 2009-2013 Brandon Mathis

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#### If you want to be awesome.
- Proudly display the 'Powered by Octopress' credit in the footer.
- Add your site to the Wiki so we can watch the community grow.

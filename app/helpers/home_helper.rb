module HomeHelper

  def markdown(text)
      options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
      syntax_highlighter(Redcarpet.new(text, *options).to_html).html_safe
  end

  def syntax_highlighter(html)
      doc = Nokogiri::HTML(html)
      doc.search("//pre[@lang]").each do |pre|
        pre.children.each do |child|
          next unless child.name == 'code'
          child.set_attribute('class', "language-#{pre[:lang]}")
        end
      end
      doc.to_s
  end

end

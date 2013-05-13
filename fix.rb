require 'nokogiri'

doc = Nokogiri::XML(File.read('in.rss'))
doc.xpath('//item').each do |item|
  url = item.search('enclosure').first['url']
  if url =~ /http:\/\/cdn\.desiringgod\.org\/audio\/\d{4}\/(\d{4})(\d\d)(\d\d)\.mp3/
    date = Time.local($1, $2, $3, 18)
    date_string = date.strftime('%a, %e %b %Y %H:%M:%S %z')
    item.search('pubDate').first.content = date_string
  end
end

File.write('out.rss', doc.to_xml)

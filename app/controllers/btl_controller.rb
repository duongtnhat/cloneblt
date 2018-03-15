class BtlController < ApplicationController

  #router("/")
  def index
    options = {http_proxyaddr: 'fsoft-proxy',http_proxyport:'8080', http_proxyuser:'nhatdt2', http_proxypass:'Chandoiwa01234'}
    response = HTTParty.get 'http://m.blogtruyen.com/', options
    html_response = response.body
    @items = extract_item html_response
    render 'btl/index'
  end

  def extract_item(html_response)
    html = Nokogiri::HTML(html_response)
    ul = html.xpath('//ul[contains(@class, "list-unstyled") and contains(@class, "list-manga")]')
    list = []
    ul.xpath('.//li').each {|e|
      link = e.xpath('.//a/@href').first.value
      title = e.xpath('.//span').to_s
      img = e.xpath('.//img/@src').first.value
      list.push ({'link' => link, 'title' => title, 'img' => img})
    }
    return list
  end
end

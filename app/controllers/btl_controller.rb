class BtlController < ApplicationController

  #@@options = {http_proxyaddr: 'fsoft-proxy',http_proxyport:'8080', http_proxyuser:'nhatdt2', http_proxypass:'Chandoiwa01234'}

  #router("/")
  # #router("/:page")
  def index
    page = request.parameters[:page] || 'page-1'
    url = 'http://m.blogtruyen.com/' + page
    response = HTTParty.get url
    html_response = response.body
    @items = extract_item html_response
    page.sub!(/page-/, '')
    @page = page.to_i
    render 'btl/index'
  end

  #router("/:id/:name")
  def story
    url = 'http://blogtruyen.com/ajax/Chapter/PartialLoadListChapter?mangaId='+request.parameters[:id]
    response = HTTParty.get url
    @items = extract_chapter response.body
    render 'btl/story'
  end

  #router("/:cid/:name")
  def chapter
    url = 'http://m.blogtruyen.com/'+request.parameters[:id]
    response = HTTParty.get url
    html = Nokogiri::HTML(response)
    content = html.xpath('//div[@class="content"]').first
    content['class'] = 'mangaread-img'
    @post = content
    @bar = html.xpath('//div[contains(@class, "linkchapter")]').first
    render 'btl/chapter'
  end

  def extract_item(html_response)
    html = Nokogiri::HTML(html_response)
    ul = html.xpath('//ul[contains(@class, "list-unstyled") and contains(@class, "list-manga")]')
    list = []
    ul.xpath('.//li').each {|e|
      link = e.xpath('.//a/@href').first.value
      title = e.xpath('.//span').first.content
      img = e.xpath('.//img/@src').first.value
      list.push ({'link' => link, 'title' => title, 'img' => img})
    }
    return list
  end

  def extract_chapter(html_response)
    html = Nokogiri::HTML(html_response)
    div = html.xpath('//div[contains(@class, "list-wrap")]')
    list = []
    div.xpath('.//p').each {|e|
      link = e.xpath('.//a/@href').first.value
      title = e.xpath('.//a').first.content
      published_date = e.xpath('.//span[contains(@class, "publishedDate")]').first.content
      list.push ({'link' => link, 'title' => title, 'date' => published_date})
    }
    return list
  end
end

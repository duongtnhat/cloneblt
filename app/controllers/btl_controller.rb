class BtlController < ApplicationController

  include HTTParty
  include HTTParty::DryIce
  cache Rails.cache

  def index
    page = request.parameters[:page] || 'page-1'
    url = 'http://m.blogtruyen.com/' + page
    html_response = http_get(url)
    @items = extract_item html_response
    page.sub!(/page-/, '')
    @page = page.to_i
    expires_in 6.hours, public: true
    render 'btl/index'
  end

  def story
    url = 'http://blogtruyen.com/ajax/Chapter/PartialLoadListChapter?mangaId='+request.parameters[:id]
    @items = extract_chapter http_get(url)
    expires_in 6.hours, public: true
    render 'btl/story'
  end

  def chapter
    id = request.parameters[:id]
    name = request.parameters[:name]
    url = 'http://m.blogtruyen.com/%s/%s' % [id, name]
    html = Nokogiri::HTML(http_get(url))
    @post = html.xpath('//div[@class="content"]').first
    list = html.xpath('//select[@class="form-control"]').first
    @list = list
    @selected = list.xpath('.//option[@selected="selected"]').first
    @pre = @selected.next.nil? ? nil : @selected.next.attr("value")
    @next = @selected.previous.nil? ? nil : @selected.previous.attr("value")
    expires_in 6.hours, public: true
    render 'btl/chapter'
  end

  def search
    url = 'http://m.blogtruyen.com/timkiem?keyword=' + request.parameters[:keyword]
    url += '&p=' + request.parameters[:p] unless request.parameters[:p].nil?
    response = http_get(url)
    html = Nokogiri::HTML(response)
    @result = html.xpath('//article').first
    render 'btl/search'
  end

  private

  def extract_item(html_response)
    html = Nokogiri::HTML(html_response)
    ul = html.xpath('//ul[contains(@class, "list-unstyled") and contains(@class, "list-manga")]')
    list = []
    ul.xpath('.//li[contains(@class, "item")]').each do |e|
      link = e.xpath('.//a/@href').first.value
      title = e.xpath('.//span').first.content
      img = e.xpath('.//img/@src').first.value
      list << { link: link, title: title, img: img }
    end
    list
  end

  def extract_chapter(html_response)
    html = Nokogiri::HTML(html_response)
    div = html.xpath('//div[contains(@class, "list-wrap")]')
    list = []
    div.xpath('.//p').each do |e|
      link = e.xpath('.//a/@href').first.value
      title = e.xpath('.//a').first.content
      list << { link: link, title: title }
    end
    list
  end

  def http_get(url)
    Rails.cache.fetch(url) do
      logger.info "Load " << url
      response = HTTParty.get url
      break unless response.code == 200
      logger.info "Complete load " << url
      response.body
    end
  end
end

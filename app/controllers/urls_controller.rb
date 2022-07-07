# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    # recent 10 short urls
    @url = Url.new
    @urls = Url.includes(:clicks).order(created_at: :desc).limit(10)
  end

  def create
    # binding.pry
    Url.create!(url_params)
    # create a new URL record
  end

  def show
    return render plain: '404' unless @url = Url.find_by(short_url: params[:url])
    # implement queries
    daily_click_hash = {}
    @daily_clicks = @url.clicks.current_month.group_by{|a| a.created_at.strftime("%d")}.map {|k, v| daily_click_hash[k] = v.count}
    @daily_clicks = daily_click_hash.to_a.sort
    @browsers_clicks = @url.clicks.pluck_tally(:browser)
    @platform_clicks = @url.clicks.pluck_tally(:platform)
  end

  def visit
    # redirect to the original URL
    @url = Url.find_by(short_url: params[:short_url])
    # binding.pry
    if @url.present?
      @url.update_clicks
      @url.clicks.create(browser: browser.name, platform: browser.platform.name)
      render plain: @url.original_url
    else
      render plain: '404'
    end
  end

  def last_10_urls
    @urls = Url.includes(:clicks).order(created_at: :desc).limit(10)
    render json: @urls
  end

  private
  def url_params
    params.require(:url).permit(:original_url)
  end
end

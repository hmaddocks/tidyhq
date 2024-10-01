# frozen_string_literal: true

class UrlsController < ApplicationController
  # GET /urls or /urls.json
  def index
    @urls = Url.all
  end

  def show
    case params[:id]
    when /\d+/
      @url = Url.find(params[:id])
    when /[a-zA-Z0-9]+/
      url = Url.find_by(short_url: params[:id])
      redirect_to url.original_url, allow_other_host: true, target: '_blank'
    end
  end

  def new
    @url = Url.new
  end

  # POST /urls or /urls.json
  def create
    @url = Url.new(url_params) do |u|
      u.short_url = MicroToken.generate(8, :alpha)
    end

    respond_to do |format|
      if @url.save
        format.html { redirect_to @url, notice: "Url was successfully created." }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    url = Url.find(params[:id])
    url.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other, notice: "Url was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def url_params
    params.require(:url).permit(:long_url)
  end
end

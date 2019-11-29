class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_back(fallback_location: root_path)
    else
      render 'users/new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def tag_params
    params.require(:tag).permit(:body)
  end
end

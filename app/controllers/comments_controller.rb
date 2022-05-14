# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_commentable, only: %i[create destroy edit update]
  before_action :find_comment, only: %i[edit destroy update]

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save!
      redirect_to @commentable
    else
      render_commentable(@commentable)
    end
  end

  def destroy
    @comment.destroy!
    redirect_to @commentable
  end

  def edit
    render_commentable(@commentable)
  end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable
    else
      render_commentable(@commentable)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id)
  end

  def find_commentable
    if params[:book_id]
      @commentable = Book.find(params[:book_id])
    elsif params[:report_id]
      @commentable = Report.find(params[:report_id])
    end
  end

  def find_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def render_commentable(commentable)
    if commentable.instance_of?(Book)
      @book = commentable
      @comments = @book.comments
      render 'books/show'
    elsif commentable.instance_of?(Report)
      @report = commentable
      @comments = @report.comments
      render 'reports/show'
    end
  end
end

# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_commentable, only: %i[create destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save!
      redirect_to @commentable
    else
      render_error(@commentable)
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy!
    redirect_to @commentable
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

  def render_error(commentable)
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

module Api
  module V1
    class PostsController < ApplicationController

      def index
        posts = Post.all

        render :status => :ok,
          :json => {
            :posts => posts
          }
      end

      def show
        post = Post.where(id: params[:id])

        status = :ok
        if post.blank?
          status = :not_found
        end

        render :status => status,
          :json => {
            :post => post
          }
      end

      def create
        post = Post.new(post_params)

        if post.save
          status = :ok
        else
          status = :bad_request
        end

        render :status => status,
          :json => {
            :post => post
          }
      end

      def update
        status = :ok

        post = Post.where(id: params[:id])[0]

        if post.present?
          status = post.update(post_params) ? :ok : :bad_request
        else
          status = :bad_request
        end

        render :status => status,
          :json => {
            post: post
          }
      end

      def destroy
        status = :ok

        success = Post.destroy(params[:id])

        status = :bad_request if !success

        render :status => status,
          :json => {}
      end

      private

      def post_params
        params.require(:post).permit(:title, :body)
      end
    end
  end
end

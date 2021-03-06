class Pages::PostsController < ApplicationController
  def show
    
    @post = Post.find_by_code(params[:id])
    @restaurant = Restaurant.find(@post.restaurant_id)
  end

  def new
	 @post = Post.new
	 @restaurant = Restaurant.new
  end

  def edit
    @post = Post.find_by_code(params[:id])
    
  end

  def index
    @posts = Post.where(:user_id => current_user.id) # need to change to only for current_user

    #parsing the geolocation and content for infobox
    @hash = Gmaps4rails.build_markers(@posts) do |post, marker|
      post_path = view_context.link_to post.title, pages_post_path(post)
      marker.lat post.latitude
      marker.lng post.longitude
      marker.title post.title
      marker.infowindow "<b>#{post_path}</b><p>#{post.text}</p>"
    end
  end

  

  def create

    @post = Post.new(post_params)
    @post.user_id = current_user.id;
    @post.code = SecureRandom.hex(3);
    #@restaurant = @post.restaurant.build(params[:restaurant])
    if(!@post.save)
      flash[:notice] = "Invalid Image Files: Only jpeg, jpg, gif, and png Allowed"
      redirect_to pages_posts_path
    else
      @restaurant = Restaurant.new(rest_params)
      @restaurant.post_id = @post.id
      @restaurant.address = @post.address
      @restaurant.save #restaurant now has id
      @post_update = Post.find(@post.id)
      @post_update.update(restaurant_id: @restaurant.id)
      redirect_to url: pages_posts_path
    end #post now has id
  end

  def update
	@post = Post.find_by_code(params[:id])
        @restaurant = Restaurant.where(:post_id => @post.id)
	if @post.update(post_params)
		@restaurant.update(rest_params)
		redirect_to pages_post_path
	else
	   	render 'edit'
	end
  end

  private
    def post_params

      params.require(:post).permit(:title, :text, :address, {image: []})
    end

    def rest_params
      params.require(:restaurant).permit(:name, :phone, :weblink, :rating)
    end
end

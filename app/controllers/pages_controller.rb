class PagesController < ApplicationController


  def findfriend
    $add_button = false
    @friendemail = params['my_input']

    if(User.find_by_email(@friendemail))
      $friend = @friendemail
      $add_button = true
      respond_to do |format|
      format.js {render inline: "location.reload();" }
      format.html { redirect_to :back, notice: 'User is successfully FOUND.' }
      format.json { head :no_content }
    end
    else
      redirect_to :back, :notice=> "The user you are looking for did NOT Found!"
    end
  end

  def resetbutton
    $add_button = false
    redirect_to home_path
  end

  def index
  end

  def welcome
  end

  def signup
  end

  def home
    following = Array.new
    for @f in current_user.following do
      following.push(@f.id)
    end

    @friends = User.where("id IN (?)", following)

    @posts = Post.where("user_id IN (?)", following)
    @newPost = Post.new

    # parsing the geolocation and content for infobox
    @hash = Gmaps4rails.build_markers(@posts) do |post, marker|
      post_path = view_context.link_to post.title, pages_post_path(post)
      marker.lat post.latitude
      marker.lng post.longitude
      marker.title post.title
      marker.infowindow "<b>#{post_path}</b><p>#{post.text}</p>"
    end
  end

  def posts
  end

  def profile
  end

  def new
  end

  def recommend

  end
  def update
  end

  def foodmap

    following = Array.new
    for @f in current_user.following do
      following.push(@f.id)
    end

    # only friend's posts
    @posts = Post.where("user_id IN (?)", following)

    #parsing the geolocation and content for infobox
    @hash = Gmaps4rails.build_markers(@posts) do |post, marker|
      post_path = view_context.link_to post.title, pages_post_path(post)
      marker.lat post.latitude
      marker.lng post.longitude
      marker.title post.title
      marker.infowindow "<b>#{post_path}</b><p>#{post.text}</p>"
    end

  end

end

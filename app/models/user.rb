class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

         has_many :posts, dependent: :destroy # remove a user's posts if his account is deleted.
         has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

         has_many :following, through: :active_relationships, source: :followed
         has_many :followers, through: :passive_relationships, source: :follower

         # helper methods

         # follow another user
         def add_friend(other)
         	active_relationships.create(followed_id: other.id)
         end

         # unfollow a user
         def remove_friend(other)
         	active_relationships.find_by(followed_id: other.id).destroy
         end

         # is following a user?
         def is_friend?(other)
         	following.include?(other)
         end

         #email confirmation option
         #protected
         #def confirmation_required?
          #  false
        #end
end

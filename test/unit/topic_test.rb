require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  
  fixtures :topics
  fixtures :posts 
  
  def setup
    @first_topic = topics(:first)
    @second_topic = topics(:second)
    @third_topic = topics(:third)
    
    @eat_post = posts(:eat)
    @hellou_post = posts(:hellou)
    @digest_post = posts(:digest)
  end
  
  test "initialization" do
    assert_equal @first_topic.posts.size, 3
  end
  
  test "last post" do
    assert_equal @eat_post, @first_topic.last_post
    assert_equal @digest_post, @second_topic.last_post
    assert_equal @hellou_post, @third_topic.last_post
  end
  
  test "sorting of topics" do
    sorted_topics = Topic.sort_topics([@first_topic, @third_topic, @second_topic])
    assert_equal @second_topic, sorted_topics[0]
    assert_equal @first_topic, sorted_topics[1]
    assert_equal @third_topic, sorted_topics[2] 
  end
end

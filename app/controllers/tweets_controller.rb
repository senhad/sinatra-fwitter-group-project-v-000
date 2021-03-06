class TweetsController < ApplicationController 

get '/tweets/new' do
	if logged_in?
		erb :'tweets/create_tweet'
	else 
		redirect '/login'
	end
end 

post '/tweets' do 
	# binding.pry
	@tweet = current_user.tweets.build(content: params[:content])
	if @tweet.save 
		redirect "/tweets"
	else 
		redirect '/tweets/new'
	end 

end 

get '/tweets' do 
	if logged_in?
		erb :'tweets/tweets'
	else 
		redirect '/login'
	end 
end 

get '/tweets/:id' do 
	@tweet = Tweet.find_by(params[:id])
	if logged_in? && @tweet.user_id == current_user.id
		erb :'tweets/show_tweet'
	else 
		redirect '/login'
	end 
end 

get '/tweets/:id/edit' do 
	@tweet = Tweet.find_by_id(params[:id])
	if logged_in? && @tweet.user_id == current_user.id
		erb :'tweets/edit_tweet'
	else 
		redirect '/login'
	end 
end 

patch '/tweets/:id' do 
	@tweet = current_user.tweets.find_by_id(params[:id])
	if params[:content] == ""
		redirect "/tweets/#{@tweet.id}/edit"
	else 
		@tweet.content = params[:content]
		@tweet.save
		redirect "/tweets/#{@tweet.id}"
	end 
end 

delete '/tweets/:id/delete' do
	@tweet = Tweet.find_by_id(params[:id])
	if logged_in? && @tweet.user_id == current_user.id	
		@tweet.delete
		redirect to '/tweets'
	else 
		redirect '/login'
	end 
end 


end 
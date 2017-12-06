# simple todolist app with sinatra and vue.js
require 'sinatra'
require 'json'

tasks = {}
counter = 0

get '/' do
  send_file 'index.html'
end

get '/tasks' do
    tasks.to_json
end

post '/task' do
    data = JSON.parse(request.body.read)
    name = data['name']
    id = counter
    tasks[id] = name
    counter += 1
    {'created': id}.to_json
end

delete '/tasks/:id' do
    id = params['id'].to_i
    tasks.delete(id)
    'Deleted'
end

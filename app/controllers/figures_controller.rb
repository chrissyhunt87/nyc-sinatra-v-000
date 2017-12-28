class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  post '/figures' do
    new_figure = Figure.create(name: params[:figure][:name])

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each {|landmark_id| new_figure.landmarks << Landmark.find_by(id: landmark_id)}
    end

    if params[:landmark][:name]
      new_figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    if params[:figure][:title_ids]
      params[:figure][:title_ids].each {|title_id| new_figure.titles << Title.find_by(id: title_id)}
    end

    if params[:title][:name]
      new_figure.titles << Title.create(name: params[:title][:name])
    end

    new_figure.save
    redirect '/figures'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/show'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @figure.name = params[:figure][:name]
    @figure.landmarks.clear
    @figure.titles.clear

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each {|landmark_id| @figure.landmarks << Landmark.find_by(id: landmark_id)}
    end

    if params[:landmark][:name]
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    if params[:figure][:title_ids]
      params[:figure][:title_ids].each {|title_id| @figure.titles << Title.find_by(id: title_id)}
    end

    if params[:title][:name]
      @figure.titles << Title.create(name: params[:title][:name])
    end

    @figure.save

    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

end

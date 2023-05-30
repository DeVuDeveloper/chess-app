class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :update, :destroy]
  
    def index
      @games = Game.ordered
    end
  
    def show
    end
  
    def new
      @game = Game.new
    end
  
    def create
      @game = Game.new(game_params)
  
      if @game.save
        respond_to do |format|
          format.html { redirect_to games_path, notice: "Game was successfully created." }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
      if @game.update(game_params)
        redirect_to games_path, notice: "Game was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @game.destroy
      respond_to do |format|
        format.html { redirect_to games_path, notice: "Game was successfully destroyed." }
        format.turbo_stream
      end
    end
  
    private
  
    def set_game
      @game = Game.find(params[:id])
    end
  
    def game_params
      params.require(:game).permit(:name)
    end
  end
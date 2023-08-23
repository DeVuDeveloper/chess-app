class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :update, :destroy]
  
    def index
      @unmatched_games = Game.where(:white_player_user_id => nil).where.not(:black_player_user_id => nil).or (Game.where.not(:white_player_user_id => nil).where(:black_player_user_id => nil))
    end
  
    def show
    end
  
    def new
      @game = Game.new
    end
  
    def create
      @game = current_user.games.create(game_params)
  
      if @game.save
        respond_to do |format|
          format.html { redirect_to game_path(@game), notice: "Game was successfully created." }
          format.turbo_stream
        end
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
      params.require(:game).permit(:white_player_user_id, :black_player_user_id, :winner_user_id, :loser_user_id, :turn_user_id, :email)
    end
  end
class GamesController < ApplicationController
  before_action :set_game, only: %i[edit update destroy]
  before_action :authenticate_user!
  include ColorConcerns

  def index
    @users = User.all
    @games = Game.includes(:user_games).all
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def create
    assign_colors
    @game = Game.new(turn: :white, state: :in_progress, white_player_id: params[:game][:white_player_id])

    respond_to do |format|
      if @game.save
        # Inside the controller's create action after the game is saved
        UserGame.create(game: @game, user: current_user, joined: true)

        format.html { redirect_to game_url(@game), notice: 'Game was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: 'Game was successfully updated.' }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game.destroy
      respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.turbo_stream
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:challenger_id)
  end
end

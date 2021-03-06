class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.order('created_at DESC').limit(10)
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new
    @game.user_id = params[:user_id]
    @game.num_wrong_guesses_remaining = Game.MAX_NUM_WRONG_GUESSES
    @game.set_word(params[:selected_word_source])

    respond_to do |format|

      if @game.save
        format.html { redirect_to @game }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update

    @game.process_guess(params[:guess])
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game}
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    respond_to do |format|
      format.html { redirect_to games_url, alert: 'You are not allowed to delete games.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.permit(:selected_word_source, :id, :user_id, :guess, :authenticity_token, :_method)
    end
end
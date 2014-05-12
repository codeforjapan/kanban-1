module Api
  class CardsController < ApplicationController
    respond_to :json

    def index
      @cards = current_user.cards
    end

    def show
      @card = current_user.cards.find(params[:id])
    end

    def create
    	card = Card.new(params[:card])
    	if card.save
    		render json: card, status: :ok
    	else
    		render nothing: true, status: :unprocessable_entity
    	end
    end

    def update
    	card = current_user.cards.find(params[:id])
    	if card.update_attributes(params[:card])
        render json: card, status: :ok
      else
        render nothing: true, status: :unprocessable_entity
      end
    end

    def destroy
      card = current_user.cards.find(params[:id])
			if card.destroy
				render json: card, status: :ok
			else
				render nothing: true, status: :unprocessable_entity
			end
    end

    def sort
      # I get the list id for  the cards on the list,
      @list = List.find(params[:list_id])
      
      # I get card id of params
       card_ids = params[:card].map(&:to_i)
      #card_id_counts = params[:card].map { |i| { i.id => i.comments_count } } 
      # unless (card_ids - current_user.card_ids).empty?
      #   render nothing: true, status: :unauthorized
      # end

      # I will perform it to all the cards table when id matchs.
      # Actually, I will update position and list_id
      card_ids.each_with_index do |id, index|
        Card.update_all({ position: index,  list_id: @list.id },
                        { id: id })
      end
      #pos = 1
      #cards_id_counts.sort_by!{ |k,v| v }
      #cards_id_counts.each {| k, v| 
      #	 Card.update_all( { position: pos , list_id: @list.id },{ id: k } )
      #   pos = pos + 1	
      #}

      @cards = @list.cards.where(id: card_ids)
    end

  end
end

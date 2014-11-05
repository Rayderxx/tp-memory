cards = [
	{
		id: 1,
		image: 'memory01.png'
	},
	{
		id: 2,
		image: 'memory02.png'
	},
	{
		id:3,
		image: 'memory03.png'
	},
	{
		id:4,
		image: 'memory04.png'
	},
	{
		id:5,
		image: 'memory05.png'
	},
	{
		id:6,
		image: 'memory06.png'
	}
]

(($) ->
	class Card
		id: null
		image: null
		constructor: (id, image) ->
			@id = id
			@image = image

	class Memory
		cards: []
		isCheckable: false
		currentCard: null
		constructor: () ->
			@init()

		init: () ->
			self = @
			for card in cards
				do(card) ->
					self.cards.push(new Card(card.id, card.image))
					self.cards.push(new Card(card.id, card.image))
			@randomCards()

		randomCards: () ->
			@cards = _.shuffle(@cards);

		displayCards: () ->
			for card in @cards
				do(card) ->
					$ -> $("#card").append('<div data-id="'+card.id+'" class="card"><div class="card-hide"></div><img src="img/'+card.image+'"></div>')
		

		isPair: (id) ->
			@isCheckable = false
			if @currentCard.id == id
				true
			else
				false

		setCard: (id) ->
			card = _.first(_.where(@cards, {id: id}));
			if card.id
				@currentCard = card
				@isCheckable = true





	memory = new Memory()
	memory.displayCards();

	$ -> $(".card").on "click", ->
		$(this).find('.card-hide').hide();
		id = $(this).data('id')

		if memory.isCheckable
			result = memory.isPair(id)
			if result
				$ -> $(this).find('.card-hide').show()
				$ -> $(".card[data-id='"+memory.currentCard.id+"']").find('.card-hide').show()
			
			memory.currentCard = null;
		else
			memory.setCard(id)

) jQuery
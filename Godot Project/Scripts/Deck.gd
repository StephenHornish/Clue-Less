extends Node

class_name Deck

enum CardType{
	CHARACTER,
	ROOM, 
	WEAPON
}

var Card = load("res://Scripts/Card.gd")

var secretEnvelop = []
var deck = []

func _init():
	deck.append(Card.new("Miss Scarlett", CardType.CHARACTER))
	deck.append(Card.new("Mrs Peacock", CardType.CHARACTER))
	deck.append(Card.new("Mrs White", CardType.CHARACTER))
	deck.append(Card.new("Prof Plumb", CardType.CHARACTER))
	deck.append(Card.new("Mr Green", CardType.CHARACTER))
	deck.append(Card.new("Col Mustard", CardType.CHARACTER))
	deck.append(Card.new("Hall", CardType.ROOM))
	deck.append(Card.new("Lounge", CardType.ROOM))
	deck.append(Card.new("Dining Room", CardType.ROOM))
	deck.append(Card.new("Kitchen", CardType.ROOM))
	deck.append(Card.new("Ballroom", CardType.ROOM))
	deck.append(Card.new("Conservatory", CardType.ROOM))
	deck.append(Card.new("Billiards Room", CardType.ROOM))
	deck.append(Card.new("Library", CardType.ROOM))
	deck.append(Card.new("Study", CardType.ROOM))
	deck.append(Card.new("CandleStick", CardType.WEAPON))
	deck.append(Card.new("Pipe", CardType.WEAPON))
	deck.append(Card.new("Pistol", CardType.WEAPON))
	deck.append(Card.new("Wrench", CardType.WEAPON))
	deck.append(Card.new("Rope", CardType.WEAPON))
	deck.append(Card.new("Knife", CardType.WEAPON))
	randomize()
	deck.shuffle()
	_createSecretDeck()
	#print(secretEnvelop)

#picks the three game winning cards and removes them from the rest of the deck
func _createSecretDeck()->void:
	var a 
	var b 
	var c 
	var counter = 0
	for x in deck :
		#print(x.get_type())
		if(x.get_type() == 0 && a == null):
			a = x 
			deck.remove(counter)
		if(x.get_type() == 1 && b ==null ):
			b = x
			deck.remove(counter)
		if(x.get_type() == 2 && c ==null ):
			c = x 
			deck.remove(counter)
		counter += 1 
	secretEnvelop.append(a)
	secretEnvelop.append(b)
	secretEnvelop.append(c)


func _to_string()->String:
	var printOut = ""
	for x in deck:
		printOut = printOut + ", " + str(x)
	return printOut

func checkWinner(accusation):
	return (accusation.has(secretEnvelop[0].get_name()) && accusation.has(secretEnvelop[1].get_name()) && accusation.has(secretEnvelop[2].get_name()))


func buildDeck(MasterDeckCardName : Array, MasterDeckCardType :Array,SecretDeckCardName : Array, SecretDeckCardType: Array):
	var _deck = []
	var _secretEnvelop = []
	for i in range(MasterDeckCardName.size()):
		_deck.append(Card.new(MasterDeckCardName[i],MasterDeckCardType[i]))
	for i in range(SecretDeckCardName.size()):
		_secretEnvelop.append(Card.new(SecretDeckCardName[i],SecretDeckCardType[i]))
	deck = _deck
	secretEnvelop = _secretEnvelop
		
func buildHand(MasterHandCardName : Array, MasterHandCardType : Array): 
	var _hand = [] 
	for i in range(MasterHandCardName.size()):
		_hand.append(Card.new(MasterHandCardName[i],MasterHandCardType[i]))
	return _hand

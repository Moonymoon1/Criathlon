extends Node

# Esse script deve ser um AUTOLOAD (singleton global) chamado "GameState".
# Assim, qualquer cena do jogo consegue ler/mudar o dia atual.

var dia_atual: int = 1

func avancar_dia() -> void:
	dia_atual += 1
	print("Agora é o dia ", dia_atual)

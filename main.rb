#Cargar partida o empezar de cero
#En cada ronda está la posibilidad de guardar o de jugar
#Cada ronda es de un jugador (blancas o negras)
#Después de cada movimiento se chequea si hay un ganador/tablas/softlock

require "yaml"
require "colorize"
require 'pry'
require "./game.rb"

class Game
end

a = Game.new("e").start_game
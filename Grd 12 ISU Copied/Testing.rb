require 'gosu'
#change Block_two's image to look more like block_one
#make a player move
#Make background whole size
#inclued collisions
#use main menu class
#create a game lost screen
#make player cutout not have black shit


class Main < Gosu::Window

  def initialize(width=800, height= 600, fullscreen=false)
    super
    self.caption = 'Dodge The Blocks'
    @blockX = []
    @blockY = []
    @blockOne = Gosu::Image.new('Block1.png')# :tileable => true)
    @blockTwo = Gosu::Image.new('Block2.png')# :tileable => true)
    @blockThree = Gosu::Image.new('Block3.png')
    @blockFour = Gosu::Image.new('Block4.png')

    @player = Gosu::Image.new('Player2.png')# :tileable => true)
    @loseGameBackground = Gosu::Image.new('background.jpg', :tileable => true)

    @x_player = 0
    @y_player = 0

    @xFactorBackground = self.width/@loseGameBackground.width * 1.45
    @yFactorBackground = self.height/@loseGameBackground.height * 1.25

  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def update


    #This will move the character left when left button is down unless the character is out of the screen
    @x_player -= 4 if Gosu::button_down? Gosu::KbLeft and @x_player > 0
    #Move the player right if the character is not touching the right edge of the screen
    @x_player += 4 if Gosu::button_down? Gosu::KbRight and @x_player < self.width - @player.width
    #Move the player up if the player is not touching the top of the screen
    @y_player -= 4 if Gosu::button_down? Gosu::KbUp and @y_player > 0
    #Moves the player down if the player is not touching the bottom of the screen
    @y_player += 4 if Gosu::button_down? Gosu::KbDown and @y_player < self.height - @player.height



  end

  def draw
    @loseGameBackground.draw(0,0,0, @xFactorBackground, @yFactorBackground)
    @player.draw(@x_player,@y_player, 0)
  end

end
Main.new.show
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
    @Block_one = Gosu::Image.new('Block1.png')# :tileable => true)
    @Block_two = Gosu::Image.new('Block2.png')# :tileable => true)
    @player = Gosu::Image.new('Player.png')# :tileable => true)
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

    @x_Block_one = self.width/2 - @Block_one.width/2 + (Math.sin(Time.now.to_f)*200)
    @y_Block_one = self.height/2 - @Block_one.height/2 + 25 + Math.cos(Time.now.to_f)*150

    @x_Block_two = self.width/2 - @Block_two.width/2 + (Math.sin(Time.now.to_f)*300)
    @y_Block_two = 10


    #This will move the character left when left button is down unless the character is out of the screen
    @x_player -= 10 if Gosu::button_down? Gosu::KbLeft and @x_player > 0
    #Move the player right if the character is not touching the right edge of the screen
    @x_player += 10 if Gosu::button_down? Gosu::KbRight and @x_player < self.width - @player.width
    #Move the player up if the player is not touching the top of the screen
    @y_player -= 10 if Gosu::button_down? Gosu::KbUp and @y_player > 0
    #Moves the player down if the player is not touching the bottom of the screen
    @y_player += 10 if Gosu::button_down? Gosu::KbDown and @y_player < self.height - @player.height

   if @player_x == @x_Block_one
     close
   end


  end

  def draw
    @loseGameBackground.draw(0,0,0, @xFactorBackground, @yFactorBackground)
    @Block_one.draw(@x_Block_one, @y_Block_one, 0)
    @Block_two.draw(@x_Block_two, @y_Block_two, 0)
    @player.draw(@x_player,@y_player, 0)
  end

end
Main.new.show

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

    @blockX[1] = 100 #self.width/2 - @blockOne.width/2 + (Math.sin(Time.now.to_f)*200)
    @blockY[1] = 100 #self.height/2 - @blockOne.height/2 + 25 + Math.cos(Time.now.to_f)*150

    @blockX[2] = self.width/2 - @blockTwo.width/2 + (Math.sin(Time.now.to_f)*300)
    @blockY[2] = 10

    @blockX[3] = 0
    @blockY[3] = 250 + Math.cos(Time.now.to_f)*250

    @blockX[4] = self.width - @blockFour.width - 15
    @blockY[4] = 200 - Math.cos(Time.now.to_f)*375
    #This makes it so the fourth's block Y cord. cannot be above the screen
    if @blockY[4] < 0
      @blockY[4] = 0
    end
    #This makes it so the fourth's block Y cord. cannot be below the screen
    if @blockY[4] > self.height - @blockFour.height
      @blockY[4] = self.height - @blockFour.height
    end

    #This will move the character left when left button is down unless the character is out of the screen
    @x_player -= 4 if Gosu::button_down? Gosu::KbLeft and @x_player > 0
    #Move the player right if the character is not touching the right edge of the screen
    @x_player += 4 if Gosu::button_down? Gosu::KbRight and @x_player < self.width - @player.width
    #Move the player up if the player is not touching the top of the screen
    @y_player -= 4 if Gosu::button_down? Gosu::KbUp and @y_player > 0
    #Moves the player down if the player is not touching the bottom of the screen
    @y_player += 4 if Gosu::button_down? Gosu::KbDown and @y_player < self.height - @player.height


    #collisions
    #
    if @x_player <= @blockX[1] + @blockOne.width && @x_player + @player.width >= @blockX[1] && @y_player <= @blockY[1] + @blockOne.height && @y_player + @player.height >= @blockY[1]
      close
    end



    #if (player.Bottom > block.Top && player.Top < block.Bottom && player.Left < block.Right && player.Right > block.Left)
    #if @player.bottom > BlockOne.Top and player.Top < BlockOne.bottom and player.left < BlockOne.right and player.right > block.left
    #  close
    #end


  end

  def draw
    @loseGameBackground.draw(0,0,0, @xFactorBackground, @yFactorBackground)
    @blockOne.draw(@blockX[1], @blockY[1], 0)
    @blockTwo.draw(@blockX[2], @blockY[2], 0)
    @blockThree.draw(@blockX[3], @blockY[3], 0)
    @blockFour.draw(@blockX[4], @blockY[4], 0)

    @player.draw(@x_player,@y_player, 0)
  end

end
Main.new.show
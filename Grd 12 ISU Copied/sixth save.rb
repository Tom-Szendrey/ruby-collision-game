require 'gosu'
#button

class Main < Gosu::Window

  def initialize(width=800, height= 600, fullscreen=false)
    super
    self.caption = 'Dodge the Asteroids, get the satellites'
    #For volume
    #@collectNoise = Gosu::Song.new(self, 'Collect.wav')

    #for Win game menu
    @winBackground = Gosu::Image.new('WinBackground.png')
    #@winningText = Gosu::Image.from_text(self, 'YOU HAVE WON THIS GAME
#... cheater', Gosu.default_font_name, 50)
    #for Menu
    @mainText = Gosu::Image.from_text self, 'Main Menu
Click C to continue', Gosu.default_font_name, 50
    @backgroundImage = Gosu::Image.new('Menu Background.jpg', :tileable => true)
    @mainIntructions = Gosu::Image.from_text self, 'Dodge Asteroids, get Satellites, last until 9001 points
W,A,S,D to move
Click G to win', Gosu.default_font_name, 25
    @menuX = self.width/2 -@mainText.width/2
    @menuY = self.height/2 - @mainText.height/2
    @gameStart = 0


    #for losing menu
    @losingText = Gosu::Image.from_text self, 'You Have Lost', Gosu.default_font_name, 100
    @losingIntructions = Gosu::Image.from_text self, 'Press C to Continue
press R to Restart', Gosu.default_font_name, 25
    @loseGameBackground = Gosu::Image.new('GameOver.png', :tileable => true)
    @xLosingBackground = self.width/@loseGameBackground.width * 3
    @yLosingBackground = self.height/@loseGameBackground.height * 3


    #Blocks
    @blockX = []
    @blockY = []
    @blockOne = Gosu::Image.new('Block1.png')# :tileable => true)
    @blockTwo = Gosu::Image.new('Block2.png')# :tileable => true)
    @blockThree = Gosu::Image.new('Block3.png')
    @blockFour = Gosu::Image.new('Block4.png')
    @blockFive = Gosu::Image.new('Block5.png')
    #Player
    @player = Gosu::Image.new('teemo.png')# :tileable => true)
    @x_player = 0
    @y_player = 0
    #Background
    @gameBackground = Gosu::Image.new('SpaceBackground.png', :tileable => true)
    @xFactorBackground = self.width/@gameBackground.width * 1.45
    @yFactorBackground = self.height/@gameBackground.height * 2.5
    #For text
    @scoreMessage = Gosu::Image.from_text self, 'Score: ', Gosu.default_font_name, 25
    @timeMessage = Gosu::Image.from_text self, 'Time: ', Gosu.default_font_name, 25
    #For coins
    @coinCount = -1
    @coin = Gosu::Image.new('Coin.png')
    @coinX = 0
    @coinY = 0

    @difficultyTimer = 0
    @secondTimer = 0
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def update
    #God mode
    @coinCount = 9001 if Gosu::button_down? Gosu::KbG


    #Timer
    @timer = Gosu.milliseconds/1000
    @textOfTimer = Gosu::Image.from_text self, @timer, Gosu.default_font_name, 25

    if @gameStart == 0
      @difficultyTimer = 0
    end


    if @timer % 5 == 0 and @timer != @secondTimer and @difficultyTimer <= 200
      @secondTimer = @timer
      @difficultyTimer += 100
      puts @difficultyTimer

    end

    #For score
    @score = @coinCount * 750
    @scoreText =  Gosu::Image.from_text self, @score, Gosu.default_font_name, 25

    @blockX[1] = self.width/2 - @blockOne.width/2 + (Math.sin(Time.now.to_f)*(200 + @difficultyTimer))
    @blockY[1] = self.height/2 - @blockOne.height/2 + 25 + Math.cos(Time.now.to_f)*(200)
    #Block one cannot go outside screen
    if @blockX[1] < 0
      @blockX[1] = 0
    end
    if @blockX[1] > self.width - @blockOne.width
      @blockX[1] = self.width - @blockOne.width
    end
    if @blockY[1] < 0
      @blockY[1] = 0
    end
    if @blockY[1] > self.height - @blockOne.height
      @blockY[1] =  self.height - @blockOne.height
    end

    #block 2
    @blockX[2] = self.width/2 - (Math.sin(Time.now.to_f)*(100+ @difficultyTimer))
    @blockY[2] = 10
    #Block one cannot go outside screen
    if @blockX[2] < 50
      @blockX[2] = 50
    end
    if @blockX[2] > self.width - @blockTwo.width
      @blockX[2] = self.width - @blockTwo.width
    end
    if @blockY[2] < 0
      @blockY[2] = 0
    end
    if @blockY[2] > self.height - @blockTwo.height
      @blockY[2] =  self.height - @blockTwo.height
    end

    #block 3
    @blockX[3] = 0
    @blockY[3] = 250 + Math.cos(Time.now.to_f)*500
    #Block one cannot go outside screen
    if @blockX[3] < 0
      @blockX[3] = 0
    end
    if @blockX[3] > self.width - @blockThree.width
      @blockX[3] = self.width - @blockThree.width
    end
    if @blockY[3] < 50
      @blockY[3] = 50
    end
    if @blockY[3] > self.height - @blockThree.height
      @blockY[3] =  self.height - @blockThree.height
    end


    #block 4
    @blockX[4] = self.width - @blockFour.width - 15
    @blockY[4] = 200 - Math.cos(Time.now.to_f)*(375 + @difficultyTimer)
    #Block one cannot go outside screen
    if @blockX[4] < 0
      @blockX[4] = 0
    end
    if @blockX[4] > self.width - @blockFour.width
      @blockX[4] = self.width - @blockFour.width
    end
    if @blockY[4] < 0
      @blockY[4] = 0
    end
    if @blockY[4] > self.height - @blockFour.height
      @blockY[4] =  self.height - @blockFour.height
    end

    #block 5
    @blockX[5] = self.width/2 - @blockFive.width/2 + (Math.sin(Time.now.to_f)*(900+ @difficultyTimer))
    @blockY[5] = self.height/2 - @blockFive.height/2
    #Block one cannot go outside screen
    if @blockX[5] < 0
      @blockX[5] = 0
    end
    if @blockX[5] > self.width - @blockFive.width
      @blockX[5] = self.width - @blockFive.width
    end
    if @blockY[5] < 0
      @blockY[5] = 0
    end
    if @blockY[5] > self.height - @blockFive.height
      @blockY[5] =  self.height - @blockFive.height
    end


    #Player movement

    #This will move the character left when left button is down unless the character is out of the screen
    #@x_player -= 4 if Gosu::button_down? Gosu::KbLeft and @x_player > 0
    @x_player -= 4 if Gosu::button_down? Gosu::KbA and @x_player > 0
    #Move the player right if the character is not touching the right edge of the screen
    #@x_player += 4 if Gosu::button_down? Gosu::KbRight and @x_player < self.width - @player.width
    @x_player += 4 if Gosu::button_down? Gosu::KbD and @x_player < self.width - @player.width
    #Move the player up if the player is not touching the top of the screen
    #@y_player -= 4 if Gosu::button_down? Gosu::KbUp and @y_player > 0
    @y_player -= 4 if Gosu::button_down? Gosu::KbW and @y_player > 0
    #Moves the player down if the player is not touching the bottom of the screen
    #@y_player += 4 if Gosu::button_down? Gosu::KbDown and @y_player < self.height - @player.height
    @y_player += 4 if Gosu::button_down? Gosu::KbS and @y_player < self.height - @player.height

    #to start game
    if Gosu::button_down? Gosu::KbC
      @difficultyTimer = 0
      @coinCount = 0
      @x_player = 0
      @y_player = 0
      @gameStart = 1
    end


    #to reset to main menu
    if Gosu::button_down? Gosu::KbR
      @secondTimer = 0
      @difficultyTimer = 0
      @coinCount = 0
      @x_player = 0
      @y_player = 0
      @gameStart = 0
    end


    #collisions
    #Coin
    if @x_player <= @coinX + @coin.width && @x_player + @player.width >= @coinX && @y_player <= @coinY + @coin.height && @y_player + @player.height >= @coinY
      #@collectNoise.play
      @coinCount += 1
      #This makes the coin relocate
      @coinX = rand(self.width - @coin.width)
      @coinY = rand(self.height - @coin.height)
      @secondTimer = @timer
    end


    #For block one
    if @x_player <= @blockX[1] + @blockOne.width && @x_player + @player.width >= @blockX[1] && @y_player <= @blockY[1] + @blockOne.height && @y_player + @player.height >= @blockY[1]
      @gameStart = 3
    end

    #for block two
    if @x_player <= @blockX[2] + @blockTwo.width && @x_player + @player.width >= @blockX[2] && @y_player <= @blockY[2] + @blockTwo.height && @y_player + @player.height >= @blockY[2]
      @gameStart = 3
    end

    #For block three
    if @x_player <= @blockX[3] + @blockThree.width && @x_player + @player.width >= @blockX[3] && @y_player <= @blockY[3] + @blockThree.height && @y_player + @player.height >= @blockY[3]
      @gameStart = 3
    end

    #For block four
    if @x_player <= @blockX[4] + @blockFour.width && @x_player + @player.width >= @blockX[4] && @y_player <= @blockY[4] + @blockFour.height && @y_player + @player.height >= @blockY[4]
      @gameStart = 3
    end

    if @x_player <= @blockX[5] + @blockFive.width && @x_player + @player.width >= @blockX[5] && @y_player <= @blockY[5] + @blockFive.height && @y_player + @player.height >= @blockY[5]
      @gameStart = 3
    end

    #Win game
    if @score >= 9001
      @gameStart = 4
    end


    #end of update()
  end

  def draw
    #main menu
    if @gameStart == 0
      @backgroundImage.draw(0,0,0)
      @mainText.draw @menuY, @menuY, 0
      @mainIntructions.draw 0,0,0
    end


    #lose screen
    if @gameStart == 3
      @loseGameBackground.draw(0,0,0, @xLosingBackground, @yLosingBackground)
      @losingText.draw (self.width - @losingText.width)/2,(self.height - @losingText.height)/2,0
      @losingIntructions.draw (self.width - @losingIntructions.width)/2,(self.height - @losingIntructions.height)/2 + 100,0
    end


    #win screen
    if @gameStart == 4
      @winBackground.draw(0,0,0, @xFactorBackground-0.1, @yFactorBackground -0.5)
      #@winningText.draw (self.width - @winningText.width)/2,(self.height - @winningText.height)/2,0
      @losingIntructions.draw 0,0,0
    end

    #Game
    if @gameStart == 1
      @gameBackground.draw(0,0,0, @xFactorBackground, @yFactorBackground)
      @coin.draw(@coinX, @coinY, 0)

      @blockOne.draw(@blockX[1], @blockY[1], 0)
      @blockTwo.draw(@blockX[2], @blockY[2], 0)
      @blockThree.draw(@blockX[3], @blockY[3], 0)
      @blockFour.draw(@blockX[4], @blockY[4], 0)
      @blockFive.draw(@blockX[5], @blockY[5], 0)

      @scoreMessage.draw(self.width - @scoreMessage.width - @scoreText.width, 0 ,0)
      @scoreText.draw(self.width - @scoreText.width, 0 ,0)
      @player.draw(@x_player,@y_player, 0)
      @timeMessage.draw(self.width - @timeMessage.width - @textOfTimer.width , @scoreMessage.height, 0)
      @textOfTimer.draw(self.width - @textOfTimer.width, @scoreMessage.height, 0)
    end

  end

end
Main.new.show
require 'gosu'

class Main < Gosu::Window

  def initialize(width=800, height= 600, fullscreen=false)
    super
    self.caption = 'Dodge The Blocks'
    @losingText = Gosu::Image.from_text self, 'You Have Lost', Gosu.default_font_name, 100
    @losingIntructions = Gosu::Image.from_text self, 'Press C to Restart', Gosu.default_font_name, 25

    @loseGameBackground = Gosu::Image.new('GameOver.png', :tileable => true)
    @xFactorBackground = self.width/@loseGameBackground.width * 1.45
    @yFactorBackground = self.height/@loseGameBackground.height * 1.25



  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def update

    #call to the game function if Gosu::button_down? Gosu::KbC
  end

  def draw
    @loseGameBackground.draw(0,0,0, @xFactorBackground, @yFactorBackground)
    @losingText.draw (self.width - @losingText.width)/2,(self.height - @losingText.height)/2,0
    @losingIntructions.draw (self.width - @losingIntructions.width)/2,(self.height - @losingIntructions.height)/2 + 100,0
  end

end
Main.new.show

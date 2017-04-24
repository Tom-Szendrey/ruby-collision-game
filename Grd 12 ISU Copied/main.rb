require 'gosu'

class Main < Gosu::Window

  def initialize(width=800, height= 600, fullscreen=false)
    super
    self.caption = 'Dodge The Blocks'
    @losingText = Gosu::Image.from_text self, 'Main Menu
Click C to continue', Gosu.default_font_name, 75
    @backgroundImage = Gosu::Image.new('Menu Background.png', :tileable => true)
    @losingIntructions = Gosu::Image.from_text self, 'Dodge blocks, get coins, last until 9001 points
Use either w,a,s,d, or arrows to move', Gosu.default_font_name, 25
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def update

    #call to the game function if Gosu::button_down? Gosu::KbC
    @x = self.width/2 -@losingText.width/2#  + (Math.sin(Time.now.to_f)*50)
    @y = self.height/2 - @losingText.height/2#   + Math.cos(Time.now.to_f)*50
  end

  def draw
    @backgroundImage.draw(0,90,0)
    @losingText.draw @x, @y, 0
    @losingIntructions.draw 0,0,0
  end

end
Main.new.show

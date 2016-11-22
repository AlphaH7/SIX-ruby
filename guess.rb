
README = <<END
__DEVELOPMENT MODE__
Welcome to the guessing game. The computer will generate a six digit sequence (eg- ascdsd) and you have to guess 1 alphabet, each at a time. 
Guessing 6 alphabets gets you a "SIX" and a new sequence is generated.
So ready to test your luck quotient - 
    
END

Shoes.app :width => 600, :height => 300, :title => "SIX" do
  @score = 0
  @s_score = 0
  @seq_a = 1.times.map { [*'a'..'z'].sample }.join
  @six = Array.new
  style Shoes::Para,     :font => 'bold'
  style Shoes::Subtitle, :font => 'bold'

  background "#111".."#333", :height => 0.9
  background "#333", :top => 0.1, :height => 0.9

  def readme
    @result.clear do
      background '#ada', :height => 0.9
      border '#567', :strokewidth => 5 ,:height => 0.9
      para code(README), :margin => 7, :font => 'normal 12px'
    end
  end

  stack :margin => [10, 5, 5, 0] do
    background '#c8bad7'..'#762dc4'
    mask do
      flow do
        subtitle "SIX", :margin => 0
        para "A Guessing Game", :margin_top => 16
        button("Quit", :right => 10, :margin_top => 5) { quit }
      end
    end
  end

  stack :margin => [10, 0, 10, 10], :height => 0.82 do
    background "#eee", :curve => 12
    

    flow :margin => [10, 0, 10, 5] do
      stack :width => 0.5 do
        para "Test string:", :margin => 5
        @string = edit_line :width => 250,:margin => [10, 5, 10, 5],
                           :change => proc { update_result }
                         
        para link("RESET", :click => proc {reset}), :margin => [10, 5, 10, 5]     
        btn = button 'score' do
          alert("The total sequences you've guessed #{@s_score}") 
          end                  
        para "Game designed by Alistier X'ver ", :margin_top => 77, :font => 'normal 12px'
      end
      stack :width => 0.5 do
        para "Result:", :margin => 5
        @result = stack :margin => 5
      end
    end
    readme
  end


  def update_result
    reg_seq_a = /#{@seq_a}/
    unless @string.text.empty?
        @result.clear do
          begin
            Regexp.new(reg_seq_a) =~ @string.text
            res = if $~.nil? then nil else $~.dup end
            unless res.nil?
              formatted = [strong("Match: "), code(res[0])]
              res[1..-1].each_with_index do |capture, i|
                formatted << code("\n#{i+1}: #{capture}")
             end
             res = formatted
             @score += 1
             @six[@score] = @seq_a
             @seq_a = 1.times.map { [*'a'..'z'].sample }.join
             

            end
            background '#222'
            if res.nil?
              para "No matches", :stroke => '#efefef', :font => 'normal 12px'
              para "Try Again bro", :stroke => '#efefef', :font => 'normal 12px'
              para "Guess : #{@score}", :stroke => '#efefef', :font => 'normal 12px'
              if @score == 6
                para "You have HIT a SIX! bro", :stroke => 'efefef', :font => 'normal 12px'
                para "the sequence had the following alphabets", :stroke => '#efefef', :font => 'normal 12px'
                para "#{@six[1..-1]}", :stroke => '#efefef', :font => 'normal 12px'
               @six = Array.new
                @score = 0
                @s_score += 1
              else
                @rem = 6 - @score
                para "You almost there bro.", :stroke => 'efefef', :font => 'normal 12px' 
                para "Words left in the sequence : #{@rem}", :stroke => '#efefef', :font => 'normal 12px' 

              end
            else
              para res, :stroke => '#efefef', :font => 'normal 12px'
            end
          rescue => e
            @result.clear do
              background '#daa'
              border '#944', :strokewidth => 5
              para e.class, "\n", code(e), :margin => 7
            end
          end
        end
    else
      readme
    end
  end

  def reset
    @seq_a = 1.times.map { [*'a'..'z'].sample }.join
    @score = 0
    @s_score = 0
  end

end
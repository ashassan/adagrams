
require 'csv'

def draw_letters 
    letters_pool = [("A " * 9).split, ("B " * 2).split, ("C " * 2).split, ("D " * 4).split, 
        ("E " * 12).split, ("F " * 2).split, ("G " * 3).split, ("H " * 2).split, 
        ("I " * 9).split, ("J " * 1).split, ("K " * 1).split, ("L " * 4).split, ("M " * 2).split, 
        ("N " * 6).split, ("O " * 8).split, ("P " * 2).split, ("Q " * 1).split, ("R " * 6).split, 
        ("S " * 4).split, ("T " * 6).split, ("U " * 4).split, ("V " * 2).split, ("W " * 2).split, 
        ("X " * 1).split, ("Y " * 2).split, ("Z " * 1).split].flatten
        
        hand = letters_pool.sample(10)
        return hand 
    end 
    
    
    
    def uses_available_letters?(input, hand)
        hand_copy = hand.dup
        input.split('').each do |letters|
            if  hand_copy.include? (letters)
                hand_copy.slice!(hand_copy.index(letters))
            else 
                return false
            end
        end 
        
        
        return true 
    end  
    
    
    def score_word (input)
        
        score = { 
            1 => ["A","E","I","O","U","L","N","R","S","T"], 
            2 => ["D","G"], 
            3 => ["B","C","M","P"], 
            4 => ["F","H","V","W","Y"], 
            5 => ["K"], 
            8 => ["J","X"], 
            10 => ["Q","Z"]
        }
        total_points = 0 
        score.each do |points, letters|
            
            input.upcase.split("").each do |letter|
                if letters.include? (letter)
                    total_points += points
                    
                end 
                
            end 
            
        end 
        if input.length >= 7 
            total_points += 8 
        end 
        return total_points 
    end 
    
    
    def highest_score_from (words)
        
        highest_score = {}
        words.each do |word|
            highest_score[word] = score_word(word)
        end
        
        tie = {}
        
        highest_word = highest_score.max_by {|word, score| score}
        highest_score.each do |word, score|
            if score == highest_word[1] 
                tie[word] = score
            end 
        end 
        
        shortest_word = "xxxxxxxxxx"
        tie.keys.each do |word|
            if word.length == 10 
                shortest_word = word
                return {word: shortest_word, score: tie[shortest_word]}
            elsif word.length < shortest_word.length
                shortest_word = word
            end
            
        end
        
        return {word: shortest_word, score: tie[shortest_word]}
    end
    

    
    
    
    
    
    
    def is_in_english_dict? (input)
        table = CSV.read("../adagrams/assets/dictionary-english.csv")
        table.flatten!
        if table.include?(input.downcase)
            return true
        else
            return false
        end
        
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
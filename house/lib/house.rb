class OrderedPhrases
  DATA =
    [ ["the horse and the hound and the horn", "that belonged to"],
      ["the farmer sowing his corn", "that kept"],
      ["the rooster that crowed in the morn", "that woke"],
      ["the priest all shaven and shorn", "that married"],
      ["the man all tattered and torn", "that kissed"],
      ["the maiden all forlorn", "that milked"],
      ["the cow with the crumpled horn", "that tossed"],
      ["the dog", "that worried"],
      ["the cat", "that killed"],
      ["the rat", "that ate"],
      ["the malt", "that lay in"],
      ["the house", "that Jack built"]]
  attr_reader :list

  def initialize(orderer: UnchangedOrderer.new, data: DATA)
    @list = orderer.order(data)
  end

  def series(length)
    list.last(length).join(" ")
  end

  def size
    list.size
  end
end


class CumulativeTale
  attr_reader :phrases, :prefix

  def initialize(phrases: OrderedPhrases.new, prefixer: MundanePrefixer.new)
    @phrases = phrases
    @prefix = prefixer.prefix
  end

  def recite
    1.upto(phrases.size).collect {|i| line(i)}.join("\n")
  end

  def phrase(num)
    phrases.series(num)
  end

  def line(num)
    "#{prefix} #{phrase(num)}.\n"
  end
end


class UnchangedOrderer
  def order(data)
    data
  end
end

class RandomOrderer
  def order(data)
    data.shuffle
  end
end

class RandomButLastOrderer
  def order(data)
    data[0...-1].shuffle << data.last
  end
end

class MixedColumnOrderer
  def order(data)
    data.transpose.map {|column| column.shuffle}.transpose
  end
end


class PiratePrefixer
  def prefix
    "Thar be"
  end
end

class MundanePrefixer
  def prefix
    "This is"
  end
end


puts CumulativeTale.new(phrases: OrderedPhrases.new(orderer: RandomOrderer.new)).line(12)
puts
puts CumulativeTale.new(phrases: OrderedPhrases.new(orderer: RandomOrderer.new), prefixer: PiratePrefixer.new).line(12)
puts
puts CumulativeTale.new(phrases: OrderedPhrases.new(orderer: RandomButLastOrderer.new)).line(12)

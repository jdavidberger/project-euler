object prob84 {

  object Squares {
    val Go = 0
    val Jail = 10
    val CC1  = 2
    val CC2  = 17
    val CC3  = 33
    val CH1  = 7
    val CH2  = 22
    val CH3  = 36
    val C1   = 11
    val E3   = 24
    val H2   = 39
    val R1   = 5
    val R2   = 15
    val R3   = 25
    val R4   = 35
    val U1   = 12
    val U2   = 28
    val G2J  = 30
  }

  var histogram = Array.fill(40){0}
  var rollHistogram = Array.fill(12){0}
  var rollCount = 0

  var lastRoll = -1
  var doubleRollCount = 0
  var location = Squares.Go
  

  var diceCount = 2
  var diceFaces = 4

  var R = new scala.util.Random()
  def roll() : Int = {
    return List.range(0, diceCount).map( idx => 1+R.nextInt(diceFaces) ).sum
  }

  def gotoSquare(sq: Int) {
    location = sq
  }

  def communityChest() {
    var card = R.nextInt(16)    
    card match {
      case 0 =>
        return gotoSquare(Squares.Go)
      case 1 =>
        return gotoSquare(Squares.Jail)
      case _ =>
    }
  }

  def chance() {
    var card = R.nextInt(16)
    card match {
      case 0 =>
        return gotoSquare(Squares.Go)
      case 1 =>
        return gotoSquare(Squares.Jail)
      case 2 =>
        return gotoSquare(Squares.C1)
      case 3 =>
        return gotoSquare(Squares.E3)
      case 4 =>
        return gotoSquare(Squares.H2)
      case 5 =>
        return gotoSquare(Squares.R1)
      case 6 =>
        if(location < Squares.R1)
          location = Squares.R1
        else if(location < Squares.R2)
          location = Squares.R2
        else if(location < Squares.R3)
          location = Squares.R3
        else
          location = Squares.R4
        return gotoSquare(location)
      case 7 =>
        if(location < Squares.U1)
          location = Squares.U1
        else
          location = Squares.U2
        return gotoSquare(location)
      case 8 =>
        location = location - 3
        return
      case _ =>
    }
  }

  def turn() {
    val diceRoll = roll()
    rollHistogram(diceRoll-1) = rollHistogram(diceRoll-1)+1

    if(diceRoll == lastRoll) {
      doubleRollCount += 1
      if(doubleRollCount == 3) {
        gotoSquare(Squares.Jail)
        doubleRollCount = 0
        return;
      }
    } else {
      doubleRollCount = 0
    }
    lastRoll = diceRoll

    location = (location + diceRoll) % 40

    location match {
      case Squares.G2J =>
        return gotoSquare(Squares.Jail)
      case Squares.CC1 | Squares.CC2 | Squares.CC3  =>
        communityChest()
        return 
      case Squares.CH1 | Squares.CH2 | Squares.CH3 =>
        chance()
        return
      case _ =>

    }
  }

  def simulate(n: Int) {
    for( i <- 1 to n) {
      turn()
      location = (location + 40) % 40
      histogram(location) = histogram(location) + 1
      rollCount = rollCount + 1
    }

    for( j <- 0 to 2) {
      val winner = histogram.indexOf(histogram.max)
      histogram(winner) = -1
      print("%02d".format(winner))
    }
    println()
  }

  def main(args: Array[String]) {
    simulate(1000000)
  }
}


import strutils
import sets

const
  gcInput = @[3i64, 8, 1005, 8, 339, 1106, 0, 11, 0, 0, 0, 104, 1, 104, 0, 3, 8,
      1002, 8, -1, 10, 101, 1, 10, 10, 4, 10, 1008, 8, 0, 10, 4, 10, 1002, 8, 1,
      29, 2, 1108, 11, 10, 1, 1, 20, 10, 2, 107, 6, 10, 3, 8, 102, -1, 8, 10,
      101, 1, 10, 10, 4, 10, 108, 0, 8, 10, 4, 10, 101, 0, 8, 62, 1006, 0, 29,
      1006, 0, 12, 1, 1101, 5, 10, 1, 2, 20, 10, 3, 8, 102, -1, 8, 10, 1001, 10,
      1, 10, 4, 10, 1008, 8, 0, 10, 4, 10, 1001, 8, 0, 99, 1006, 0, 30, 3, 8,
      1002, 8, -1, 10, 1001, 10, 1, 10, 4, 10, 1008, 8, 0, 10, 4, 10, 1001, 8,
      0, 124, 1006, 0, 60, 3, 8, 1002, 8, -1, 10, 1001, 10, 1, 10, 4, 10, 1008,
      8, 1, 10, 4, 10, 101, 0, 8, 149, 2, 1007, 2, 10, 1, 1105, 10, 10, 3, 8,
      1002, 8, -1, 10, 101, 1, 10, 10, 4, 10, 108, 0, 8, 10, 4, 10, 101, 0, 8,
      178, 1, 1108, 15, 10, 1, 1101, 5, 10, 1, 109, 8, 10, 1006, 0, 20, 3, 8,
      102, -1, 8, 10, 1001, 10, 1, 10, 4, 10, 108, 1, 8, 10, 4, 10, 101, 0, 8,
      215, 1006, 0, 61, 1006, 0, 16, 2, 1105, 15, 10, 1006, 0, 50, 3, 8, 1002,
      8, -1, 10, 1001, 10, 1, 10, 4, 10, 108, 1, 8, 10, 4, 10, 101, 0, 8, 250,
      1, 1003, 10, 10, 1, 9, 19, 10, 2, 1004, 6, 10, 2, 1106, 2, 10, 3, 8, 1002,
      8, -1, 10, 1001, 10, 1, 10, 4, 10, 1008, 8, 1, 10, 4, 10, 101, 0, 8, 289,
      1, 1103, 13, 10, 2, 105, 17, 10, 3, 8, 1002, 8, -1, 10, 1001, 10, 1, 10,
      4, 10, 108, 1, 8, 10, 4, 10, 1002, 8, 1, 318, 101, 1, 9, 9, 1007, 9, 1086,
      10, 1005, 10, 15, 99, 109, 661, 104, 0, 104, 1, 21101, 0, 825599304340, 1,
      21101, 356, 0, 0, 1106, 0, 460, 21101, 0, 937108545948, 1, 21102, 1, 367,
      0, 1106, 0, 460, 3, 10, 104, 0, 104, 1, 3, 10, 104, 0, 104, 0, 3, 10, 104,
      0, 104, 1, 3, 10, 104, 0, 104, 1, 3, 10, 104, 0, 104, 0, 3, 10, 104, 0,
      104, 1, 21102, 1, 21628980315, 1, 21101, 0, 414, 0, 1105, 1, 460, 21101,
      0, 3316673539, 1, 21101, 425, 0, 0, 1106, 0, 460, 3, 10, 104, 0, 104, 0,
      3, 10, 104, 0, 104, 0, 21102, 988753428840, 1, 1, 21102, 1, 448, 0, 1106,
      0, 460, 21102, 825544569700, 1, 1, 21102, 459, 1, 0, 1106, 0, 460, 99,
      109, 2, 21202, -1, 1, 1, 21102, 1, 40, 2, 21102, 491, 1, 3, 21102, 481, 1,
      0, 1105, 1, 524, 109, -2, 2106, 0, 0, 0, 1, 0, 0, 1, 109, 2, 3, 10, 204,
      -1, 1001, 486, 487, 502, 4, 0, 1001, 486, 1, 486, 108, 4, 486, 10, 1006,
      10, 518, 1101, 0, 0, 486, 109, -2, 2105, 1, 0, 0, 109, 4, 2102, 1, -1,
      523, 1207, -3, 0, 10, 1006, 10, 541, 21102, 0, 1, -3, 21201, -3, 0, 1,
      22102, 1, -2, 2, 21102, 1, 1, 3, 21102, 560, 1, 0, 1106, 0, 565, 109, -4,
      2105, 1, 0, 109, 5, 1207, -3, 1, 10, 1006, 10, 588, 2207, -4, -2, 10,
      1006, 10, 588, 22101, 0, -4, -4, 1105, 1, 656, 21202, -4, 1, 1, 21201, -3,
      -1, 2, 21202, -2, 2, 3, 21102, 1, 607, 0, 1106, 0, 565, 22102, 1, 1, -4,
      21101, 0, 1, -1, 2207, -4, -2, 10, 1006, 10, 626, 21101, 0, 0, -1, 22202,
      -2, -1, -2, 2107, 0, -3, 10, 1006, 10, 648, 21202, -1, 1, 1, 21101, 0,
      648, 0, 105, 1, 523, 21202, -2, -1, -2, 22201, -4, -2, -4, 109, -5, 2105,
      1, 0]


type
  MachineStatus = enum
    ready
    waitInput
    finish
    error

  Machine = tuple
    status: MachineStatus
    input: seq[BiggestInt]
    memory: seq[BiggestInt]
    ip: BiggestInt
    base: BiggestInt
    output: seq[BiggestInt]

proc runProgram(aMachine: var Machine) =
  if ready == aMachine.status:
    while true:
      let lInstructionStr = ($aMachine.memory[aMachine.ip]).align(5, '0')

      template getMemory(aPosition: BiggestInt): BiggestInt =
        block getMemory:
          if (aMachine.memory.len <= aPosition):
            aMachine.memory.setLen(aPosition+1000)
          aMachine.memory[aPosition]

      template setMemory(aPosition: BiggestInt, aValue: BiggestInt) =
        block setMemory:
          if (aMachine.memory.len <= aPosition):
            aMachine.memory.setLen(aPosition+1000)
          aMachine.memory[aPosition] = aValue

      template getParam(aParam: int, aAddress: bool = false): BiggestInt =
        block getParam:
          var lResult = getMemory(aMachine.ip + aParam)
          case lInstructionStr[3-aParam]:
            of '0':
              if not aAddress:
                lResult = getMemory(lResult)
            of '2':
              lResult += aMachine.base
              if not aAddress:
                lResult = getMemory(lResult)
            else:
              discard
          lResult


      let lOpCode = lInstructionStr[3..4].parseBiggestInt
      case lOpCode
      of 1:
        let lX1 = getParam(1)
        let lX2 = getParam(2)
        let lA3 = getParam(3, true)
        setMemory(lA3, (lX1 + lX2))
        aMachine.ip += 4

      of 2:
        let lX1 = getParam(1)
        let lX2 = getParam(2)
        let lA3 = getParam(3, true)
        setMemory(lA3, (lX1 * lX2))
        aMachine.ip += 4

      of 3:
        if aMachine.input.len > 0:
          let lA1 = getParam(1, true)
          setMemory(lA1, aMachine.input.pop)
          aMachine.ip += 2
        else:
          aMachine.status = waitInput
          break

      of 4:
        let lX1 = getParam(1)
        aMachine.output.insert(lX1, 0)
        aMachine.ip += 2

      of 5:
        let lX1 = getParam(1)
        let lX2 = getParam(2)
        if (0 != lX1):
          aMachine.ip = lX2
        else:
          aMachine.ip += 3

      of 6:
        let lX1 = getParam(1)
        let lX2 = getParam(2)
        if (0 == lX1):
          aMachine.ip = lX2
        else:
          aMachine.ip += 3

      of 7:
        let lX1 = getParam(1)
        let lX2 = getParam(2)
        let lA3 = getParam(3, true)
        if (lX1 < lX2):
          setMemory(lA3, 1)
        else:
          setMemory(lA3, 0)
        aMachine.ip += 4

      of 8:
        let lX1 = getParam(1)
        let lX2 = getParam(2)
        let lA3 = getParam(3, true)
        if (lX1 == lX2):
          setMemory(lA3, 1)
        else:
          setMemory(lA3, 0)
        aMachine.ip += 4

      of 9:
        let lX1 = getParam(1)
        aMachine.base += lX1
        aMachine.ip += 2

      of 99:
        aMachine.status = finish
        break

      else:
        aMachine.status = error
        break


proc partOne =
  type
    Point = tuple
      x: BiggestInt
      y: BiggestInt
  var
    lMachine: Machine = (ready,
    @[],
    gcInput,
    0i64,
    0i64,
    @[])
    lWhiteHull: HashSet[Point]
    lPainted: HashSet[Point]
    lRobotDirection: 0..3
    lRobotPosition: Point

  while true:
    runProgram(lMachine)
    case lMachine.status
      of ready:
        break
      of waitInput:
        while lMachine.output.len > 0:

          lPainted.incl(lRobotPosition)
          if lMachine.output.pop == 1:
            lWhiteHull.incl(lRobotPosition)
          else:
            lWhiteHull.excl(lRobotPosition)

          case lMachine.output.pop
            of 0:
              lRobotDirection = (lRobotDirection + 3) mod 4
            of 1:
              lRobotDirection = (lRobotDirection + 1) mod 4
            else:
              discard
          case lRobotDirection
            of 0:
              lRobotPosition = (lRobotPosition.x, lRobotPosition.y - 1)
            of 1:
              lRobotPosition = (lRobotPosition.x + 1, lRobotPosition.y)
            of 2:
              lRobotPosition = (lRobotPosition.x, lRobotPosition.y + 1)
            of 3:
              lRobotPosition = (lRobotPosition.x - 1, lRobotPosition.y)

        if lWhiteHull.contains(lRobotPosition):
          lMachine.input.insert(1, 0)
        else:
          lMachine.input.insert(0, 0)
        lMachine.status = ready
      of finish:
        break
      of error:
        break

  echo "partOne ", lPainted.len

proc partTwo =
  type
    Point = tuple
      x: BiggestInt
      y: BiggestInt
  var
    lMachine: Machine = (ready,
    @[],
    gcInput,
    0i64,
    0i64,
    @[])
    lWhiteHull: HashSet[Point]
    lRobotDirection: 0..3
    lRobotPosition: Point

  lWhiteHull.incl(lRobotPosition)
  while true:
    runProgram(lMachine)
    case lMachine.status
      of ready:
        break
      of waitInput:
        while lMachine.output.len > 0:

          if lMachine.output.pop == 1:
            lWhiteHull.incl(lRobotPosition)
          else:
            lWhiteHull.excl(lRobotPosition)

          case lMachine.output.pop
            of 0:
              lRobotDirection = (lRobotDirection + 3) mod 4
            of 1:
              lRobotDirection = (lRobotDirection + 1) mod 4
            else:
              discard
          case lRobotDirection
            of 0:
              lRobotPosition = (lRobotPosition.x, lRobotPosition.y - 1)
            of 1:
              lRobotPosition = (lRobotPosition.x + 1, lRobotPosition.y)
            of 2:
              lRobotPosition = (lRobotPosition.x, lRobotPosition.y + 1)
            of 3:
              lRobotPosition = (lRobotPosition.x - 1, lRobotPosition.y)

        if lWhiteHull.contains(lRobotPosition):
          lMachine.input.insert(1, 0)
        else:
          lMachine.input.insert(0, 0)
        lMachine.status = ready
      of finish:
        break
      of error:
        break

  var
    lMin: Point = (BiggestInt.high, BiggestInt.high)
    lMax: Point = (BiggestInt.low, BiggestInt.low)
  for lPoint in lWhiteHull:
    lMin = (lMin.x.min(lPoint.x), lMin.y.min(lPoint.y))
    lMax = (lMax.x.max(lPoint.x), lMax.y.max(lPoint.y))
  echo "partTwo:"
  for lY in lMin.y .. lMax.y:
    var lString: string
    for lX in lMin.x .. lMax.x:
      if lWhiteHull.contains((lX, lY)):
        lString.add('O')
      else:
        lString.add(' ')
    echo lString

partOne() #2883
partTwo() #LEPCPLGZ

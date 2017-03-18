import QtQuick 2.0

Item {
    id: othello

    property int size: 100
    property int fieldSize: 8
    property int turn: 1

    width: size
    height: size

    signal cannotAssign(int a);

    function setState(index,sqareStatus){
        othelloSquares.itemAt(index).squareStatus = sqareStatus
    }

    function onClickedSquare(index){
        var status = getSquareState(index)
        if(status === 0){
            console.log("よしおいてみるか")
            var canSet = checkAndSet(index)
            //            setState(index,turn)
            if(canSet){
                if(turn === 1){
                    turn = 2
                }else{
                    turn = 1
                }
            }

            console.log(canSet)
        }else{
            console.log("おけないよーー")
        }
    }

    function checkAndSet(index){
        var x = indexToX(index)
        var y = indexToY(index)

        var Vec = [[-1,0],[-1,-1],[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1]]
        var flag = false
        var setVec = []

        for(var V = 0; V < 8; V++){
            var dx = Vec[V][0]
            var dy = Vec[V][1]
            var cx = x
            var cy = y
            var vecFlag = false
            var Vflag = false

            while(true){
                cx += dx
                cy += dy

                if(!((0 <= cx < fieldSize) && (0 <= cy < fieldSize))){
                    break;
                }
                var SqState = getSquareState(xyToIndex(cx,cy))

                //マスが空だった場合
                if(SqState === 0){
                    break;
                    //マスが自分と同じ色だった場合
                }else if(SqState === turn){
                    //自分の色でないマスと挟まれた場合
                    if(vecFlag){
                        flag = true
                        Vflag = true
                    }else{
                        break;
                    }
                    //マスが自分の色と違う場合
                }else if(SqState !== turn){
                    vecFlag = true;
                }
            }
            if(Vflag){
                setVec.push(V)
            }

            console.log(V + ":" + vecFlag)
        }
        console.log(setVec)

        for(var a = 0; a < setVec.length; a++){
            var Vecc = Vec[setVec[a]]
            dx = Vecc[0]
            dy = Vecc[1]
            cx = x
            cy = y

            othelloSquares.itemAt(xyToIndex(x,y)).squareStatus = turn

            while(true){
                cx += dx
                cy += dy
                if(othelloSquares.itemAt(xyToIndex(cx,cy)).squareStatus === turn){
                    break;
                }
                othelloSquares.itemAt(xyToIndex(cx,cy)).squareStatus = turn
            }
        }

        return flag
    }

    function indexToX(index){
        var Pos = indexToXY(index)
        return Pos[1]
    }

    function indexToY(index){
        var Pos = indexToXY(index)
        return Pos[0]
    }

    function indexToXY(index){
        return [Math.floor(index / fieldSize), index % fieldSize]
    }

    function getSquareState(index){
        return othelloSquares.itemAt(index).squareStatus
    }

    function getFieldIndexSize(){
        return fieldSize * fieldSize
    }

    function xyToIndex(x,y){
        var Poss = y * fieldSize + x
        return Poss
    }

    function initialState(){
        setState(xyToIndex(3,3),1)
        setState(xyToIndex(4,3),2)
        setState(xyToIndex(3,4),2)
        setState(xyToIndex(4,4),1)
    }

    Component.onCompleted: {
        //connect to each othello square
        for(var index = 0; index < getFieldIndexSize(); index++){
            othelloSquares.itemAt(index).onClickedSquare.connect(onClickedSquare)
        }
        //initialize field
        initialState();
    }

    Grid {
        columns: fieldSize
        Repeater {
            id: othelloSquares
            model: getFieldIndexSize()
            Square {
                squareSize: size / 8
                squareStatus: 0
                position: Positioner.index
            }
        }
    }
}

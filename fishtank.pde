// Program generates fish with random attributes on mouse clicks
// Pushes fish objects into an array
// Long fish swim faster than short fish
// Big bubbles rise faster than small bubbles

void setup() {

    size(1500, 800);
    frameRate(15);

    // seaweed coordinates arrays
    var seaweedXPos = [];
    var seaweedWidth = [];
    var seaweedHeight = [];
    for (var sw = 0; sw < 90; sw++) {
        seaweedXPos.push(random(5, 1495));
        seaweedWidth.push(random(5, 12));
        seaweedHeight.push(random(20, 280));
    }

    // bubbles coordinates arrays
    var bubbleDiam = [];
    var bubbleXPos = [];
    var bubbleYPos = [];
    for (var bb = 0; bb < 16; bb++) {
        bubbleDiam.push(random(6, 35));
        bubbleXPos.push(random(5, 1495));
        bubbleYPos.push(random(5, 895));
    }

    // fish array
    var fishArray = [];

    // create fish object to populate array
    var FishObj = function (id, direction, centerX, centerY, bodyLength, bodyHeight, bodyColor, eyeColor) {
        this.id = id;
        this.direction = direction; // 0 = right, 1 = left
        this.centerX = centerX;
        this.centerY = centerY;
        this.bodyLength = bodyLength;
        this.bodyHeight = bodyHeight;
        this.bodyColor = bodyColor;
        this.eyeColor = eyeColor;
    };

    // start with 5 random fish
    for (var i = 0; i < 5; i++) {
        fishArray[i] = new FishObj(
            i, // ID#
            floor(random(0, 2)), // Direction: 0 = left, 1 = right
            floor(random(10, 1450)), // centerX
            floor(random(10, 750)), // centerY
            floor(random(80, 150)), // bodyLength
            floor(random(40, 100)), // bodyHeight
            color(random(100, 255), random(100, 255), random(100, 255)), // bodyColor
            color(random(40, 150), random(40, 150), random(40, 150)) // eyeColor
        );
    }

    // function to make a NEW fish
    var makeNewFish = function (fishX, fishY) {
        fishArray.push({
            id: fishArray.length, // increments ID#
            direction: floor(random(0, 2)), // 0 = left, 1 = right
            centerX: fishX,
            centerY: fishY,
            bodyLength: floor(random(80, 200)),
            bodyHeight: floor(random(40, 170)),
            bodyColor: color(random(100, 255), random(100, 255), random(100, 255)),
            eyeColor: color(random(40, 150), random(40, 150), random(40, 150)),
        });
    };

    // DRAW STUFF!
    draw = function () {
        background(89, 216, 255);

        mouseClicked = function () { // this pushes a new fish to the
            makeNewFish(mouseX, mouseY); // array on mouse click.
        };

        for (var fishNum = 0; fishNum < fishArray.length; fishNum++) {

            // direction switching conditionals
            if (fishArray[fishNum].direction === 0 && fishArray[fishNum].centerX > 1400) {
                fishArray[fishNum].direction = 1;
            }
            if (fishArray[fishNum].direction === 1 && fishArray[fishNum].centerX < 100) {
                fishArray[fishNum].direction = 0;
            }

            // draw fish to canvas
            if (fishArray[fishNum].direction === 0) { // draws the left swimmers
                strokeWeight(2);
                stroke(fishArray[fishNum].bodyColor - 50);
                fill(fishArray[fishNum].bodyColor);
                // body
                ellipse(fishArray[fishNum].centerX, fishArray[fishNum].centerY, fishArray[fishNum].bodyLength, fishArray[fishNum].bodyHeight);
                // tail
                triangle(fishArray[fishNum].centerX - fishArray[fishNum].bodyLength / 2, fishArray[fishNum].centerY, fishArray[fishNum].centerX - fishArray[fishNum].bodyLength / 2 - (fishArray[fishNum].bodyLength / 4),
                    fishArray[fishNum].centerY - (fishArray[fishNum].bodyHeight / 2), fishArray[fishNum].centerX - fishArray[fishNum].bodyLength / 2 - (fishArray[fishNum].bodyLength / 4),
                    fishArray[fishNum].centerY + (fishArray[fishNum].bodyHeight / 2));
                // eye
                fill(fishArray[fishNum].eyeColor);
                ellipse(fishArray[fishNum].centerX + fishArray[fishNum].bodyLength / 4, fishArray[fishNum].centerY, fishArray[fishNum].bodyHeight / 5, fishArray[fishNum].bodyHeight / 5);
                // movement & velocity
                fishArray[fishNum].centerX += fishArray[fishNum].bodyLength * 0.02;
            } else { // draws the right swimmers
                strokeWeight(2);
                stroke(fishArray[fishNum].bodyColor - 50);
                fill(fishArray[fishNum].bodyColor);
                // body
                ellipse(fishArray[fishNum].centerX, fishArray[fishNum].centerY, fishArray[fishNum].bodyLength, fishArray[fishNum].bodyHeight);
                // tail
                triangle(fishArray[fishNum].centerX + fishArray[fishNum].bodyLength / 2, fishArray[fishNum].centerY, fishArray[fishNum].centerX + fishArray[fishNum].bodyLength / 2 + (fishArray[fishNum].bodyLength / 4),
                    fishArray[fishNum].centerY + (fishArray[fishNum].bodyHeight / 2), fishArray[fishNum].centerX + fishArray[fishNum].bodyLength / 2 + (fishArray[fishNum].bodyLength / 4),
                    fishArray[fishNum].centerY - (fishArray[fishNum].bodyHeight / 2));
                // eye
                fill(fishArray[fishNum].eyeColor);
                ellipse(fishArray[fishNum].centerX - fishArray[fishNum].bodyLength / 4, fishArray[fishNum].centerY, fishArray[fishNum].bodyHeight / 5, fishArray[fishNum].bodyHeight / 5);
                // movement & velocity
                fishArray[fishNum].centerX -= fishArray[fishNum].bodyLength * 0.02;
            }

        }

        // draw seaweed
        for (var sww = 0; sww < seaweedXPos.length; sww++) {
            strokeWeight(1);
            stroke(8, 99, 3);
            fill(63, 176, 35);
            ellipse(seaweedXPos[sww], 800, seaweedWidth[sww], seaweedHeight[sww]);
        }

        // draw and animate bubbles
        for (var bbb = 0; bbb < bubbleDiam.length; bbb++) {
            strokeWeight(1);
            stroke(255, 255, 255);
            fill(230, 230, 230, 160);
            ellipse(bubbleXPos[bbb], bubbleYPos[bbb], bubbleDiam[bbb], bubbleDiam[bbb]);
            // animate bubbles
            if (bubbleYPos[bbb] >= -16) { // bubble rise rate a function of diam
                bubbleYPos[bbb] -= bubbleDiam[bbb] * 0.05;
            } else { // reset bubbles at bottom
                bubbleYPos[bbb] = 816;
            }
        }
    }

} // end SETUP
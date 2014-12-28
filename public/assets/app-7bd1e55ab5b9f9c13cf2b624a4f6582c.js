
jQuery(document).ready(function($) {

    TIMEOUT = 3000;
    FADEIN_TIME = 2500;

    // Create array of elements from HTML
    myArray = $('.picturelist').toArray();

    setTimeout(swapImage,TIMEOUT);

      // get a random url and swap the image
      function swapImage(){
    
        // pick a random box
        randomBox = jQuery(".box").random();
        
        // push the visible picture to the end of the queue
        myArray.push(randomBox.html());
         
        // put the visible picture at the bottom
        randomBox.find('.picture').addClass("bottom", fadeNew());

        function fadeNew(){
          // get picture from array
          var html = myArray.shift();

          // Add the new picture on top and fade it in
          $(html).hide().appendTo(randomBox);
          randomBox.find(':not(.bottom)').fadeIn(FADEIN_TIME, removePreviousPicture);
        }

        // remove the old image
        function removePreviousPicture(){
          randomBox.find(".bottom").remove();
        }

        //recurse into this function to do it all again
        setTimeout(swapImage, TIMEOUT);

      }

      // .random() auxillery function 
      // http://stackoverflow.com/questions/18519975/jquery-get-random-element-from-a-selection-returned-by-selector
      $.fn.random = function() {
        return this.eq(Math.floor(Math.random() * this.length));
      }
      
});

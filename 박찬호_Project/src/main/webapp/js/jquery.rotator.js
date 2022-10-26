/**
 *  jQuery Rotator Plugin
 *  @requires jQuery v1.2.6 or greater
 *  http://hernan.amiune.com/labs
 *
 *  Copyright (c)  Hernan Amiune (hernan.amiune.com)
 *  Licensed under MIT license:
 *  http://www.opensource.org/licenses/mit-license.php
 * 
 *  Version: 2.1
 */
 
(function($){ $.fn.rotator = function(options){

    var defaults = {
		ms: 2000,
		n: 1,
		autoHeight: false,
		detectHeight: true // proposed by Cliff Pruitt
	};
  
    var options = $.extend(defaults, options);
	
	return this.each(function(index) {
		
		var $this = $(this);
		
		var initialHeight = 0;
		$this.children().filter(":lt("+options.n+")").each(function(index,item){
		    initialHeight += $(item).height();
		});
		
		if(options.detectHeight)$this.height(initialHeight); // proposed by Cliff Pruitt
		
		var beginRotation = function(){
            $this.data("timer", setInterval(function(){
                
                var childHeight = $this.children().filter(":first-child").height();
                var animParams = {scrollTop: (childHeight) + "px"};
                var autoHeight = 0;
                if(options.autoHeight){
                    $this.children().filter(":lt("+(options.n+1)+")").each(function(index,item){
                        if(index>0)autoHeight += $(item).height();
                    });
                    animParams = $.extend({height:(autoHeight) + "px"}, animParams);
                }
            
                
                $this.animate(animParams, 500, function(){
                	$this.append($this.children().filter(":first-child"));
                    $this.scrollTop(0);
                });

                
            }, options.ms));
		}
		
		$this.mouseover(function(){
		    clearTimeout($this.data("timer"));
		});
		
		$this.mouseout(function(){
		    beginRotation();
		});
		
		beginRotation();

	});

  
}})(jQuery);
// ==UserScript==
// @name       Convert_iframe_to_link
// @namespace  https://gist.github.com/ihsoy-s/
// @version    0.2.3
// @description  Remove iframe tag and create link
// @include    http://*/*
// @include    https://*/*
// @match      http://*/*
// @match      https://*/*
// @run-at     document-end
// @copyright  2012, Yoshi-S
// ==/UserScript==

( function(){

	// convertIframe2Link_youtube
	//    doc: target
	//    tag: target HTML tag ('iframe', 'embed', etc.)
	function convertIframe2Link_youtube(doc, tag) {
		// convert specified tag to link
		var iframe = doc.getElementsByTagName(tag);
		var i, iframe_src;
		
		for (i = iframe.length - 1; i >= 0; i--) {
			if( iframe[i].getAttribute("src") )
			{
				iframe_src = iframe[i].getAttribute("src");
				iframe_src = iframe_src.replace('www.youtube-nocookie.com', 'www.youtube.com');
				if ( iframe_src.indexOf('www.youtube.com') != -1 )
				{
					// get url to link
					iframe_src = iframe_src.replace(/\?.*/, "")
					iframe_src = iframe_src.replace(/&amp;.*/, "")
					iframe_src = iframe_src.replace('/embed/', '/watch?v=');
					iframe_src = iframe_src.replace('/v/', '/watch?v=');
					
					// create link
					var linkobject = document.createElement('a');
					var linkobject_text = document.createTextNode('YouTube');
					
					linkobject.setAttribute('href', iframe_src);
					linkobject.appendChild(linkobject_text);
					
					// remove target tag
					iframe[i].parentNode.replaceChild(linkobject, iframe[i]);

					// debug message
					console.debug("[Convert iframe to link] convert youtube:", iframe_src);
				}
			}
		}
	}

	// convertIframe2Link_vimeo
	//    doc: target
	//    tag: target HTML tag ('iframe', 'embed', etc.)
	function convertIframe2Link_vimeo(doc, tag) {
		// convert specified tag to link
		var iframe = doc.getElementsByTagName(tag);
		var i, iframe_src;
		
		for (i = iframe.length - 1; i >= 0; i--) {
			if( iframe[i].getAttribute("src") )
			{
				iframe_src = iframe[i].getAttribute("src");
				if ( iframe_src.indexOf('player.vimeo.com') != -1 )
				{
					// get url to link
					iframe_src = iframe_src.replace(/\?.*/, "")
					iframe_src = iframe_src.replace(/&amp;.*/, "")
					iframe_src = iframe_src.replace('/video/', '/');
					iframe_src = iframe_src.replace('player.vimeo.com', 'vimeo.com');
					
					// create link
					var linkobject = document.createElement('a');
					var linkobject_text = document.createTextNode('Vimeo');
					
					linkobject.setAttribute('href', iframe_src);
					linkobject.appendChild(linkobject_text);
					
					// remove target tag
					iframe[i].parentNode.replaceChild(linkobject, iframe[i]);

					// debug message
					console.debug("[Convert iframe to link] convert vimeo:", iframe_src);
				}
			}
		}
	}

	// convertIframe2Link_niconico
	//    doc: target
	//    tag: target HTML tag ('iframe', 'embed', etc.)
	function convertIframe2Link_niconico(doc, tag) {
		// convert specified tag to link
		var iframe = doc.getElementsByTagName(tag);
		var i, iframe_src;
		
		for (i = iframe.length - 1; i >= 0; i--) {
			if( iframe[i].getAttribute("src") )
			{
				iframe_src = iframe[i].getAttribute("src");
				if ( iframe_src.indexOf('ext.nicovideo.jp') != -1 )
				{
					// get url to link
					iframe_src = iframe_src.replace(/\?.*/, "")
					iframe_src = iframe_src.replace(/&amp;.*/, "")
					iframe_src = iframe_src.replace('/thumb_watch/', '/watch/');
					iframe_src = iframe_src.replace('/thumb/', '/watch/');
					iframe_src = iframe_src.replace('ext.nicovideo.jp', 'www.nicovideo.jp');
					
					// create link
					var linkobject = document.createElement('a');
					var linkobject_text = document.createTextNode('niconico');
					
					linkobject.setAttribute('href', iframe_src);
					linkobject.appendChild(linkobject_text);
					
					// remove target tag
					iframe[i].parentNode.replaceChild(linkobject, iframe[i]);

					// debug message
					console.debug("[Convert iframe to link] convert niconico:", iframe_src);
				}
			}
		}
	}

	// convertIframe2Link_xvideo
	//    doc: target
	//    tag: target HTML tag ('iframe', 'embed', etc.)
	function convertIframe2Link_xvideo(doc, tag) {
		// convert specified tag to link
		var iframe = doc.getElementsByTagName(tag);
		var i, iframe_src;
		
		for (i = iframe.length - 1; i >= 0; i--) {
			if( iframe[i].getAttribute("src") )
			{
				iframe_src = iframe[i].getAttribute("src");
				if ( iframe_src.indexOf('flashservice.xvideos.com') != -1 )
				{
					// get url to link
					iframe_src = iframe_src.replace('/embedframe/', '/video');
					iframe_src = iframe_src.replace('flashservice.xvideos.com', 'www.xvideos.com');
					
					// create link
					var linkobject = document.createElement('a');
					var linkobject_text = document.createTextNode('xvideos');
					
					linkobject.setAttribute('href', iframe_src);
					linkobject.appendChild(linkobject_text);
					
					// remove target tag
					iframe[i].parentNode.replaceChild(linkobject, iframe[i]);

					// debug message
					console.debug("[Convert iframe to link] convert xvideos:", iframe_src);
				}
			}
		}
	}

	function convert_all(doc) {
	
		convertIframe2Link_youtube(doc, 'iframe');
		convertIframe2Link_youtube(doc, 'embed');
		
		convertIframe2Link_vimeo(doc, 'iframe');
		convertIframe2Link_vimeo(doc, 'embed');
		
		convertIframe2Link_xvideo(doc, 'iframe');
		convertIframe2Link_xvideo(doc, 'embed');
		
		convertIframe2Link_niconico(doc, 'script');
		convertIframe2Link_niconico(doc, 'iframe');
	}
	
	
	// exec
	convert_all(document);

	// exec if AutoPagerize was called
	document.body.addEventListener('AutoPagerize_DOMNodeInserted', function(evt){
		var node = evt.target;
		convert_all(node);
	}, false);


}) ();


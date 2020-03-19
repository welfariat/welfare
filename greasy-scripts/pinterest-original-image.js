
// ==UserScript==
// @name        pinterest-original-image
// @namespace   Violentmonkey Scripts
// @match		*://*.pinterest.com/pin/*
// @grant       none
// @version     1.1.0
// @author      zbutfly@gmail.com
// @description Pinterest Original Image Dimensions and Load
// @icon		data:image/webp;base64,UklGRiwCAABXRUJQVlA4ICACAACQDwCdASpgAGAAPpFCmUklpCIhKrQLULASCWkACwLnM7lZUD3qPhhyfoi4EJqYEkijj1eyOYmT3IYhtxgy+BGpwZDnJebEYh8xoDtcQGJwfXR6XKUsDp8ImRstvpI9QDDlilTxpA7kcdGt/DL01It0ORjvjrZdFshyhgDOqb2u0sSMxP4AAP75WILI9izCJ90U/ymzkAkChdxajHRzZduKaHsdj1+2UJNefVhNU13bUAPiqJsdwBBpOrKaP5IEU7r53aXsSsXcLRe+kMYBXu1yVLxOBbqz5FzIX0RejZ9rMQ4JezrYUOPmp2+nW63W5ZTyR4L1Kb6dYBQad9bw7txNBTLTh+0tHFjHb+iUGu44OJbc59XGEu0e95Du9epPGLsCjkKOTjpoQEVTQOG6VQX9JFLIBf1tS3TX1dcrcoE4AwJuz/DQqdfVAzkCKGorgYfGEEh07+04xxg84GWco2z0EZapsSzjJ+I5rtWG0v0YP+O4n6QalKIK3Yen+6+lF4np3zOYHprBKtih8L23RFapNjSV1cX/BiR3S52ev9J5OndAgVhpeex6DCEUkRV9l42knag8br10z3f2g/3iZdXGBgYGcnWtARJDCbnUHGcMStX/diAZtkphXJz19NMWf1k3YlsHc0IDJOgUe1sAntBhE+w9NTprFM4ezX2WFD7cosQxHWTRYCKQ2hC4uYI7CbgoCd8uBMxuNS+pMR45QAAA
// ==/UserScript==

; (function () { // eslint-disable-line
	window.onload = function () {
		if (document.URL.endsWith('/fb.html')) return;

		var logo = document.evaluate('/html/body/div/div[1]/div[2]/div/div/div/div[2]/div/div/div/div[1]/div/a', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
		// var logo = document.getElementsByClassName('dangerouslyDisableFocusStyle')[0];
		logo.style.filter = "invert(100%)";
		var btn = document.createElement('img');
		btn.title = "Press to add info and loading events.";
		btn.style.cursor = "pointer";
		btn.parent.append(btn)

		btn.onclock = e => {
			var cells = document.getElementsByClassName('Yl-');
			for (var i = 0; i < cells.length; i++) {
				var img = document.getElementsByClassName('Yl-')[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0].children[0];
				var srcs = img.srcset.split();
				var src = srcs[srcs.length - 1].split()[0];
				img.onload = ee => {
					debugger;
					if (ee.target.parent.children.length > 1) return;
					var info = document.createElement('a');
					info.innerText = e.target.naturalWidth + " x " + e.target.naturalHeight;
					info.style.display = "block";
					info.style.position = "absolute";
					info.style.left = "3px";
					info.style.top = "3px"
					info.href = srcs[srcs.length - 1].split()[0];
					ee.target.parent.append(info);
					console.debug("img ");
				}
			}
		}
		console.info("Original info enabled by click the inverted LOGO");
	}
}());

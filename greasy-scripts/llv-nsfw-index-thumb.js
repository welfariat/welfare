// ==UserScript==
// @name        LVV2列表添加略图 - https://lvv2.com/nsfw
// @namespace   Violentmonkey Scripts
// @match       https://lvv2.com/nsfw*
// @grant       none
// @version     1.00
// @author      zbutfly@gmail.com
// @icon        data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEgAAABICAMAAABiM0N1AAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAABdUExURUxpcemNSemNSemNSemNSemNSemNSemNSemNSemNSdktOumNSemNSemNSemNSemNSemNSdktOtktOtktOtktOtktOtktOtktOtktOtktOtktOtktOtktOumNSdktOsZoAhUAAAAddFJOUwAgkIAQ4MBAYPBA0KAwcLBQ0BBgIHDggDCw8JDAT2c6pQAAAiFJREFUWMPNl9lywyAMRcMOMQa7SdMV//9nNk4nqRcJhOvOVI9+OJbE5UocDn8VrBNRp3so7YWRGzBWJSAa3lZyfMLCVbF4ykVjye1JhVB2j4S+UR0FpBMhNCuDEilcKIIcjZSi3KO0W6cKUghUUHL5nktHJqW8EGz6fyTmr7dW82DGK8+MEb7ZSALYNiIkU20uMoDu4tq9jKrZYnlSACS/zYSBvnfb/HztM05uI611FjfOmNb9XgMIqSk01phgDTTR2gqBm/j4rfJdqU+K2lHHWf7ssJTM+ozFvMSG1iVV9FbmKAfXEjxDUC6KQTyDZ7KWNaAZyRLabUiOqAj3BB8lLZoSWJvA56LEUuoqty2BqZLDShJodQzZpdCba8ytH53HrXUu77K9RqyrvNaV5ptFQGRy/X78CQKpQday6zEM0+jfXl5XpAjXNmuSXoDGuHycM9tOB/Mh0DVecCcTiHBh0NA/Yfu3Rk4BAS1ICgIZEmjokS3V1YKGZ+QeV4MuTzuBpin5X4F6sEdNPWh41CbB4+/IoCP0b14nSBwUYB9R1aAWfgJpEoiBq4dbWCcBNPm5QEa7IJ3az9YwWazD0mpRzvt64Zsu6HE5XlDQ2/wREbW36EAeW0e5IsWXdMyBzhWgkAH1NU9ydqD5UWlDuKlrY2UzudsMqC+OYL5wBAT0eSql9ChOyxxoTOpUqm4Upb6ra8jE5bXiuTNk47QXiE76AnacIlJf1W5ZAAAAAElFTkSuQmCC
// @description LVV2列表添加略图
// ==/UserScript==

; (function () { // eslint-disable-line
	var entries = document.getElementsByClassName('entry');
	var regex = RegExp(/<img[^>]*detailImg[^>]*data-echo=\"([^\"]+)\">/, 'g')
	var thumbnailing = function (i) {
		if (i >= entries.length) return;
		var entry = entries[i];
		var url = entry.children[0].children[0].href.replace(/\/title-.*/, '');
		var oReq = new XMLHttpRequest();
		oReq.addEventListener("load", function () {
			var div = entry.children[1].children[0];
			var replies = div.children[2];
			for (var j = 0; j < 5; j++) {
				var match = regex.exec(this.responseText);
				if (!match) break;
				var thumb = document.createElement('img');
				thumb.style['max-height'] = '100px';
				thumb.onclick = e => {
					if ('60vh' === e.target.style['max-height']) e.target.style['max-height'] = '100px'; // zoom in
					else {
						var all = document.getElementsByClassName('butfly-thumbnail-' + replies.id);
						for (var k = 0; k < all.length; k++)
							all[k].style['max-height'] = '100px';
						e.target.style['max-height'] = '60vh';
					}
				}
				thumb.style.padding = '0.5em';
				thumb.src = match[1];
				thumb.id = replies.id + '-thumb-' + (i + 1);
				thumb.classList.add('butfly-thumbnail-' + replies.id);
				thumb.title = "略图" + (j + 1) + '，点击缩放。';
				entry.parentElement.insertBefore(thumb, entry.nextSibling);
				// entry.insertAdjacentElement("afterend", thumb);
				// div.insertBefore(thumb, replies);
				console.log('thumb ' + match[1] + ' inserted');
			}
			thumbnailing(i + 1); //next
		});
		oReq.open("GET", url);
		oReq.send();
	}
	thumbnailing(0);
}());

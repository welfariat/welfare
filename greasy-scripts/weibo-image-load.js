// ==UserScript==
// @name        微博原图展开和下载
// @namespace   Violentmonkey Scripts
// @match       https://www.weibo.com/*
// @grant       none
// @version     1.03
// @author      zbutfly@gmail.com
// @description 为微博多图条目添加原图载入按钮
// @icon              data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEgAAABICAMAAABiM0N1AAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAABdUExURUxpcemNSemNSemNSemNSemNSemNSemNSemNSemNSdktOumNSemNSemNSemNSemNSemNSdktOtktOtktOtktOtktOtktOtktOtktOtktOtktOtktOtktOumNSdktOsZoAhUAAAAddFJOUwAgkIAQ4MBAYPBA0KAwcLBQ0BBgIHDggDCw8JDAT2c6pQAAAiFJREFUWMPNl9lywyAMRcMOMQa7SdMV//9nNk4nqRcJhOvOVI9+OJbE5UocDn8VrBNRp3so7YWRGzBWJSAa3lZyfMLCVbF4ykVjye1JhVB2j4S+UR0FpBMhNCuDEilcKIIcjZSi3KO0W6cKUghUUHL5nktHJqW8EGz6fyTmr7dW82DGK8+MEb7ZSALYNiIkU20uMoDu4tq9jKrZYnlSACS/zYSBvnfb/HztM05uI611FjfOmNb9XgMIqSk01phgDTTR2gqBm/j4rfJdqU+K2lHHWf7ssJTM+ozFvMSG1iVV9FbmKAfXEjxDUC6KQTyDZ7KWNaAZyRLabUiOqAj3BB8lLZoSWJvA56LEUuoqty2BqZLDShJodQzZpdCba8ytH53HrXUu77K9RqyrvNaV5ptFQGRy/X78CQKpQday6zEM0+jfXl5XpAjXNmuSXoDGuHycM9tOB/Mh0DVecCcTiHBh0NA/Yfu3Rk4BAS1ICgIZEmjokS3V1YKGZ+QeV4MuTzuBpin5X4F6sEdNPWh41CbB4+/IoCP0b14nSBwUYB9R1aAWfgJpEoiBq4dbWCcBNPm5QEa7IJ3az9YwWazD0mpRzvt64Zsu6HE5XlDQ2/wREbW36EAeW0e5IsWXdMyBzhWgkAH1NU9ydqD5UWlDuKlrY2UzudsMqC+OYL5wBAT0eSql9ChOyxxoTOpUqm4Upb6ra8jE5bXiuTNk47QXiE76AnacIlJf1W5ZAAAAAElFTkSuQmCC
// ==/UserScript==

; (function () { // eslint-disable-line
	var create_expand = function () {
		var backward = function (e, cn) {
			while (e.previousSibling) {
				e = e.previousSibling;
				if (e.classList && e.classList.contains(cn)) return e;
			}
			if (e.parentElement) return backward(e.parentElement, cn);
		}
		var panels = document.getElementsByClassName("WB_media_a_mn");
		for (var i = 0; i < panels.length; i++) {
			var info = backward(panels[i], "WB_info");
			var btn = document.createElement('a');
			btn.text = "载入所有原图";
			btn.style.cursor = 'pointer';
			btn.onclick = expand;
			btn.style["margin-left"] = "3em";
			info.append(btn);
		}
	}

	var expand = function (event) {
		var backward = function (e, cn) {
			while (e.previousSibling) {
				e = e.previousSibling;
				if (e.classList && e.classList.contains(cn)) return e;
			}
			if (e.parentElement) return backward(e.parentElement, cn);
		}
		var panel = event.target.parentElement.parentElement.getElementsByClassName("WB_media_a_mn")[0];
		var text = backward(panel, "WB_text");
		event.target.parentElement.append(document.createElement('hr'));
		var masonry = document.createElement('div');
		masonry.classList.add('masonry');
		var imgtitle = function (e) {
			e.target.title = '原图' + (e.target['image-seq'] + 1) + "，原始大小：" + e.target.naturalWidth + " x " + e.target.naturalHeight;
		}
		for (var i = 0; i < panel.children.length; i++) {
			var li = panel.children[i];
			var img = li.children[0];
			if (img.tagName !== "IMG") continue;
			var dst = img.src.replace(/sinaimg.cn\/[^/]+\//, 'sinaimg.cn/large/');

			var atag = document.createElement('a');
			atag.href = dst;
			atag.target = '_blank';
			atag.classList.add("masonry-item")

			var img = document.createElement('img');
			img["image-seq"] = i;
			img.onload = imgtitle;
			img.src = dst;
			atag.append(img)

			event.target.parentElement.append(atag);
		}
		event.target.parentElement.append(document.createElement('hr'));
	}

	var topbtn = function () {
		var ele = document.getElementsByClassName('W_swficon');
		if (ele.length == 0) {
			console.info("等待网页载入……");
			setTimeout(topbtn, 5);
		} else {
			ele = ele[0];
			ele.style.cursor = "pointer";
			ele.style.border = "solid 1px";
			ele.style["padding-top"] = "2px";
			ele.title = "点击启用加载原图按钮";
			ele.style.filter = "invert(100%)"
			ele.onclick = create_expand;

			ele = document.getElementsByClassName('box')[0];
			ele.href = "javascript:void(0)";
			ele.title = "点击启用加载原图按钮";
			ele.onclick = create_expand;
			ele.style.filter = "invert(100%)"
			console.info("点击发文输入框上方\"有什么新鲜事\"显示加载按钮（在微博作者行）。");

			var style = document.createElement("style");
			style.id = 'masonry-style';
			style.type = 'text/css';
			var css = ".masonry {-moz-column-count:3; /* Firefox */ -webkit-column-count:3; /* Safari 和 Chrome */ column-count:3; -moz-column-gap: 2em; -webkit-column-gap: 2em; column-gap: 2em; width: 80%; margin:2em auto;}";
			css += "\n.masonry-item {padding: 0.3em; margin-bottom: 0.3em; -moz-page-break-inside: avoid; -webkit-column-break-inside: avoid; break-inside: avoid; background: #f60;}";
			css += "\n.masonry-item img {max-width: 30%}";
			style.textContent = css;
			document.head.appendChild(style);
		}
	}

	document.onreadystatechange = function () {
		if (document.readyState === "complete") topbtn();
		else console.debug("document change: " + document.readyState);
	}

	document.addEventListener('DOMContentLoaded', (event) => {
		console.log('DOM fully loaded and parsed');
	});
}());

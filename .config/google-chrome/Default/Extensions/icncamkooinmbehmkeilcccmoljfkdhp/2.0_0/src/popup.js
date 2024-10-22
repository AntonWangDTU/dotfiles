(() => {
	'use strict';
	const URL_WOLFRAM_ALPHA = "https://www.wolframalpha.com/input/?i=";
	const track = (query) => {
		return new Promise(resolve => {
			try {
				wal('log', 'event', 'chromeExtension', {
					referer: document.referrer,
					query
				});
				setTimeout(() => resolve(), 200);
			} catch (e) {
				console.warn(e);
			}
		});
	};

	const navigate = (query) => {
		const url = `${URL_WOLFRAM_ALPHA}${encodeURIComponent(query)}`;
		window.open(url);
		window.close();
	};

	document.addEventListener('submit', async (e) => {
		e.preventDefault();
		const query = document.getElementById('query').value;
		if (query && query.trim() !== '') {
			await track(query);
			navigate(query);
		}
	});
})();


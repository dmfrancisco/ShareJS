<html>
	<head>
		<title>Wiki {{name}}</title>
		<link href="/_wiki/style.css" rel="stylesheet" type="text/css">
	</head>

	<body>
		<div id="header">
			<div id="htext">
				Wiki <strong>{{name}}</strong>
			</div>
		</div>
		<div id="left">
			<div id="view" class="content">{{{markdown}}}</div>
		</div>
		<div id="editor">{{{content}}}</div>
		<script src="/lib/markdown/showdown.js" type="text/javascript"></script>
		<script src="/lib/ace/ace.js" type="text/javascript" charset="utf-8"></script>
		<script src="/socket.io/socket.io.js"></script>
		<script src="/share/share.js"></script>
		<script src="/share/share-ace.js"></script>
		<script>

    window.onload = function() {
		var converter = new Showdown.converter();
		var view = document.getElementById('view');

        var editor = ace.edit("editor");
		editor.setReadOnly(true);
		editor.session.setUseWrapMode(true);
		editor.setShowPrintMargin(false);

		var connection = new sharejs.Connection(window.location.hostname, 8000);

		connection.open('{{{docName}}}', function(doc, error) {
			if (error) {
				console.error(error);
				return;
			}
			doc.attach_ace(editor);
			editor.setReadOnly(false);

			var render = function() {
				view.innerHTML = converter.makeHtml(doc.snapshot);
			};

			window.doc = doc;

			render();
			doc.on('change', render);
		});
    };
		</script>
	</body>
</html>	


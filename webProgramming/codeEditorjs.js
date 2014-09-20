// set up a code editor (Textarea)
var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
	lineNumbers: true,
	styleActiveLine: true,
	matchBrackets: true,
	autoCloseBrackets: true,
	autoCloseTags: true, //for html closed tag
	//insert auto-complete
	extraKeys: {
		"Ctrl-Space": "autocomplete"
	},
	mode: {
		name: "javascript",
		globalVars: true
	}

});

editor.setSize(window.innerWidth, window.innerHeight);

// mode part
CodeMirror.modeURL = "./mode/%N/%N.js";


// !!!!!!!!!
//html mixed code
// Define an extended mixed-mode that understands vbscript and
// leaves mustache/handlebars embedded templates in html mode
var mixedMode = {
	name: "htmlmixed",
	scriptTypes: [{
		matches: /\/x-handlebars-template|\/x-mustache/i,
		mode: null
	}, {
		matches: /(text|application)\/(x-)?vb(a|script)/i,
		mode: "vbscript"
	}]
};
// var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
// 	mode: mixedMode
// });

//more code goes here...

function codeEditorFactory(textArea, mode) {
	var mode = "javascript" //defaul
	return {
		setCode: function(value) {
			editor.setValue(value);
		},

		getCode: function() {
			return editor.getValue();
		},

		getMode: function() {
			return editor.getMode().name;
		},

		setMode: function(mode) {
			editor.setOption("mode", mode);
			CodeMirror.autoLoadMode(editor, mode);
		}
	}
}

//window event
var triggerResizeEditor = function(){
	console.log("resize");
	editor.setSize(window.innerWidth, window.innerHeight);
	console.log(window.innerWidth + " " + window.innerHeight);
}

triggerResizeEditor();
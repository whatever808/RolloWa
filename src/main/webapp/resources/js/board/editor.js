// TinyMCE Editor Settings
tinymce.init({
	  selector: 'textarea#board-content',
	  language:"ko_KR",
	  menubar: false,
	  plugins: 'advlist autolink lists link image charmap preview anchor ' +
	     		  'searchreplace visualblocks code fullscreen insertdatetime media table ' +
	     		  'code help wordcount save',
	  toolbar_mode: 'floating',
	  toolbar: 'undo redo |'
	  			 +'styles fontfamily fontsize fontsizeinput'
	  			 +'formatselect fontselect fontsizeselect |'
	  			 +'forecolor backcolor |'
	  			 +'bold italic underline strikethrough |'
	  			 +'bullist numlist |'
	  			 +'table tabledelete |'
	  			 +'link image | code',
	  setup: function(editor){
	  		editor.on('change', function(){
	  			tinymce.triggerSave();
	  		}
	  )},
	  // enable title field in the Image dialog
	  image_title: true,
	  // enable automatic uploads of images represented by blob or data URIs
	  automatic_uploads: true,
	  file_picker_types: 'image',
	  // my custom image picker
	  file_picker_callback: (cb, value, meta) => {
	    const input = document.createElement('input');
	    input.setAttribute('type', 'file');
	    input.setAttribute('accept', 'image/*');
	
	    input.addEventListener('change', (e) => {
	      const file = e.target.files[0];
	
	      const reader = new FileReader();
	      reader.addEventListener('load', () => {
	        const id = 'blobid' + (new Date()).getTime();
	        const blobCache =  tinymce.activeEditor.editorUpload.blobCache;
	        const base64 = reader.result.split(',')[1];
	        const blobInfo = blobCache.create(id, file, base64);
	        blobCache.add(blobInfo);
	
	        // call the callback and populate the Title field with the file name 
	        cb(blobInfo.blobUri(), { title: file.name });
	      });
	      reader.readAsDataURL(file);
	    });
	
	    input.click();
	  },
	  content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:16px }'
});
//id forme brez vezajev
//https://www.dropzonejs.com/

const DROPZONE_WIDGET_ID = "dropzone";


$(document).ready(function() {
  //TODO: če želimo programsko 
  //initDropzone();
});

function initDropzone()
{
  const dz = new Dropzone('#' + DROPZONE_WIDGET_ID, { 
    url: '/tutorial/upload',
    clickable: false 
  });
}

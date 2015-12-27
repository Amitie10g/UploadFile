# UploadFile (botclasses.php)

A small botclasses.php-based PHP (CLI and CGI/HTTP) script to upload files to
MediaWiki wikis (like Wikimedia Commons). Includes the main script, and some
graphical front-ends (yad-based for now). Contributions are welcome.

Important: This project is still Work in progress. For now it works as,
expected, but there is much to do. Any contributions are welcome.

This program includes:

* UploadFile.sh: The init script that contains the User, Password and Project
* UploadFile-yad.sh: The YAD front-end
* UploadFile-dialog.sh: The dialog front-end (incomplete, in developement)
* UploadFile.phar: A phar archiver in '/lib' that contains the libraries:
  * class.php: The classes library
  * cli.php: The CLI script
  * web.php: The CGI/HTTP script (incomplete, in developement)
  * web-*.tpl.php: Many templates for the Web interface
  
In order to build UploadFile.phar, run "./create_phar.sh". Once created, you
can safetly remove the other scripts contained in '/lib'. The phar is not
mandatory; if you don't want to create and use the phar, edit UploadFile.sh,
and replace 'phar://lib/UploadFile.phar' with 'lib/cli.php' or 'lib/web.php'
as you need.

UploadFile.phar can be executed as standalone script, but the init script is
the recommended way due it contains the User, Password and Project.

If you want to run UploadFile as CGI/HTTP php script, you must edit
UploadFile.sh to remove the shebang, and change the include path from "cli.php"
to "web.php", and rename it to UploadFile.php. For security reasons, ensure
that the UploadFile.phar is inaccesible by the HTTP server (and only by PHP);
only UploadFile.php is used.

# Requiriments:

 * php 5.5 or above, with cURL and finfo
   
   Recommended PECL packages for PHP:
   
   * Imagick or Gmagick (ImageMagick/GraphicsMagic library), to get previews
     for files that GD does not support (like SVG)
     
   * finfo, to get the MIME type for almost all filetypes. Otherwise, MIME will
     be extracted using GD (with limited format support)
 
 * yad 0.27 or above (for UploadFile-yad.sh)
 
Caveats: The both Bash and YAD have a huge issue when handling filenames with spaces (even if them are quoted), interpreting them incorrectly. Meanwhile I find a good solution, the best workarround is replacing every space in the path with underscore ("_"), due MediaWiki converts automatically spaces into underscores. I'm finding a best way to get a GUI using php-qt. For now, the Web fron-t end works correctly.
 
# How it works?

The most relevant parameter is filelist. It can be passed as a regular file, or from the stdin.
The filelist is is a CSV that contains the following fields

'Filename';'Pagename';'Description';'Date';'Source';'Author';'Optional';'License';'Categories'

Important: in order to get fgetcsv() working properly, the CSV input should have a blank line at the end!

In CGI/HTTP mode, the filelist is pased via $_POST from the form (notice that the CGI/HTTP mode is still
in developement and is not ready yet). This mode is similar to UploadWizard but local.

# Screenshots

![Select files](https://github.com/Amitie10g/UploadFile_botclasses.php/blob/master/screenshots/Selecting%20files%20in%20YAD.png?raw=true)
![Information](https://github.com/Amitie10g/UploadFile_botclasses.php/blob/master/screenshots/Adding%20information%20and%20licensing%20with%20YAD.png?raw=true)

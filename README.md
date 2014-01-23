minify_recursive
================

<p>Minify_recursive is a shell script that uses YUICOMPRESSOR to minify all css and js files recursively in a directory.</p>

<p>
<h3>Requirements</h3>
Install YUICOMPRESSOR from https://github.com/yui/yuicompressor <br />
Install Git Bash (Git-1.8.3-preview20130601) http://git-scm.com/download/win
</p>

<p>
  <h3>Installation</h3>
  <ol>
    <li>Configure path to YUICOMPRESSOR_PATH by editing the minify_recursive.sh file</li>
    <li>Create a job for minify_recursive script in run_minify.sh</li>
    <li>Run run_minify.sh from server console or attach this to phpStorm as External Tool using GitBash</li>
    <li>To configure this job as ExternalTools in phpStorm using GitBash/WinBash:
    
    1. Create a new Tool with following settings: <br /><br />
      <code>
      Program: C:\Program Files (x86)\Git\bin\sh.exe <br />
      Parameters: --login -i -c  run_minify.sh <br />
      Working Directory: d:\ <br /> <br />
      </code>
    2. Create a key Shortcut in phpStorm Keymap IDE Settings like CTRL+B for Example <br />
    
    </li>
  </ol>
</p>

<p>
<h3>Here how it works</h3>
I have throwed this shell script into /usr/local/bin
<ul>
  <li><code>minify_recursive css /var/www/html/myproject/css # This will recursively minify all css in your directory </code></li>
  <li><code>minify_recursive js /var/www/html/myproject/js # This will recursively minify all js files in your directory </code></li>
</ul>
</p>

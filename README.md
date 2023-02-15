<h3>Requirements:</h3>
<hr><pre>
<h4>    Python version 3.0.0 or higher.</h4>
</pre>
<hr>
<h3>Docs: </h3>
<pre>
<h4>    Argument Syntax:</h4><br>     Arguments are a way of specifying variables and telling the computer what to do. They must be directly run in the terminal and not specified after running program<br>     Arguments should look like this:<br>         python cypher ([--] or [-])[Argument name] "[Argument value]"
<h4>    Arguments:</h4><h4>       --c:</h4><h5>          usage: python cypher --c [(--t [text]) or text file (--f [file])]</h5><h5>          description: specifies that you would like to cypher/encrypt</h5><h5>          cannot be used with: --d</h5><h4>       --d:</h4><h5>          usage: python cypher --d <ecrypted text (--t [ecrypted text]) or text file (--f [encrypted text file])> [fingerprint (--ft for text or --ftf to get text from a file)]</h5><h5>          description: specifies that you would like to deypher/decrypt</h5><h5>          cannot be used with: --c</h5><h4>        --f:</h4><h5>          usage: python cypher --[operation (--c or --d)] --f [text file]</h5><h5>          description: specifies that you would like to get text from a file (encrypted text when decrypting)</h5><h5>          cannot be used with: --t</h5><h4>        --t:</h4><h5>          usage: python cypher --[operation (--c or --d)] --t <text></h5><h5>          description: specifies that you would like to use plain text (encrypted text when decrypting)</h5><h5>          cannot be used with: --f</h5>

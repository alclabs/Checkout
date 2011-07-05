
<div>
<script>
function triggerAcceptCancel()
{
  addonUtility.changeMade();
}

function passedTest(testName)
{
   var results = document.getElementById("results"+testName);
   results.innerText = "Passed: "+testName;
   results.style.color = "green";
}

var resultValid = false;
function toggleValidity()
{
   resultValid = !resultValid;
   var validButton = document.getElementById("validButton");
   validButton.checked=resultValid;
   
}

function doValidation()
{
   if(!resultValid)
   {
      passedTest("ValidateInvalid"); 
      alert('Check the "Valid?" box');
   }
   else
   {
      passedTest("ValidateValid"); 
   }

   return resultValid;
}

var callbacks = {accept:function(){ passedTest("Accept"); }, 
                 cancel:function(){ passedTest("Cancel"); }, 
                 validate:doValidation};
addonUtility.register(callbacks);

</script>
<button onclick="triggerAcceptCancel()">Make Change</button>&nbsp;&nbsp;
<input type="checkbox" onclick="toggleValidity()" id="validButton" />Valid?
<div id="resultsCancel" style="color:red">Cancel callback failed if this text does not change after "Cancel" is clicked</div>
<div id="resultsValidateInvalid" style="color:red">Invalid validation callback failed if this text does not change after "Accept" is clicked</div>
<div id="resultsValidateValid" style="color:red">Valid validation callback failed if this text does not change after "Accept" is clicked</div>
<div id="resultsAccept" style="color:red">Accept callback failed if this text does not change after "Accept" is clicked</div>
</div>

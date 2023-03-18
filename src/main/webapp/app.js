// Some global variables
var greyBackground = "#8390A2";
var whiteBackground = "#fff";

// Function to display the overlay divs.
function on(x) {
	overlayScreens = document.getElementsByClassName("overlay_screen");
    
	for (var i = 0; i < overlayScreens.length; i++) {
		if (overlayScreens[i].id == x)
			overlayScreens[i].style.display="block";
  	}
  
	if (x == "modify")
		fillDetails();
}

// Function to hide the overlay divs.
function off(x) {
  show = document.getElementsByClassName("overlay_screen");
  show[x].style.display = "none";
}

// ====================================================

// Function to enable/disable action buttons (modify/delete)
function checkedFunc() {
	var elements = document.getElementsByClassName("checkLine");
  	var deleteButton = document.getElementsByClassName("delete_label")[0];
  	var modifyButton = document.getElementsByClassName("modify")[0];
  	
  	var checkedBoxes = 0;
  	
  	for (var i = 0; i < elements.length; i++) {
		if (elements[i].checked == true)
			checkedBoxes++;
  	}
  	
  	if (checkedBoxes == 0)
  	{
		deleteButton.style.cursor="not-allowed";
		deleteButton.style["background-color"] = greyBackground;
		deleteButton.classList.remove("delete_label_hover");
		deleteButton.style["pointer-events"]="none";
	}
	else
	{
		deleteButton.style.cursor="pointer";
    	deleteButton.style["background-color"] = "red";
    	deleteButton.classList.add("delete_label_hover");
    	deleteButton.style["pointer-events"]="auto";
	}
	
	if (checkedBoxes != 1)
	{
		modifyButton.style.cursor="not-allowed";
		modifyButton.style["background-color"] = greyBackground;
		modifyButton.classList.remove('modify_hover');
		modifyButton.disabled = true;
		modifyEnabled = false;
	}
	else
	{
		modifyButton.style.cursor="pointer";
    	modifyButton.style["background-color"] = "green";
    	modifyButton.classList.add('modify_hover');
    	modifyButton.disabled = false;
    	modifyEnabled = true;
	}
} 

// ========================

// Function to fill in the "modify" form
function fillDetails()
{
	// Get the checked checkbox
	var checkBoxes = document.getElementsByClassName("checkLine");
	
	// Get the table rows
	var rows = document.getElementById('data_table').rows;
	
	// Define the checked index
	var checkedIndex;
	
	
	// Getting the checked index
	for (var i = 0; i < checkBoxes.length; i++)
	{
		if (checkBoxes[i].checked)
		{
			checkedIndex = i;
		}
	}
	
	// Get the form info corresponding to the selected row.
	modifyForm = document.getElementById("modify_form").getElementsByClassName("fill_value");

	// Also get the row's cells.
	var tds = rows[checkedIndex + 1].cells;
	
	for (var i = 0; i < tds.length; i++)
	{
		// Fill in the initial text.
		// modifyForm[i].value = tds[i + 1].innerHTML;
		
		if (modifyForm[i].hasAttribute("selected"))
		{
			modifyForm[i].selected = tds[i + 1].selected;
		}
		else
		{
			modifyForm[i].value = tds[i + 1].innerHTML.trim();
		}
	}
}

function fillAcquisitionDetails()
{
	// Get the checked checkbox
	var checkBoxes = document.getElementsByClassName("checkLine");
	
	// Get the table rows
	var rows = document.getElementById('data_table').rows;
	
	// Define the checked index
	var checkedIndex;
	
	
	// Getting the checked index
	for (var i = 0; i < checkBoxes.length; i++)
	{
		if (checkBoxes[i].checked)
		{
			checkedIndex = i;
		}
	}
	
	// Get the form info corresponding to the selected row.
	modifyForm = document.getElementById("modify_form").getElementsByClassName("fill_value");
	console.log(modifyForm);

	// Also get the row's cells.
	var tds = rows[checkedIndex + 1].cells;
	
	for (var i = 0; i < 4; i++)
	{
		// Fill in the initial text.
		if (i == 0)
		{
			modifyForm[i].value = tds[i + 1].innerHTML.trim();
			console.log(modifyForm[i].value)
			continue;
		}
		
		if (modifyForm[i].hasAttribute("selected"))
		{
			modifyForm[i].selected = tds[i + 7].selected;
			console.log(modifyForm[i].selected);
		}
		else
		{
			modifyForm[i].value = tds[i + 7].innerHTML.trim();
			console.log(modifyForm[i].value);
		}
	}
}

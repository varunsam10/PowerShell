$myArray = @(Get-Content C:\Windows_Shell\shell\Computers.txt )   #Creation OF Array and Accepting List of computer from the Test File 
$( 
$(
foreach ($element in $myArray){                                   #Lopping the Array to Find Serial Number,Make ,Modal of Computers
$serial_number = (Get-WMIObject Win32_Bios -ComputerName $element ).SerialNumber
$model_name = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $element).Model
$make_name =  (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $element).Manufacturer
if(!$serial_number){
$serial_number ="The server is Offline"                          #Printing Error Statments if Computer Is Not Available
}
if(!$model_name){
$model_name ="The server is Offline"
}
if(!$make_name){
$make_name ="The server is Offline"
}
New-Object -TypeName PSObject -Property @{                        #Creation of Custom Objects to Print the Headers for CSV Files
      ComputerName = $element
      SerialNumber = $serial_number
      Model = $model_name
      Manufacturer = $make_name
}}) | Select ComputerName,SerialNumber,Model,Manufacturer |
Export-Csv C:\Windows_Shell\Find\SERIAL_MAKE_MODAL.csv -NoTypeInformation -Encoding UTF8   #Exporting CSV File for Serial Serial Number,Make ,Model of Computers
foreach ($element in $myArray) {                                                   #Looping the Array To Find the Services of Workstation
(Get-WMIObject win32_service -ComputerName $element)
New-Object -TypeName PSObject -Property @{
      ComputerName = $element
      }
}
)|select ComputerName,PSComputerName,Name,StartMode,State| 
Export-Csv C:\Windows_Shell\Find\SERVICES.csv -NoTypeInformation -Encoding UTF8   #Exporting Another CSV File for Printing Service of Workstation



# Reference for Syntax of the commands https://ss64.com/ps/

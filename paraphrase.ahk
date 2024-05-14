F7::
{
    ; Ensure the clipboard content is safely encoded for command line usage
    clipboardContent := Clipboard
    StringReplace, clipboardContent, clipboardContent, ",, `",, All  ; Escape double quotes
    StringReplace, clipboardContent, clipboardContent, %A_Space%, %A_Space%, All  ; Escape spaces

    ; Define the path to your Python script
    pythonScriptPath := ".\\paraphrase.py"

    ; Define the command to run your Python script with clipboard content as argument
    command := "python """ . pythonScriptPath . """ """ . clipboardContent . """"

    ; Run the command and capture the output
    RunWait, %ComSpec% /c %command% > output.txt, , Hide

    ; Read the output from the file
    FileRead, output, output.txt
    ; Trim newline characters from the end of the output
    output := RTrim(output, "`n`r")

    ; Send the trimmed output
    Send, %output%

    ; Clean up: Delete the temporary output file
    FileDelete, output.txt
}
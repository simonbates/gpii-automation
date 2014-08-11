Set-PSDebug -Trace 1

# Clone and build GPII

if (Test-Path gpii) {
    rmdir -Recurse -Force gpii
}

mkdir gpii
cd gpii
git clone https://github.com/GPII/windows.git
cd windows
npm install --ignore-scripts=true
grunt build

# Patch jqUnit-node.js

& 'C:\Program Files (x86)\Git\bin\patch.exe' -u ..\node_modules\universal\node_modules\jqUnit\lib\jqUnit-node.js $Home\gpii-automation\jqUnit-node.js.patch

# Run Tests

node tests\acceptanceTests\AcceptanceTests_builtIn.js

exit $LastExitCode

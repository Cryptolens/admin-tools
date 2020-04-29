# Introduction

If you do not want your customers to automatically be able to activate new machines, you can ask their IT dept to send you the list of machine codes of the computers where your software
will run in advance, so that you can activate these on your end. In this folder, we have compiled the scripts that can be useful to support this use case. To sum up, we need to solve two problems:

1. Easily compute the machine code on the end user device.
2. Automatically go through the list and activate all the devices.

## Computing the machine code 
In order to obtain the machine code of the current machine, IT dept can run `machinecodescript.ps1` PowerShell script. It gives the same result as calling [Helpers.GetMachineCodePI()](https://help.cryptolens.io/api/dotnet/api/SKM.V3.Methods.Helpers.html#SKM_V3_Methods_Helpers_GetMachineCodePI) in the [.NET client library](https://github.com/cryptolens/cryptolens-dotnet).

In order to run this script, they may need to change the execution policy to "remote signed", which can be done with the following command:

```
set-executionpolicy remotesigned
```

## Verifying the license key
In the [key verification](https://help.cryptolens.io/examples/key-verification) example, we use Activate to verify a license. This method will automatically activate new machines, as long as the max number of machines limit has not been reached. To prevent activation of new machines, [GetKey](https://help.cryptolens.io/api/dotnet/api/SKM.V3.Methods.Key.html#SKM_V3_Methods_Key_GetKey_System_String_SKM_V3_Models_KeyInfoModel_) method can be used instead. It is called with the same parameters as [Activate](https://help.cryptolens.io/api/dotnet/api/SKM.V3.Methods.Key.html#SKM_V3_Methods_Key_Activate_System_String_SKM_V3_Models_ActivateModel_). The machine code parameter does not need to be provided.

## Script to automatically activate all the machines
A script is currently being developed and will be available soon.
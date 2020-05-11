Add-Type -Language CSharp @"
using System;
using System.Text;
using System.Diagnostics;
using System.Security.Cryptography;

namespace Cryptolens
{
    public class MachineCode
    {
        public static string GetMachineCode()
        {
            return getSHA256(ExecCommand("cmd.exe", "/C wmic csproduct get uuid", 1),1) + "\t" + Environment.MachineName;
        }

        public static string getSHA256(string s, int v = 1)
        {
            using (SHA256 sha256 = new SHA256Managed())
            {
                byte[] hash;
                if (v == 1)
                {
                    hash = sha256.ComputeHash(System.Text.Encoding.Unicode.GetBytes(s));
                    var sb = new StringBuilder(hash.Length * 2);
                    foreach (byte b in hash)
                    {
                        // can be "x2" if you want lowercase
                        sb.Append(b.ToString("X2"));
                    }

                    return sb.ToString();
                }
                else if (v == 2)
                {
                    hash = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(s));
                    var sb = new StringBuilder(hash.Length * 2);
                    foreach (byte b in hash)
                    {
                        // can be "x2" if you want lowercase
                        sb.Append(b.ToString("x2"));
                    }

                    return sb.ToString();
                }
                else
                {
                    throw new ArgumentException("Version can either be 1 or 2.");
                }
                //return Convert.ToBase64String(hash);
            }
        }

        public static string ExecCommand(string fileName, string args, int v = 1)
        {
            if (v == 1)
            {
                var proc = new Process
                {
                    StartInfo = new ProcessStartInfo
                    {
                        FileName = fileName,
                        Arguments = args,
                        UseShellExecute = false,
                        RedirectStandardOutput = true,
                        CreateNoWindow = true,
                    }
                };
                proc.Start();

                StringBuilder sb = new StringBuilder();
                while (!proc.StandardOutput.EndOfStream)
                {
                    string line = proc.StandardOutput.ReadLine();
                    sb.Append(line);
                }

                return sb.ToString();
            }
            else if (v == 2)
            {
                var proc = new Process
                {
                    StartInfo = new ProcessStartInfo
                    {
                        FileName = fileName,
                        Arguments = args,
                        UseShellExecute = false,
                        RedirectStandardOutput = true,
                        CreateNoWindow = true,
                        StandardOutputEncoding = Encoding.UTF8
                    }
                };

                proc.Start();

                proc.WaitForExit();

                var rawOutput = proc.StandardOutput.ReadToEnd();

                return rawOutput.Substring(rawOutput.IndexOf("UUID") + 4).Trim();
            }
            else
            {
                throw new ArgumentException("Version can either be 1 or 2.");
            }

        }
    }
}
"@

$mc = [Cryptolens.MachineCode]::GetMachineCode()
Write-Host $mc

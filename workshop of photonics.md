# workshop of photonics

Ideas:
 - Migrate to .net 6 and WinUI (MAUI) (?)
   - This might be a difficult journey, but we can slowly prepare by moving towards it by updating dependencies, etc.
   - Keep in mind that WinUI only runs on Windows 10.
   - There is a course on migrating WPF from framework to core.
 - Automated testing prep
   - Add dependency injection
   - Consider converting static types to simple types
 - Shadow some person for a day, who is working with our app.
 - 
 - Don't couple UI with controller. Controller/core can be shipped with micro device, while UI can be deployed to any users pc.
 - SCA is a transpiler in one sense, and OpenGL like library in other.
   - We should first define the common language.
   - Then there might be a need for different runtimes, as the transpiled code might be fed to controllers differently.
   - Transpilation should probably be made in visitors, like roslyn is.
 - How should SCA talk to different devices on network?
    - pull/push
    - Direct vs intermediate status service.
    - Status service might have multiple child instances of SCA running.
  
  - Algorithm stuff should be handled in visitors to avoid huge methods where everything is smashed together, like validate method is now hundreds of lines in SCA.MainForm.InnerValidate:4125

## Trinity
   - persisted variables between runs
   - read from popup variable
   - read/write variables on change report to trinity app



## Covid
    - too little time, too little concrete knowledge to do a normal
      implementation
    - hackish stand alone app is fastest, but is functionality enough? will we
      not need any cmds from SCA?
    - hackish implementation in SCA would take more time and would eventually
      require more time as well as it would have to be changed/removed from SCA
      in favor or proper syncaxis implementation



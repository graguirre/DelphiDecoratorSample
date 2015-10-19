stage 'build'
node {
//  bat 'rmdir /s /q 3rd-party'
  git url: 'https://github.com/graguirre/DelphiDepencyExample.git'
  dir('3rd-party/LockBox){
    git url: 'https://github.com/TurboPack/LockBox.git'
  }
  dir('3rd-party/Spring4d'){
    checkout([$class: 'GitSCM',
    branches: [[name: '*/master']],
    doGenerateSubmoduleConfigurations: false,
    extensions: [[$class: 'SparseCheckoutPaths',
    sparseCheckoutPaths: [[path: 'Source/Base'], [path: 'Source/Core'], [path: 'Source/Extensions'], [path: 'Packages/DelphiXE6']]]],
    submoduleCfg: [],
    userRemoteConfigs: [[url: 'https://bitbucket.org/sglienke/spring4d.git']]])
  }
  withEnv(['config=Release']) {
    dir('3rd-party/Spring4d/Packages/DelphiXE6') {
      bat 'call "C:\\Program Files (x86)\\Embarcadero\\Studio\\14.0\\bin\\rsvars.bat" && msbuild /t:build /p:config=%config%;Platform=Win32;DCC_BplOutput=..\\..\\..;DCC_DcpOutput=..\\..\\.. Spring.Base.dproj && msbuild /t:build /p:config=%config%;Platform=Win32;DCC_BplOutput=..\\..\\..;DCC_DcpOutput=..\\..\\.. Spring.Core.dproj'
    }
	
    dir('3rd-party/LockBox/packages/Delphi') {
      bat 'call "C:\\Program Files (x86)\\Embarcadero\\Studio\\14.0\\bin\\rsvars.bat" && msbuild /t:build /p:config=%config%;Platform=Win32;DCC_BplOutput=..\\..\\..;DCC_DcpOutput=..\\..\\.. LockBoxDR.dproj '
    }
	
    bat 'call "C:\\Program Files (x86)\\Embarcadero\\Studio\\14.0\\bin\\rsvars.bat" && msbuild /t:build /p:config=%config%;Platform=Win32 MyBasicPackage.dproj && msbuild /t:build /p:config=%config%;Platform=Win32 MyPackageTester.dproj && msbuild /t:build /p:config=%config%;Platform=Win32 MyBasicApp.dproj'
    bat 'copy 3rd-party\\libs\\*.bpl Win32\\%config%'  
    bat 'Win32\\%config%\\MyBasicApp'
  }

}

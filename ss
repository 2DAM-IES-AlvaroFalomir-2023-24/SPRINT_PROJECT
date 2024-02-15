[1mdiff --git a/.github/workflows/Flutter.yml b/.github/workflows/Flutter.yml[m
[1mdeleted file mode 100644[m
[1mindex 6977c1d..0000000[m
[1m--- a/.github/workflows/Flutter.yml[m
[1m+++ /dev/null[m
[36m@@ -1,72 +0,0 @@[m
[31m-name: Flutter[m
[31m-[m
[31m-on:[m
[31m-  push:[m
[31m-    branches: [main, v*][m
[31m-  pull_request:[m
[31m-    branches: [main, v*][m
[31m-  schedule:[m
[31m-    # https://crontab.guru/#40_10_*_*_*[m
[31m-    - cron: '40 10 * * *'[m
[31m-  workflow_dispatch:[m
[31m-  [m
[31m-jobs:[m
[31m-  test-stable:[m
[31m-    runs-on: ${{ matrix.os }}[m
[31m-    strategy:[m
[31m-      fail-fast: false[m
[31m-      matrix:[m
[31m-        os: [ubuntu-latest, macos-latest, windows-latest][m
[31m-        version:[m
[31m-          - latest[m
[31m-          - 3.3.0[m
[31m-          - 3.0.0[m
[31m-          - 2.10.5[m
[31m-    steps:[m
[31m-      - uses: actions/checkout@v3[m
[31m-[m
[31m-      - uses: ./[m
[31m-        with:[m
[31m-          channel: stable[m
[31m-          version: ${{ matrix.version }}[m
[31m-[m
[31m-      - name: Dart version[m
[31m-        run: dart --version[m
[31m-      - name: Flutter version[m
[31m-        run: flutter --version[m
[31m-      - name: Flutter doctor[m
[31m-        run: flutter doctor[m
[31m-[m
[31m-      - name: Run hello world[m
[31m-        run: |[m
[31m-          echo "main() { print('hello world'); }" > hello.dart[m
[31m-          dart hello.dart[m
[31m-  test-beta:[m
[31m-    runs-on: ${{ matrix.os }}[m
[31m-    strategy:[m
[31m-      fail-fast: false[m
[31m-      matrix:[m
[31m-        os: [ubuntu-latest, macos-latest, windows-latest][m
[31m-        version:[m
[31m-          - latest[m
[31m-          - 3.3.0-0.0.pre[m
[31m-          - 3.1.0[m
[31m-    steps:[m
[31m-      - uses: actions/checkout@v3[m
[31m-[m
[31m-      - uses: ./[m
[31m-        with:[m
[31m-          channel: beta[m
[31m-          version: ${{ matrix.version }}[m
[31m-[m
[31m-      - name: Dart version[m
[31m-        run: dart --version[m
[31m-      - name: Flutter version[m
[31m-        run: flutter --version[m
[31m-      - name: Flutter doctor[m
[31m-        run: flutter doctor[m
[31m-[m
[31m-      - name: Run hello world[m
[31m-        run: |[m
[31m-          echo "main() { print('hello world'); }" > hello.dart[m
[31m-          dart hello.dart[m
[1mdiff --git a/.github/workflows/ISSUE_TEMPLATE/bug_report.yml b/.github/workflows/ISSUE_TEMPLATE/bug_report.yml[m
[1mdeleted file mode 100644[m
[1mindex 405418c..0000000[m
[1m--- a/.github/workflows/ISSUE_TEMPLATE/bug_report.yml[m
[1m+++ /dev/null[m
[36m@@ -1,33 +0,0 @@[m
[31m-name: Bug report[m
[31m-description: File a bug report.[m
[31m-labels: ["bug", "triage"][m
[31m-body:[m
[31m-  - type: checkboxes[m
[31m-    id: is-duplicate[m
[31m-    attributes:[m
[31m-      label: Existing issue?[m
[31m-      options:[m
[31m-        - label: I checked the [existing issues](https://github.com/flutter/gallery/issues)[m
[31m-          required: true[m
[31m-  - type: textarea[m
[31m-    id: what-happened[m
[31m-    attributes:[m
[31m-      label: What happened?[m
[31m-      description: What did you expect to happen? What actually happened? How can we reproduce the issue?[m
[31m-      value: |[m
[31m-        ## Expected vs actual result:[m
[31m-[m
[31m-[m
[31m-        ## Steps to reproduce:[m
[31m-        1.[m
[31m-        1.[m
[31m-        1.[m
[31m-[m
[31m-    validations:[m
[31m-      required: true[m
[31m-  - type: textarea[m
[31m-    id: logs[m
[31m-    attributes:[m
[31m-      label: Relevant log output[m
[31m-      description: Please copy and paste output of `flutter doctor -v` and other relevant logs.[m
[31m-      render: shell[m
[1mdiff --git a/.github/workflows/ISSUE_TEMPLATE/config.yml b/.github/workflows/ISSUE_TEMPLATE/config.yml[m
[1mdeleted file mode 100644[m
[1mindex c3a47f4..0000000[m
[1m--- a/.github/workflows/ISSUE_TEMPLATE/config.yml[m
[1m+++ /dev/null[m
[36m@@ -1,8 +0,0 @@[m
[31m-blank_issues_enabled: false[m
[31m-contact_links:[m
[31m-  - name: Flutter issue[m
[31m-    url: https://github.com/flutter/flutter/issues/new/choose[m
[31m-    about: I'm having an issue with Flutter itself.[m
[31m-  - name: Question[m
[31m-    url: https://stackoverflow.com/questions/tagged/flutter?tab=Frequent[m
[31m-    about: I have a question about Flutter.[m
[1mdiff --git a/.github/workflows/ISSUE_TEMPLATE/feature_request.yml b/.github/workflows/ISSUE_TEMPLATE/feature_request.yml[m
[1mdeleted file mode 100644[m
[1mindex a5d561a..0000000[m
[1m--- a/.github/workflows/ISSUE_TEMPLATE/feature_request.yml[m
[1m+++ /dev/null[m
[36m@@ -1,21 +0,0 @@[m
[31m-name: Feature request[m
[31m-description: Suggest an enhancement.[m
[31m-labels: ["enhancement", "triage"][m
[31m-body:[m
[31m-  - type: textarea[m
[31m-    attributes:[m
[31m-      label: Description[m
[31m-      value: |[m
[31m-        **Is your feature request related to a problem? Please describe.**[m
[31m-        A clear and concise description of what the problem is. Ex. I'm always frustrated when [...][m
[31m-[m
[31m-        **Describe the solution you'd like**[m
[31m-        A clear and concise description of what you want to happen.[m
[31m-[m
[31m-        **Describe alternatives you've considered**[m
[31m-        A clear and concise description of any alternative solutions or features you've considered.[m
[31m-[m
[31m-        **Additional context**[m
[31m-        Add any other context or screenshots about the feature request here.[m
[31m-    validations:[m
[31m-      required: true[m
[1mdiff --git a/.github/workflows/build.yml b/.github/workflows/build.yml[m
[1mdeleted file mode 100644[m
[1mindex 3148ee7..0000000[m
[1m--- a/.github/workflows/build.yml[m
[1m+++ /dev/null[m
[36m@@ -1,37 +0,0 @@[m
[31m-name: Builds[m
[31m-on:[m
[31m-  push:[m
[31m-    branches:[m
[31m-      - main[m
[31m-  pull_request:[m
[31m-[m
[31m-# Declare default permissions as read only.[m
[31m-permissions: read-all[m
[31m-[m
[31m-jobs:[m
[31m-  build:[m
[31m-    name: Build ${{ matrix.target }}[m
[31m-    runs-on: macos-latest[m
[31m-    strategy:[m
[31m-      fail-fast: false[m
[31m-      matrix:[m
[31m-        target: ["apk --debug", "appbundle --debug", "ios --no-codesign", "macos", "web", "ubuntu-latest", "windows"][m
[31m-    steps:[m
[31m-      - name: Set up JDK 11[m
[31m-        uses: actions/setup-java@387ac29b308b003ca37ba93a6cab5eb57c8f5f93 # v4.0.0[m
[31m-        with:[m
[31m-          java-version: 11[m
[31m-          distribution: temurin[m
[31m-      # Set up Flutter.[m
[31m-      - name: Clone Flutter repository with master channel[m
[31m-        uses: subosito/flutter-action@cc97e1648fff6ca5cc647fa67f47e70f7895510b[m
[31m-        with:[m
[31m-          channel: master[m
[31m-      - run: flutter doctor -v[m
[31m-[m
[31m-      # Checkout gallery code and get packages.[m
[31m-      - name: Checkout gallery code[m
[31m-        uses: actions/checkout@b4ffde65f46336ab88eb53be808477a3936bae11 # v4.1.1[m
[31m-      - run: flutter pub get[m
[31m-[m
[31m-      - run: flutter build ${{ matrix.target }}[m
[1mdiff --git a/.github/workflows/codeql.yml b/.github/workflows/codeql.yml[m
[1mdeleted file mode 100644[m
[1mindex ad364b9..0000000[m
[1m--- a/.github/workflows/codeql.yml[m
[1m+++ /dev/null[m
[36m@@ -1,85 +0,0 @@[m
[31m-# For most projects, this workflow file will not need changing; you simply need[m
[31m-# to commit it to your repository.[m
[31m-#[m
[31m-# You may wish to alter this file to override the set of languages analyzed,[m
[31m-# or to provide custom queries or build logic.[m
[31m-#[m
[31m-# ******** NOTE ********[m
[31m-# We have attempted to detect the languages in your repository. Please check[m
[31m-# the `language` matrix defined below to confirm you have the correct set of[m
[31m-# supported CodeQL languages.[m
[31m-#[m
[31m-name: "CodeQL"[m
[31m-[m
[31m-on:[m
[31m-  push:[m
[31m-    branches: [ "main" ][m
[31m-  pull_request:[m
[31m-    branches: [ "main" ][m
[31m-  schedule:[m
[31m-    - cron: '40 20 * * 5'[m
[31m-[m
[31m-jobs:[m
[31m-  analyze:[m
[31m-    name: Analyze[m
[31m-    # Runner size impacts CodeQL analysis time. To learn more, please see:[m
[31m-    #   - https://gh.io/recommended-hardware-resources-for-running-codeql[m
[31m-    #   - https://gh.io/supported-runners-and-hardware-resources[m
[31m-    #   - https://gh.io/using-larger-runners[m
[31m-    # Consider using larger runners for possible analysis time improvements.[m
[31m-    runs-on: ${{ (matrix.language == 'swift' && 'macos-latest') || 'ubuntu-latest' }}[m
[31m-    timeout-minutes: ${{ (matrix.language == 'swift' && 120) || 360 }}[m
[31m-    permissions:[m
[31m-      # required for all workflows[m
[31m-      security-events: write[m
[31m-[m
[31m-      # only required for workflows in private repositories[m
[31m-      actions: read[m
[31m-      contents: read[m
[31m-[m
[31m-    strategy:[m
[31m-      fail-fast: false[m
[31m-      matrix:[m
[31m-        language: [ 'c-cpp', 'java-kotlin', 'swift' ][m
[31m-        # CodeQL supports [ 'c-cpp', 'csharp', 'go', 'java-kotlin', 'javascript-typescript', 'python', 'ruby', 'swift' ][m
[31m-        # Use only 'java-kotlin' to analyze code written in Java, Kotlin or both[m
[31m-        # Use only 'javascript-typescript' to analyze code written in JavaScript, TypeScript or both[m
[31m-        # Learn more about CodeQL language support at https://aka.ms/codeql-docs/language-support[m
[31m-[m
[31m-    steps:[m
[31m-    - name: Checkout repository[m
[31m-      uses: actions/checkout@v4[m
[31m-[m
[31m-    # Initializes the CodeQL tools for scanning.[m
[31m-    - name: Initialize CodeQL[m
[31m-      uses: github/codeql-action/init@v3[m
[31m-      with:[m
[31m-        languages: ${{ matrix.language }}[m
[31m-        # If you wish to specify custom queries, you can do so here or in a config file.[m
[31m-        # By default, queries listed here will override any specified in a config file.[m
[31m-        # Prefix the list here with "+" to use these queries and those in the config file.[m
[31m-[m
[31m-        # For more details on CodeQL's query packs, refer to: https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#using-queries-in-ql-packs[m
[31m-        # queries: security-extended,security-and-quality[m
[31m-[m
[31m-[m
[31m-    # Autobuild attempts to build any compiled languages (C/C++, C#, Go, Java, or Swift).[m
[31m-    # If this step fails, then you should remove it and run the build manually (see below)[m
[31m-    - name: Autobuild[m
[31m-      uses: github/codeql-action/autobuild@v3[m
[31m-[m
[31m-    # ℹ️ Command-line programs to run using the OS shell.[m
[31m-    # 📚 See https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsrun[m
[31m-[m
[31m-    #   If the Autobuild fails above, remove it and uncomment the following three lines.[m
[31m-    #   modify them (or add more) to build your code if your project, please refer to the EXAMPLE below for guidance.[m
[31m-[m
[31m-    # - run: |[m
[31m-    #     echo "Run, Build Application using script"[m
[31m-    #     ./location_of_script_within_repo/buildscript.sh[m
[31m-[m
[31m-    - name: Perform CodeQL Analysis[m
[31m-    - name: AppSweep Mobile Application Security Testing[m
[31m-  # You may pin to the exact commit or the version.[m
[31m-  # uses: Guardsquare/appsweep-action@89964e712facebfc34ac7bf8944b69c8fcf7f04a[m
[31m-      [m
[1mdiff --git a/.github/workflows/dart.yml b/.github/workflows/dart.yml[m
[1mdeleted file mode 100644[m
[1mindex f829a0e..0000000[m
[1m--- a/.github/workflows/dart.yml[m
[1m+++ /dev/null[m
[36m@@ -1,42 +0,0 @@[m
[31m-# This workflow uses actions that are not certified by GitHub.[m
[31m-# They are provided by a third-party and are governed by[m
[31m-# separate terms of service, privacy policy, and support[m
[31m-# documentation.[m
[31m-[m
[31m-name: Dart[m
[31m-[m
[31m-on:[m
[31m-  push:[m
[31m-    branches: [ "main" ][m
[31m-  pull_request:[m
[31m-    branches: [ "main" ][m
[31m-[m
[31m-jobs:[m
[31m-  build:[m
[31m-    runs-on: ubuntu-latest[m
[31m-[m
[31m-    steps:[m
[31m-      - uses: actions/checkout@v3[m
[31m-[m
[31m-      # Note: This workflow uses the latest stable version of the Dart SDK.[m
[31m-      # You can specify other versions if desired, see documentation here:[m
[31m-      # https://github.com/dart-lang/setup-dart/blob/main/README.md[m
[31m-      # - uses: dart-lang/setup-dart@v1[m
[31m-      - uses: dart-lang/setup-dart@9a04e6d73cca37bd455e0608d7e5092f881fd603[m
[31m-[m
[31m-      - name: Install dependencies[m
[31m-        run: flutter pub get[m
[31m-[m
[31m-      # Uncomment this step to verify the use of 'dart format' on each commit.[m
[31m-      # - name: Verify formatting[m
[31m-      #   run: dart format --output=none --set-exit-if-changed .[m
[31m-[m
[31m-      # Consider passing '--fatal-infos' for slightly stricter analysis.[m
[31m-      - name: Analyze project source[m
[31m-        run: dart analyze[m
[31m-[m
[31m-      # Your project will need to have tests in test/ and a dependency on[m
[31m-      # package:test for this step to succeed. Note that Flutter projects will[m
[31m-      # want to change this to 'flutter test'.[m
[31m-      - name: Run tests[m
[31m-        run: dart test[m
[1mdiff --git a/.gitignore b/.gitignore[m
[1mindex 3a83c2f..609c5a0 100644[m
[1m--- a/.gitignore[m
[1m+++ b/.gitignore[m
[36m@@ -12,7 +12,7 @@[m [mpubspec.lock[m
 doc/api/[m
 [m
 # dotenv environment variables file[m
[31m-.env*[m
[32m+[m[32massets/.env[m
 [m
 # Avoid committing generated Javascript files:[m
 *.dart.js[m
[1mdiff --git a/.idea/libraries/Dart_Packages.xml b/.idea/libraries/Dart_Packages.xml[m
[1mindex 5b2db6a..d55af99 100644[m
[1m--- a/.idea/libraries/Dart_Packages.xml[m
[1m+++ b/.idea/libraries/Dart_Packages.xml[m
[36m@@ -9,6 +9,13 @@[m
             </list>[m
           </value>[m
         </entry>[m
[32m+[m[32m        <entry key="bloc">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/bloc-8.1.3/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
         <entry key="boolean_selector">[m
           <value>[m
             <list>[m
[36m@@ -58,10 +65,45 @@[m
             </list>[m
           </value>[m
         </entry>[m
[32m+[m[32m        <entry key="firebase_core">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/firebase_core-2.25.4/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
[32m+[m[32m        <entry key="firebase_core_platform_interface">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/firebase_core_platform_interface-5.0.0/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
[32m+[m[32m        <entry key="firebase_core_web">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/firebase_core_web-2.11.4/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
         <entry key="flutter">[m
           <value>[m
             <list>[m
[31m-              <option value="$USER_HOME$/flutter/packages/flutter/lib" />[m
[32m+[m[32m              <option value="$PROJECT_DIR$/../../../../flutter/packages/flutter/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
[32m+[m[32m        <entry key="flutter_bloc">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/flutter_bloc-8.1.4/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
[32m+[m[32m        <entry key="flutter_dotenv">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/flutter_dotenv-5.1.0/lib" />[m
             </list>[m
           </value>[m
         </entry>[m
[36m@@ -75,7 +117,14 @@[m
         <entry key="flutter_test">[m
           <value>[m
             <list>[m
[31m-              <option value="$USER_HOME$/flutter/packages/flutter_test/lib" />[m
[32m+[m[32m              <option value="$PROJECT_DIR$/../../../../flutter/packages/flutter_test/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
[32m+[m[32m        <entry key="flutter_web_plugins">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$PROJECT_DIR$/../../../../flutter/packages/flutter_web_plugins/lib" />[m
             </list>[m
           </value>[m
         </entry>[m
[36m@@ -86,6 +135,48 @@[m
             </list>[m
           </value>[m
         </entry>[m
[32m+[m[32m        <entry key="google_identity_services_web">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/google_identity_services_web-0.3.0+2/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
[32m+[m[32m        <entry key="google_sign_in">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/google_sign_in-6.2.1/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
[32m+[m[32m        <entry key="google_sign_in_android">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/google_sign_in_android-6.1.21/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
[32m+[m[32m        <entry key="google_sign_in_ios">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/google_sign_in_ios-5.7.3/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
[32m+[m[32m        <entry key="google_sign_in_platform_interface">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/google_sign_in_platform_interface-2.4.5/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
[32m+[m[32m        <entry key="google_sign_in_web">[m
[32m+[m[32m          <value>[m
[32m+[m[32m            <list>[m
[32m+[m[32m              <option value="$USER_HOME$/AppData/Local/Pub/Cache/hosted/pub.dev/google_sign_in_web-0.12.3+2/lib" />[m
[32m+[m[32m            </list>[m
[32m+[m[32m          </value>[m
[32m+[m[32m        </entry>[m
         <entry key="http">[m
           <value>[m
             <list>[m

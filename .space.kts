/**
* JetBrains Space Automation
* This Kotlin-script file lets you automate build activities
* For more info, see https://www.jetbrains.com/help/space/automation.html
*/

job("Build and push phantasus-preimage") {
    docker {
        beforeBuildScript {
            // Create an env variable BRANCH,
            // use env var to get full branch name,
            // leave only the branch name without the 'refs/heads/' path
            content = """
                export BRANCH=${'$'}(echo ${'$'}JB_SPACE_GIT_BRANCH | cut -d'/' -f 3)
                case ${'$'}BRANCH in 
			"master") export LATEST="latest" ;;
			*)  export LATEST="test" ;;
		esac
            """
        }
        build {
            file = "Dockerfile"
            labels["vendor"] = "ctlab"
        }

        push("ctlab.registry.jetbrains.space/p/phantasus/phantasus-containers/phantasus-preimage") {
            // use current job run number and branch name as a tag - '0.run_number-branch_name'
              tags("0.\$JB_SPACE_EXECUTION_NUMBER-\$BRANCH", "\$LATEST")
        }
    }
}

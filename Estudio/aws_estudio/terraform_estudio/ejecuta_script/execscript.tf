resource "terraform_data" "exec-script"{
    lifecycle {
        action_trigger {
            events = [after_create]
            actions = [action.local_command.runscript]
        }

    }
}
action "local_command" "runscript"{
    config {
        command="/bin/bash"
        arguments=["script-ex.sh","italianodev"]
        stdin = jsonencode({
            "entorno" : "desarrollo"
            "manteiner" : "italianodev"
        })
    }
}

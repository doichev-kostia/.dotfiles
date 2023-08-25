function rm
    for arg in $argv
        switch "$arg"
            case "~" "\~/*" "-rf ~" "-rf\~/*" "-rf /"
                echo "Dangerous operation detected. Aborting."
                return 1
        end
    end

    /bin/rm $argv
end

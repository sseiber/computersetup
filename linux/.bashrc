# path alias helpers
PL_PATH_ALIASES=""

function joinByChar() {
    local IFS="$1"
    shift
    echo "$*"
}

function _set_pl_and_path_aliases() {
    local path_alias_file=~/.bash_path_aliases.json
    pl_alias_array=()

    [[ -f ${path_alias_file} ]] && {
        while read -r l; do
            local IFS="="
            read -ra strElements <<<"$l"

            if [ ! -z ${strElements[2]} ]; then
                pl_alias_array+=("${strElements[1]}=${strElements[2]}")
            fi

            eval "alias ${strElements[0]}='cd ${strElements[1]}'"
        done < <(cat ${path_alias_file} | jq -r "."'|keys_unsorted[] as $key|"\($key)=\(.[$key].path)=\(.[$key].plAlias)"')
    } || echo "Error while processing .bash_path_aliases.json"

    PL_PATH_ALIASES=$(joinByChar , "${pl_alias_array[@]}")
}

# powerline prompt
function _update_ps1() {
    PS1="$(powerline-go \
        -colorize-hostname \
        -modules 'kube,venv,host,ssh,cwd,perms,git,hg,exit,root' \
        -error $? \
        -jobs $(jobs -p | wc -l) \
        -path-aliases ${PL_PATH_ALIASES})"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.

    # set "?"
}

[[ "$TERM" != "linux" ]] && [[ -f "$(which powerline-go)" ]] && {
    _set_pl_and_path_aliases
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
}

# aliases
aliases_file=~/.bash_aliases

[[ -f ${aliases_file} ]] && {
    . ${aliases_file}
}

# export helpers
exports_file=~/.bash_exports.json

[[ -f ${exports_file} ]] && {
    while read -r l; do
        eval $l
    done < <(cat ${exports_file} | jq -r "."'|keys_unsorted[] as $key|"export \($key)=\(.[$key])"')
} || echo "Error while processing .bash_exports.json"

function update_exports {
    new_exports=$(jq --arg key "$1" --arg value "$2" '. + {($key): $value}' ${exports_file})
    echo "${new_exports}" >${exports_file}
    export $1=$2
    echo "$1=$2"
}

function unset_export {
    [[ $(jq --arg key "$1" 'has(($key))' ${exports_file}) == true ]] && {
        new_exports=$(jq --arg key "$1" 'del(.[($key)])' ${exports_file})
        echo "${new_exports}" >${exports_file}
        unset $1
        echo "$1 unset"
    } || {
        echo "$1 is not set"
    }
}

# kubectl helpers
function kube_config {
    [[ -f $1 ]] && {
        update_exports KUBECONFIG $1
    } || {
        echo "$1 is not a valid KUBECONFIG"
    }
}

function kube_ns {
    namespace=${1:-default}
    update_exports KUBE_NAMESPACE $namespace
}

function kube {
    namespace=${KUBE_NAMESPACE:-default}

    kubectl -n ${namespace} "$@"
}

# function my-build {
#     launch_build_container --console-name --env API_KEY=${API_KEY} --image cdpxlinux.azurecr.io/user/rtvdev/cluster-infra-build --repo ~/repos/uvs/API-UnifiedVisionService --name uvs-service -p 5000 -p 5001 "$@"
# }

#!/bin/sh
set -e

user=$1

aws iam remove-user-from-group --user-name "$user" --group-name students
echo 'Removed user from students group'

aws iam delete-login-profile --user-name "$user"
echo 'Deleted login profile'

detach_user_policies () {
    user=$1
    policies=$(aws iam list-attached-user-policies --user-name "$user" --output text)
    if [ "$policies" = '' ]; then
        echo 'Skipping detaching user policies'
        return
    fi
    echo 'Detaching user policies...'
    echo "$policies" | while read -r policy; do
        policy_arn=$(echo "$policy" | cut -d '	' -f 2)
        aws iam detach-user-policy --user-name "$user" --policy-arn "$policy_arn"
        echo "Detached user policy: '$policy'"
    done
    echo 'Done detaching user policies'
}

detach_user_policies "$user"

delete_access_keys () {
    user=$1
    access_keys=$(aws iam list-access-keys --user-name "$user" --output text)
    if [ "$access_keys" = '' ]; then
        echo 'Skipping deleting access keys'
        return
    fi
    echo 'Deleting access keys...'
    echo "$access_keys" | while read -r access_key; do
        access_key_id=$(echo "$access_key" | cut -d '	' -f 2)
        aws iam delete-access-key --user-name "$user" --access-key-id "$access_key_id"
        echo "Deleted access key: '$access_key'"
    done
    echo 'Done deleting access keys'
}

delete_access_keys "$user"

aws iam delete-user --user-name "$user"
echo 'Deleted user'

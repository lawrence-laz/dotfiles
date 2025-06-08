selected=$(( 
    find ~/git -maxdepth 4 -type d -o -type d -name "*" ; \
    find ~ -maxdepth 5 -path ~/gdrive -prune -path ~/git -prune -type d -o -type d -name "*"
) | uniq -u | fzf | sed 's/ /\\ /g'    )

if [[ -z $selected ]]; then
    kitty @ close-window
    exit 0
fi

selected_dirname=$(dirname "$selected")
selected_name_part1=$(basename "$selected_dirname")
selected_name_part2=$(basename "$selected")
selected_name_unsanitized="$selected_name_part1 > $selected_name_part2"
selected_name=$(basename "$selected_name_unsanitized" | tr . _ | tr ' ' ' ' | tr '\\' '_')
selected_name_match=${selected_name// /\\s}

temp_tab_id=$(kitty @ ls | jq '.[0].tabs.[]|select(.is_active==true)|.id')

kitty @ focus-tab --match "title:^$selected_name_match"
if [[ $? -ne 0 ]]; then
    # Tab doesn't exist, creating a new one
    kitty @ launch --type tab --cwd "$selected" --tab-title "$selected_name"
fi
kitty @ close-tab --match "id:$temp_tab_id"

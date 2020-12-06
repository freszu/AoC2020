groups = open("input.txt", 'r').read().rstrip().split("\n\n")

pz1 = sum(map(lambda group: len(set(group.replace("\n", ""))), groups))
print(pz1)


def count_answered_by_everyone(group: str):
    members_count = 1 + group.count("\n")
    all_answers = set(group.replace("\n", ""))
    return sum(map(lambda char: group.count(char) == members_count, all_answers))


pz2 = sum(map(lambda group: count_answered_by_everyone(group), groups))
print(pz2)

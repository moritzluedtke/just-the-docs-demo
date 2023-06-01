if __name__ == '__main__':
    print("Type in list 1 (comma seperated): ", end='')
    list_one_raw = input()
    print("Type in list 2 (comma seperated): ", end='')
    list_two_raw = input()

    # create lists from raw string
    list_one = list_one_raw.split(",")
    list_two = list_two_raw.split(",")

    # strip whitespaces in elements
    list_one = [n.strip() for n in list_one]
    list_two = [n.strip() for n in list_two]

    unique_to_list_one = list(set(list_one) - set(list_two))
    unique_to_list_two = list(set(list_two) - set(list_one))
    in_both_lists = list(set(list_one).intersection(list_two))

    print("\n==== Comparison ====")
    print(f"Unique to list 1 {'are' if len(unique_to_list_one) > 1 else 'is'} "
          f"{len(unique_to_list_one)} {'elements' if len(unique_to_list_one) > 1 else 'element'}: "
          f"[{', '.join(unique_to_list_one)}]")
    print(f"Unique to list 2 {'are' if len(unique_to_list_two) > 1 else 'is'} "
          f"{len(unique_to_list_two)} {'elements' if len(unique_to_list_two) > 1 else 'element'}: "
          f"[{', '.join(unique_to_list_two)}]")
    print(f"{len(in_both_lists)} {'elements' if len(in_both_lists) > 1 else 'element'} "
          f"{'are' if len(in_both_lists) > 1 else 'is'} in both lists: "
          f"[{', '.join(in_both_lists)}]")

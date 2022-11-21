def isEnouthRooms(Y: list, R: list, F: int) -> int:
    """
    :param Y: приезды в отель, list(int)
    :param R: отъезды из отеля, list(int)
    :param F: количество комнат в отеле, int

    Предполагается, что Y, R - одного размера
    """
    if len(Y) != len(R):
        return -1

    # Создаем два массива с нулями, размер массивов = последнему дню отъезда
    days_in = [i - i for i in range(R[-1])]
    days_out = [i - i for i in range(R[-1])]

    # Заполняем массивы фактами приезда и отъезда
    for y in Y:
        days_in[y - 1] += 1

    for r in R:
        days_out[r - 1] -= 1

    # Смотрим интегралы прибыли и убыли по людям на каждый день, вычитаем один из другого и сравниваем с количеством комнат
    for i in range(len(days_in) - 1):
        days_in[i + 1] = days_in[i + 1] + days_in[i]
        days_out[i + 1] = days_out[i + 1] + days_out[i]
        if days_in[i] + days_out[i] > F:
            return 0
    # Если ни в один день не было превышения возвращаем True
    return 1


# tests
Y = [1, 3, 5]
R = [2, 6, 8]
for F in range(1, 4):
    result = isEnouthRooms(Y, R, F)
    print(f'F={F}, result: {result}'.format(F, result))

print('')

Y = [1, 1, 1, 1]
R = [2, 3, 4, 5]
for F in range(1, 6):
    result = isEnouthRooms(Y, R, F)
    print(f'F={F}, result: {result}'.format(F, result))

print('')

Y = [1, 2, 3, 4]
R = [2, 3, 4, 5]
for F in range(1, 4):
    result = isEnouthRooms(Y, R, F)
    print(f'F={F}, result: {result}'.format(F, result))

print('')

Y = [1, 2, 3, 4]
R = [1, 2, 3, 4]
for F in range(0, 4):
    result = isEnouthRooms(Y, R, F)
    print(f'F={F}, result: {result}'.format(F, result))

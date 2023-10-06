/**
 ***********************************************************************************
 * @file main.c
 * @author Matěj Křenek <xkrenem00@stud.fit.vutbr.cz>
 * @brief -
 * @date 2023-06-10
 *
 * @copyright Copyright (c) 2023
 ***********************************************************************************
 */

#include <stdio.h>
#include "logger/logger.h"

#define len(arr) sizeof(arr) / sizeof(arr[0])

int main(void)
{
    logger_init(LOG_DEBUG);

    return 0;
}
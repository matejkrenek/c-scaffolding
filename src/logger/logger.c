/**
 ***********************************************************************************
 * @file logger.c
 * @author Matěj Křenek <xkrenem00@stud.fit.vutbr.cz>
 * @brief -
 * @date 2023-06-10
 *
 * @copyright Copyright (c) 2023
 ***********************************************************************************
 */

#include <stdarg.h>
#include <time.h>
#include "logger.h"

static FILE *logFile;
static LogLevel currentLogLevel;

static const char *LogLevelStrings[] = {
    "DEBUG",
    "INFO",
    "WARNING",
    "ERROR",
    "FATAL",
};

static const char *LogLevelColors[] = {
    "\x1B[34m", // Blue
    "\x1B[32m", // Green
    "\x1B[33m", // Yellow
    "\x1B[31m", // Red
    "\x1B[31m", // Red
};

void logger_init(LogLevel logLevel)
{
    currentLogLevel = logLevel;

    // Generate log file name with the current date
    time_t rawtime;
    struct tm *timeinfo;
    char logFileName[64];
    time(&rawtime);
    timeinfo = localtime(&rawtime);
    strftime(logFileName, sizeof(logFileName), "%Y-%m-%d.log", timeinfo);

    // Open the log file for writing
    logFile = fopen(logFileName, "a");
    if (logFile == NULL)
    {
        fprintf(stderr, "Failed to open log file: %s\n", logFileName);
        // You may want to handle this error more gracefully
    }
}

void log_console(LogLevel level, const char *format, ...)
{
    if (level >= currentLogLevel)
    {
        va_list args;
        va_start(args, format);
        fprintf(stderr, "%s[%s] ", LogLevelColors[level], LogLevelStrings[level]);
        vfprintf(stderr, format, args);
        fprintf(stderr, "\x1B[0m");
        va_end(args);
    }
}

void log_file(LogLevel level, const char *file, int line, const char *format, ...)
{
    if (logFile != NULL && level >= currentLogLevel)
    {
        // Get the current date and time
        time_t rawtime;
        struct tm *timeinfo;
        char timestamp[20];
        time(&rawtime);
        timeinfo = localtime(&rawtime);
        strftime(timestamp, sizeof(timestamp), "%Y-%m-%d %H:%M:%S", timeinfo);

        // Write the log message to the file with timestamp, log level, file name, and line number
        fprintf(logFile, "[%s] [%s] [%s:%d]: ", timestamp, LogLevelStrings[level], file, line);

        va_list args;
        va_start(args, format);
        vfprintf(logFile, format, args);
        va_end(args);
    }
}

void logger_cleanup()
{
    if (logFile != NULL)
    {
        fclose(logFile);
        logFile = NULL;
    }
}
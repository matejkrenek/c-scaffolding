/**
 ***********************************************************************************
 * @file logger.h
 * @author Matěj Křenek <xkrenem00@stud.fit.vutbr.cz>
 * @brief -
 * @date 2023-06-10
 *
 * @copyright Copyright (c) 2023
 ***********************************************************************************
 */

#ifndef __LOGGER_H
#define __LOGGER_H

#include <stdio.h>

// Define log levels
typedef enum
{
    LOG_DEBUG,   // Debug messages for detailed debugging information
    LOG_INFO,    // Informational messages about the program's progress
    LOG_WARNING, // Warnings that don't prevent the program from running
    LOG_ERROR,   // Errors that may require attention but don't halt the program
    LOG_FATAL    // Critical errors that cause the program to terminate
} LogLevel;

/**
 * Initialize the logger with a log level and log file.
 *
 * @param logLevel    The minimum log level to be written to the log file.
 */
void logger_init(LogLevel logLevel);

/**
 * Log a message to the console.
 *
 * @param level  The log level of the message.
 * @param format The format string for the log message.
 * @param ...    Additional arguments for the format string.
 */
void log_console(LogLevel level, const char *format, ...);

/**
 * Log a message to the file.
 *
 * @param level  The log level of the message.
 * @param file   The source file name where the log message is generated.
 * @param line   The line number where the log message is generated.
 * @param format The format string for the log message.
 * @param ...    Additional arguments for the format string.
 */
void log_file(LogLevel level, const char *file, int line, const char *format, ...);

/**
 * Clean up and close the logger, releasing any resources.
 */
void logger_cleanup();

/**
 * Macros for logging at different levels.
 *
 * These macros log a message both to the console and the log file
 * if the log level is at or above the specified level.
 */
#define LOG_DEBUG(fmt, ...)                     \
    log_console(LOG_DEBUG, fmt, ##__VA_ARGS__); \
    log_file(LOG_DEBUG, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
#define LOG_INFO(fmt, ...)                     \
    log_console(LOG_INFO, fmt, ##__VA_ARGS__); \
    log_file(LOG_INFO, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
#define LOG_WARNING(fmt, ...)                     \
    log_console(LOG_WARNING, fmt, ##__VA_ARGS__); \
    log_file(LOG_WARNING, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
#define LOG_ERROR(fmt, ...)                     \
    log_console(LOG_ERROR, fmt, ##__VA_ARGS__); \
    log_file(LOG_ERROR, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
#define LOG_FATAL(fmt, ...)                     \
    log_console(LOG_FATAL, fmt, ##__VA_ARGS__); \
    log_file(LOG_FATAL, __FILE__, __LINE__, fmt, ##__VA_ARGS__)

#endif /* __LOGGER_H */
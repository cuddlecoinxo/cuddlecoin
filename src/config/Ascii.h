// Copyright (c) 2018, The TurtleCoin Developers
//
// Please see the included LICENSE file for more information

#pragma once

#include <string>

const std::string windowsAsciiArt = 
"\n \n"
"   _____          _     _ _       _____      _       \n"
"  / ____|        | |   | | |     / ____|    (_)      \n"
" | |    _   _  __| | __| | | ___| |     ___  _ _ __  \n"
" | |   | | | |/ _` |/ _` | |/ _ \ |    / _ \| | '_ \ \n"
" | |___| |_| | (_| | (_| | |  __/ |___| (_) | | | | |\n"
"  \_____\__,_|\__,_|\__,_|_|\___|\_____\___/|_|_| |_|\n";
                                                     
                                                     
;

const std::string nonWindowsAsciiArt =
    "\n                                                                         \n"
" ██████╗██╗   ██╗██████╗ ██████╗ ██╗     ███████╗ ██████╗ ██████╗ ██╗███╗   ██╗\n"
"██╔════╝██║   ██║██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝██╔═══██╗██║████╗  ██║\n"
"██║     ██║   ██║██║  ██║██║  ██║██║     █████╗  ██║     ██║   ██║██║██╔██╗ ██║\n"
"██║     ██║   ██║██║  ██║██║  ██║██║     ██╔══╝  ██║     ██║   ██║██║██║╚██╗██║\n"
"╚██████╗╚██████╔╝██████╔╝██████╔╝███████╗███████╗╚██████╗╚██████╔╝██║██║ ╚████║\n"
"╚═════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ \n";
                                                                               

/* Windows has some characters it won't display in a terminal. If your ascii
   art works fine on Windows and Linux terminals, just replace 'asciiArt' with
   the art itself, and remove these two #ifdefs and above ascii arts */
#ifdef _WIN32

const std::string asciiArt = windowsAsciiArt;

#else
const std::string asciiArt = nonWindowsAsciiArt;
#endif

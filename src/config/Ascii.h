// Copyright (c) 2018, The TurtleCoin Developers
//
// Please see the included LICENSE file for more information

#pragma once

#include <string>

const std::string windowsAsciiArt = 
"   _____          _     _ _       _____      _       "
"  / ____|        | |   | | |     / ____|    (_)      "
" | |    _   _  __| | __| | | ___| |     ___  _ _ __  "
" | |   | | | |/ _` |/ _` | |/ _ \ |    / _ \| | '_ \ "
" | |___| |_| | (_| | (_| | |  __/ |___| (_) | | | | |"
"  \_____\__,_|\__,_|\__,_|_|\___|\_____\___/|_|_| |_|";
                                                     
                                                     
;

const std::string nonWindowsAsciiArt =
    "\n                                                                            \n"
" ██████╗██╗   ██╗██████╗ ██████╗ ██╗     ███████╗ ██████╗ ██████╗ ██╗███╗   ██╗"
"██╔════╝██║   ██║██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝██╔═══██╗██║████╗  ██║"
"██║     ██║   ██║██║  ██║██║  ██║██║     █████╗  ██║     ██║   ██║██║██╔██╗ ██║"
"██║     ██║   ██║██║  ██║██║  ██║██║     ██╔══╝  ██║     ██║   ██║██║██║╚██╗██║"
"╚██████╗╚██████╔╝██████╔╝██████╔╝███████╗███████╗╚██████╗╚██████╔╝██║██║ ╚████║"
"╚═════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝";
                                                                               

/* Windows has some characters it won't display in a terminal. If your ascii
   art works fine on Windows and Linux terminals, just replace 'asciiArt' with
   the art itself, and remove these two #ifdefs and above ascii arts */
#ifdef _WIN32

const std::string asciiArt = windowsAsciiArt;

#else
const std::string asciiArt = nonWindowsAsciiArt;
#endif

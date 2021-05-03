// Copyright (c) 2012-2017, The CryptoNote developers, The Bytecoin developers
// Copyright (c) 2018-2020, The TurtleCoin Developers
// Copyright (c) 2021, The CuddleCoin Developers

//
// Please see the included LICENSE file for more information.

#pragma once

#include <cstddef>
#include <initializer_list>

namespace CryptoNote
{
    struct CheckpointData
    {
        uint32_t index;
        const char *blockId;
    };

    const std::initializer_list<CheckpointData> CHECKPOINTS = {
  { 10000, "84b6345731e2702cdaadc6ce5e5238c4ca5ecf48e3447136b2ed829b8a95f3ad"}
};
      
} // namespace CryptoNote

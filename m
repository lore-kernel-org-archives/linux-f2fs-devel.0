From: Huajun Li <huajun.li.lee@gmail.com>
Subject: [f2fs-dev][PATCH V2 0/6] f2fs: Enable f2fs support inline data
Date: Sun, 10 Nov 2013 23:13:15 +0800
Message-ID: <1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Huajun Li <huajun.li@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Huajun Li <huajun.li@intel.com>

f2fs inode is so large, so small files can be stored directly in the inode,
rather than just storing a single block address and storing the data elsewhere.

This patch set makes files less than ~3.4K store directly in inode block.
a) space saving
   Test with kernel src(without repo data), it can save about 10% space
   with this patch set;
b) performance
   Test this patch set with iozone, there is no obvious performance difference
   with the results of disabling this feature.


V2: - Update f2fs_reserve_block() according to comments on V1
    - Add function f2fs_may_inline() to check whether the file meet 
      inline requirements
    - Try to write inline data to normal data block before clearing it
      from inode block 
    - Change lock scope while converting inline data
    - Add inline_data description to f2fs documentation

Huajun Li (6):
  f2fs: Add flags and helpers to support inline data
  f2fs: Add a new mount option: inline_data
  f2fs: Add a new function: f2fs_reserve_block()
  f2fs: Key functions to handle inline data
  f2fs: Handle inline data operations
  f2fs: update f2fs Documentation

 Documentation/filesystems/f2fs.txt |    2 +
 fs/f2fs/Makefile                   |    2 +-
 fs/f2fs/data.c                     |   97 +++++++++++++-------
 fs/f2fs/f2fs.h                     |   23 +++++
 fs/f2fs/file.c                     |   81 +++++++++--------
 fs/f2fs/inline.c                   |  172 ++++++++++++++++++++++++++++++++++++
 fs/f2fs/super.c                    |    8 +-
 include/linux/f2fs_fs.h            |    8 ++
 8 files changed, 325 insertions(+), 68 deletions(-)
 create mode 100644 fs/f2fs/inline.c

-- 
1.7.9.5


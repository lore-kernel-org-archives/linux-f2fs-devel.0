From: Daniel Rosenberg <drosen@google.com>
Subject: [PATCH v3 0/4] F2FS Checkpointing without GC, related fixes
Date: Wed, 29 May 2019 17:49:02 -0700
Message-ID: <20190530004906.261170-1-drosen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The first patch adjusts the default allowable holes for checkpointing, and
the next two patches fix underflow issues related to inc_valid_block_count
and inc_valid_node_count. The final one adds a new feature for
checkpointing where the user can specify an acceptable amount of space to
lose access to up front in checkpointing=disable mode instead of requiring
garbage collection.

There is still a question around what to do when the current reserved
space is less than reserved. As it stands, when a block is deleted, if it
was an old block, the space is not actually given back, and is marked as
unusable. But current reserve may still rise towards reserve, which would
make freeing one block result in a net loss of one block, as opposed to no
change. Reserved and unusable serve the same function, so it may make
sense to just handle it as max(current_reserved, unusable), which
effectively removes the double counting. I'm leaving that until later.

Changes from v2:
Adjust threshold for initial unusable blocks
Patches to fix underflows
Added option to set a block limit in addition to a percent for initial
unusable space

Daniel Rosenberg (4):
  f2fs: Lower threshold for disable_cp_again
  f2fs: Fix root reserved on remount
  f2fs: Fix accounting for unusable blocks
  f2fs: Add option to limit required GC for checkpoint=disable

 Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++
 Documentation/filesystems/f2fs.txt      | 19 +++++++-
 fs/f2fs/f2fs.h                          | 22 ++++++---
 fs/f2fs/segment.c                       | 21 +++++++--
 fs/f2fs/super.c                         | 62 ++++++++++++++++---------
 fs/f2fs/sysfs.c                         | 16 +++++++
 6 files changed, 115 insertions(+), 33 deletions(-)

-- 
2.22.0.rc1.257.g3120a18244-goog

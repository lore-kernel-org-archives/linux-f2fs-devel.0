From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 047/186] f2fs: fix to do sanity check
 on free nid
Date: Sat,  1 Jun 2019 09:14:23 -0400
Message-ID: <20190601131653.24205-47-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1hX3uM-0000qD-Kt
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Jun 2019 13:18:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hX3uL-00EBxA-CK
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Jun 2019 13:18:50 +0000
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 626bcf2b7ce87211dba565f2bfa7842ba5be5c1b ]

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203225

- Overview
When mounting the attached crafted image and unmounting it, following errors are reported.
Additionally, it hangs on sync after unmounting.

The image is intentionally fuzzed from a normal f2fs image for testing.
Compile options for F2FS are as follows.
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_CHECK_FS=y

- Reproduces
mkdir test
mount -t f2fs tmp.img test
touch test/t
umount test
sync

- Messages
 kernel BUG at fs/f2fs/node.c:3073!
 RIP: 0010:f2fs_destroy_node_manager+0x2f0/0x300
 Call Trace:
  f2fs_put_super+0xf4/0x270
  generic_shutdown_super+0x62/0x110
  kill_block_super+0x1c/0x50
  kill_f2fs_super+0xad/0xd0
  deactivate_locked_super+0x35/0x60
  cleanup_mnt+0x36/0x70
  task_work_run+0x75/0x90
  exit_to_usermode_loop+0x93/0xa0
  do_syscall_64+0xba/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0010:f2fs_destroy_node_manager+0x2f0/0x300

NAT table is corrupted, so reserved meta/node inode ids were added into
free list incorrectly, during file creation, since reserved id has cached
in inode hash, so it fails the creation and preallocated nid can not be
released later, result in kernel panic.

To fix this issue, let's do nid boundary check during free nid loading.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d45ecef751165..63bb6134d39ae 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2082,6 +2082,9 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
 	if (unlikely(nid == 0))
 		return false;
 
+	if (unlikely(f2fs_check_nid_range(sbi, nid)))
+		return false;
+
 	i = f2fs_kmem_cache_alloc(free_nid_slab, GFP_NOFS);
 	i->nid = nid;
 	i->state = FREE_NID;
-- 
2.20.1

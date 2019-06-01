From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 034/141] f2fs: fix to avoid panic in
 do_recover_data()
Date: Sat,  1 Jun 2019 09:20:10 -0400
Message-ID: <20190601132158.25821-34-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1hX3yi-0001CL-QB
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Jun 2019 13:23:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hX3yh-00EcRf-EI
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Jun 2019 13:23:20 +0000
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
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

[ Upstream commit 22d61e286e2d9097dae36f75ed48801056b77cac ]

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203227

- Overview
When mounting the attached crafted image, following errors are reported.
Additionally, it hangs on sync after trying to mount it.

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
sync

- Messages
 kernel BUG at fs/f2fs/recovery.c:549!
 RIP: 0010:recover_data+0x167a/0x1780
 Call Trace:
  f2fs_recover_fsync_data+0x613/0x710
  f2fs_fill_super+0x1043/0x1aa0
  mount_bdev+0x16d/0x1a0
  mount_fs+0x4a/0x170
  vfs_kern_mount+0x5d/0x100
  do_mount+0x200/0xcf0
  ksys_mount+0x79/0xc0
  __x64_sys_mount+0x1c/0x20
  do_syscall_64+0x43/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

During recovery, if ofs_of_node is inconsistent in between recovered
node page and original checkpointed node page, let's just fail recovery
instead of making kernel panic.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index ae0e5f2e67b4a..bf5c5f4fa77ea 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -485,7 +485,15 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		goto err;
 
 	f2fs_bug_on(sbi, ni.ino != ino_of_node(page));
-	f2fs_bug_on(sbi, ofs_of_node(dn.node_page) != ofs_of_node(page));
+
+	if (ofs_of_node(dn.node_page) != ofs_of_node(page)) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"Inconsistent ofs_of_node, ino:%lu, ofs:%u, %u",
+			inode->i_ino, ofs_of_node(dn.node_page),
+			ofs_of_node(page));
+		err = -EFAULT;
+		goto err;
+	}
 
 	for (; start < end; start++, dn.ofs_in_node++) {
 		block_t src, dest;
-- 
2.20.1

From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 045/173] f2fs: fix to clear dirty
 inode in error path of f2fs_iget()
Date: Sat,  1 Jun 2019 09:17:17 -0400
Message-ID: <20190601131934.25053-45-sashal@kernel.org>
References: <20190601131934.25053-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1hX3ww-00011i-9K
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Jun 2019 13:21:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hX3wv-00EcGf-0h
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Jun 2019 13:21:30 +0000
In-Reply-To: <20190601131934.25053-1-sashal@kernel.org>
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

[ Upstream commit 546d22f070d64a7b96f57c93333772085d3a5e6d ]

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203217

- Overview
When mounting the attached crafted image and running program, I got this error.
Additionally, it hangs on sync after running the program.

The image is intentionally fuzzed from a normal f2fs image for testing and I enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
cc poc_test_05.c
mkdir test
mount -t f2fs tmp.img test
sudo ./a.out
sync

- Messages
 kernel BUG at fs/f2fs/inode.c:707!
 RIP: 0010:f2fs_evict_inode+0x33f/0x3a0
 Call Trace:
  evict+0xba/0x180
  f2fs_iget+0x598/0xdf0
  f2fs_lookup+0x136/0x320
  __lookup_slow+0x92/0x140
  lookup_slow+0x30/0x50
  walk_component+0x1c1/0x350
  path_lookupat+0x62/0x200
  filename_lookup+0xb3/0x1a0
  do_readlinkat+0x56/0x110
  __x64_sys_readlink+0x16/0x20
  do_syscall_64+0x43/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

During inode loading, __recover_inline_status() can recovery inode status
and set inode dirty, once we failed in following process, it will fail
the check in f2fs_evict_inode, result in trigger BUG_ON().

Let's clear dirty inode in error path of f2fs_iget() to avoid panic.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index bec52961630b9..8c8d40e07ebaf 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -473,6 +473,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	return inode;
 
 bad_inode:
+	f2fs_inode_synced(inode);
 	iget_failed(inode);
 	trace_f2fs_iget_exit(inode, ret);
 	return ERR_PTR(ret);
-- 
2.20.1

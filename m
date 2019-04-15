From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 05/13] f2fs: fix to avoid panic in
 f2fs_remove_inode_page()
Date: Mon, 15 Apr 2019 15:28:34 +0800
Message-ID: <20190415072842.2438-5-yuchao0@huawei.com>
References: <20190415072842.2438-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hFw31-0004vn-Ed
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 07:28:59 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hFw2z-007Pwg-QJ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 07:28:59 +0000
In-Reply-To: <20190415072842.2438-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203219

- Overview
When mounting the attached crafted image and running program, I got this error.
Additionally, it hangs on sync after running the program.

The image is intentionally fuzzed from a normal f2fs image for testing and I enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
cc poc_06.c
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out
sync

- Messages
 kernel BUG at fs/f2fs/node.c:1183!
 RIP: 0010:f2fs_remove_inode_page+0x294/0x2d0
 Call Trace:
  f2fs_evict_inode+0x2a3/0x3a0
  evict+0xba/0x180
  __dentry_kill+0xbe/0x160
  dentry_kill+0x46/0x180
  dput+0xbb/0x100
  do_renameat2+0x3c9/0x550
  __x64_sys_rename+0x17/0x20
  do_syscall_64+0x43/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

The reason is f2fs_remove_inode_page() will trigger kernel panic due to
inconsistent i_blocks value of inode.

To avoid panic, let's just print debug message and set SBI_NEED_FSCK to
give a hint to fsck for latter repairing of potential image corruption.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b2c496c62921..58073c5bd221 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1185,8 +1185,13 @@ int f2fs_remove_inode_page(struct inode *inode)
 		f2fs_put_dnode(&dn);
 		return -EIO;
 	}
-	f2fs_bug_on(F2FS_I_SB(inode),
-			inode->i_blocks != 0 && inode->i_blocks != 8);
+
+	if (inode->i_blocks != 0 && inode->i_blocks != 8) {
+		f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
+			"Inconsistent i_blocks, ino:%lu, iblocks:%zu",
+			inode->i_ino, inode->i_blocks);
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+	}
 
 	/* will put inode & node pages */
 	err = truncate_node(&dn);
-- 
2.18.0.rc1

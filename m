From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid panic when encountering
 corrupt node
Date: Wed, 7 Jun 2017 11:17:35 +0800
Message-ID: <20170607031735.8575-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dIRTw-0004Iw-1F
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Jun 2017 03:18:04 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dIRTu-000328-BX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Jun 2017 03:18:04 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

With fault_injection option, generic/361 of fstests will complain us
with below message:

Call Trace:
 get_node_page+0x12/0x20 [f2fs]
 f2fs_iget+0x92/0x7d0 [f2fs]
 f2fs_fill_super+0x10fb/0x15e0 [f2fs]
 mount_bdev+0x184/0x1c0
 f2fs_mount+0x15/0x20 [f2fs]
 mount_fs+0x39/0x150
 vfs_kern_mount+0x67/0x110
 do_mount+0x1bb/0xc70
 SyS_mount+0x83/0xd0
 do_syscall_64+0x6e/0x160
 entry_SYSCALL64_slow_path+0x25/0x25

Since mkfs loop device in f2fs partition can be failed silently due to
checkpoint error injection, so root inode page can be corrupted, in order
to avoid needless panic, in get_node_page, it's better to leave message
and return error to caller, and let fsck repaire it later.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 05700e54f91e..f522378224aa 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1157,6 +1157,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
 	} else if (err == LOCKED_PAGE) {
+		err = 0;
 		goto page_hit;
 	}
 
@@ -1170,15 +1171,22 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 		goto repeat;
 	}
 
-	if (unlikely(!PageUptodate(page)))
+	if (unlikely(!PageUptodate(page))) {
+		err = -EIO;
 		goto out_err;
+	}
 page_hit:
 	if(unlikely(nid != nid_of_node(page))) {
-		f2fs_bug_on(sbi, 1);
+		f2fs_msg(sbi->sb, KERN_WARNING, "inconsistent node block, "
+			"nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
+			nid, nid_of_node(page), ino_of_node(page),
+			ofs_of_node(page), cpver_of_node(page),
+			next_blkaddr_of_node(page));
 		ClearPageUptodate(page);
+		err = -EINVAL;
 out_err:
 		f2fs_put_page(page, 1);
-		return ERR_PTR(-EIO);
+		return ERR_PTR(err);
 	}
 	return page;
 }
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

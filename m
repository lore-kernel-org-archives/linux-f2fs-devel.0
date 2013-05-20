From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 01/15] f2fs: remove redundant assignment
Date: Mon, 20 May 2013 12:32:15 +0900
Message-ID: <1369020743-18520-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UeGr1-00060W-9H
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 03:33:43 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UeGqz-000513-3S for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 03:33:43 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN2000TKV7K42I0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 12:33:34 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We don't need to assign a value redundantly.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/recovery.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 60c8a50..2941987 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -126,7 +126,6 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 
 		entry = get_fsync_inode(head, ino_of_node(page));
 		if (entry) {
-			entry->blkaddr = blkaddr;
 			if (IS_INODE(page) && is_dent_dnode(page))
 				set_inode_flag(F2FS_I(entry->inode),
 							FI_INC_LINK);
@@ -150,10 +149,10 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 				kmem_cache_free(fsync_entry_slab, entry);
 				goto unlock_out;
 			}
-
 			list_add_tail(&entry->list, head);
-			entry->blkaddr = blkaddr;
 		}
+		entry->blkaddr = blkaddr;
+
 		if (IS_INODE(page)) {
 			err = recover_inode(entry->inode, page);
 			if (err == -ENOENT) {
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d

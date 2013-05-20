From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 1/2] f2fs: remove unnecessary kmap/kunmap
	operations
Date: Mon, 20 May 2013 12:16:06 +0900
Message-ID: <1369019767-17321-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UeGbG-0007Ug-Re
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 03:17:26 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UeGbE-00027D-U1 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 03:17:26 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN200HGTUGPS6J0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 12:17:18 +0900 (KST)
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

The allocated page used by the recovery is not on HIGHMEM, so that we don't
need to use kmap/kunmap.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/recovery.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 774efdb..5fcdd08 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -40,11 +40,11 @@ static struct fsync_inode_entry *get_fsync_inode(struct list_head *head,
 
 static int recover_dentry(struct page *ipage, struct inode *inode)
 {
-	struct f2fs_node *raw_node = (struct f2fs_node *)kmap(ipage);
+	void *kaddr = page_address(ipage);
+	struct f2fs_node *raw_node = (struct f2fs_node *)kaddr;
 	struct f2fs_inode *raw_inode = &(raw_node->i);
 	nid_t pino = le32_to_cpu(raw_inode->i_pino);
 	struct qstr name;
-	struct f2fs_dir_entry *de;
 	struct page *page;
 	struct inode *dir;
 	int err = 0;
@@ -62,8 +62,7 @@ static int recover_dentry(struct page *ipage, struct inode *inode)
 	name.len = le32_to_cpu(raw_inode->i_namelen);
 	name.name = raw_inode->i_name;
 
-	de = f2fs_find_entry(dir, &name, &page);
-	if (de) {
+	if (f2fs_find_entry(dir, &name, &page)) {
 		kunmap(page);
 		f2fs_put_page(page, 0);
 	} else {
@@ -73,7 +72,6 @@ out:
 	f2fs_msg(inode->i_sb, KERN_NOTICE, "recover_inode and its dentry: "
 			"ino = %x, name = %s, dir = %lx, err = %d",
 			ino_of_node(ipage), raw_inode->i_name, dir->i_ino, err);
-	kunmap(ipage);
 	return err;
 }
 
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d

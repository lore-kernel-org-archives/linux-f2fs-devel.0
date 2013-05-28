From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 2/3] f2fs: fix dentry recovery routine
Date: Tue, 28 May 2013 10:19:44 +0900
Message-ID: <1369703985-26284-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1369703985-26284-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Uh8bA-00080U-Ud
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 May 2013 01:21:12 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uh8b8-0002Pu-8I for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 May 2013 01:21:12 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MNH00H58IEW3DB0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 May 2013 10:21:00 +0900 (KST)
In-reply-to: <1369703985-26284-1-git-send-email-jaegeuk.kim@samsung.com>
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

The error scenario is:
1. create /a
(1.a link /a /b)
2. sync
3. unlinke /a
4. create /a
5. fsync /a
6. Sudden power-off

When the f2fs recovers the fsynced dentry, /a, we discover an exsiting dentry at
f2fs_find_entry() in recover_dentry().

In such the case, we should unlink the existing dentry and its inode
and then recover newly created dentry.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/recovery.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 0dd2ce1..85f5e54 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -44,9 +44,10 @@ static int recover_dentry(struct page *ipage, struct inode *inode)
 	struct f2fs_node *raw_node = (struct f2fs_node *)kaddr;
 	struct f2fs_inode *raw_inode = &(raw_node->i);
 	nid_t pino = le32_to_cpu(raw_inode->i_pino);
+	struct f2fs_dir_entry *de;
 	struct qstr name;
 	struct page *page;
-	struct inode *dir;
+	struct inode *dir, *einode;
 	int err = 0;
 
 	dir = check_dirty_dir_inode(F2FS_SB(inode->i_sb), pino);
@@ -61,13 +62,21 @@ static int recover_dentry(struct page *ipage, struct inode *inode)
 
 	name.len = le32_to_cpu(raw_inode->i_namelen);
 	name.name = raw_inode->i_name;
-
-	if (f2fs_find_entry(dir, &name, &page)) {
-		kunmap(page);
-		f2fs_put_page(page, 0);
-	} else {
-		err = __f2fs_add_link(dir, &name, inode);
+retry:
+	de = f2fs_find_entry(dir, &name, &page);
+	if (de) {
+		einode = f2fs_iget(inode->i_sb, le32_to_cpu(de->ino));
+		if (IS_ERR(einode)) {
+			WARN_ON(1);
+			if (PTR_ERR(einode) == -ENOENT)
+				err = -EEXIST;
+			goto out;
+		}
+		f2fs_delete_entry(de, page, einode);
+		iput(einode);
+		goto retry;
 	}
+	err = __f2fs_add_link(dir, &name, inode);
 out:
 	f2fs_msg(inode->i_sb, KERN_NOTICE, "recover_inode and its dentry: "
 			"ino = %x, name = %s, dir = %lx, err = %d",
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may

From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: update file name in the inode block during
	f2fs_rename
Date: Thu, 18 Jul 2013 18:11:23 +0900
Message-ID: <1374138684-28520-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UzkFY-0005Ov-3G
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Jul 2013 09:11:48 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UzkFV-0003N5-V8 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Jul 2013 09:11:48 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MQ4000FKK754JG0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Jul 2013 18:11:39 +0900 (KST)
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

The error is reproducible by:

After this, when we retrieve the inode->i_name of test2 by dump.f2fs, we get
test1 instead of test2.
This is because f2fs didn't update the file name during the f2fs_rename.

So, this patch fixes that.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/dir.c   | 15 +++++++++++++++
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/namei.c |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 89ecb37..d1bb260 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -276,6 +276,21 @@ static void init_dent_inode(const struct qstr *name, struct page *ipage)
 	set_page_dirty(ipage);
 }
 
+int update_dent_inode(struct inode *inode, const struct qstr *name)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	struct page *page;
+
+	page = get_node_page(sbi, inode->i_ino);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	init_dent_inode(name, page);
+	f2fs_put_page(page, 1);
+
+	return 0;
+}
+
 static int make_empty_dir(struct inode *inode,
 		struct inode *parent, struct page *page)
 {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2dfd584..a6858c7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -953,6 +953,7 @@ struct f2fs_dir_entry *f2fs_parent_dir(struct inode *, struct page **);
 ino_t f2fs_inode_by_name(struct inode *, struct qstr *);
 void f2fs_set_link(struct inode *, struct f2fs_dir_entry *,
 				struct page *, struct inode *);
+int update_dent_inode(struct inode *, const struct qstr *);
 int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *);
 void f2fs_delete_entry(struct f2fs_dir_entry *, struct page *, struct inode *);
 int f2fs_make_empty(struct inode *, struct inode *);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 64c0716..3297278 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -427,6 +427,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (!new_entry)
 			goto out_dir;
 
+		if (update_dent_inode(old_inode, &new_dentry->d_name)) {
+			f2fs_put_page(new_page, 1);
+			goto out_dir;
+		}
+
 		f2fs_set_link(new_dir, new_entry, new_page, old_inode);
 
 		new_inode->i_ctime = CURRENT_TIME;
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk

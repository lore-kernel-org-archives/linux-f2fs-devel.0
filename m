From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/5] f2fs: introduce get_dirty_dents for
	readability
Date: Wed, 19 Mar 2014 09:24:21 +0900
Message-ID: <1395188665-4175-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WQ4Kx-0007RP-7s
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 00:26:27 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WQ4Kw-0006IK-8M
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 00:26:27 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N2N000TVQJQO310@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 09:26:14 +0900 (KST)
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

The get_dirty_dents gives us the number of dirty dentry pages.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 fs/f2fs/f2fs.h       | 5 +++++
 fs/f2fs/inode.c      | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 911b6f9..4c0e98d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -619,7 +619,7 @@ void remove_dirty_dir_inode(struct inode *inode)
 		return;
 
 	spin_lock(&sbi->dir_inode_lock);
-	if (atomic_read(&F2FS_I(inode)->dirty_dents)) {
+	if (get_dirty_dents(inode)) {
 		spin_unlock(&sbi->dir_inode_lock);
 		return;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 292cc3c..59fac1a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -704,6 +704,11 @@ static inline int get_pages(struct f2fs_sb_info *sbi, int count_type)
 	return atomic_read(&sbi->nr_pages[count_type]);
 }
 
+static inline int get_dirty_dents(struct inode *inode)
+{
+	return atomic_read(&F2FS_I(inode)->dirty_dents);
+}
+
 static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block_type)
 {
 	unsigned int pages_per_sec = sbi->segs_per_sec *
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d518e37..0d8e4a2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -273,7 +273,7 @@ void f2fs_evict_inode(struct inode *inode)
 			inode->i_ino == F2FS_META_INO(sbi))
 		goto no_delete;
 
-	f2fs_bug_on(atomic_read(&F2FS_I(inode)->dirty_dents));
+	f2fs_bug_on(get_dirty_dents(inode));
 	remove_dirty_dir_inode(inode);
 
 	if (inode->i_nlink || is_bad_inode(inode))
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech

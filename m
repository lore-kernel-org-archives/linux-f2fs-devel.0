From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: check lower bound nid value in
 check_nid_range
Date: Thu, 12 Jun 2014 13:23:41 +0800
Message-ID: <000001cf85fe$9e63ed10$db2bc730$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WuxVO-0007iF-Ke
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jun 2014 05:24:54 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WuxVL-00042D-4i
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jun 2014 05:24:54 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N7100701J17IB00@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jun 2014 14:24:43 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch add lower bound verification for nid in check_nid_range, so nids
reserved like 0, node, meta passed by caller could be checked there.

And then check_nid_range could be used in f2fs_nfs_get_inode for simplifying
code.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h  |    3 ++-
 fs/f2fs/inode.c |    1 +
 fs/f2fs/super.c |    4 +---
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7ef7acd..58df97e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -641,7 +641,8 @@ static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
  */
 static inline int check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
 {
-	WARN_ON((nid >= NM_I(sbi)->max_nid));
+	if (unlikely(nid < F2FS_ROOT_INO(sbi)))
+		return -EINVAL;
 	if (unlikely(nid >= NM_I(sbi)->max_nid))
 		return -EINVAL;
 	return 0;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index adc622c..2cf6962 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -78,6 +78,7 @@ static int do_read_inode(struct inode *inode)
 	if (check_nid_range(sbi, inode->i_ino)) {
 		f2fs_msg(inode->i_sb, KERN_ERR, "bad inode number: %lu",
 			 (unsigned long) inode->i_ino);
+		WARN_ON(1);
 		return -EINVAL;
 	}
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b2b1863..8f96d93 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -689,9 +689,7 @@ static struct inode *f2fs_nfs_get_inode(struct super_block *sb,
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct inode *inode;
 
-	if (unlikely(ino < F2FS_ROOT_INO(sbi)))
-		return ERR_PTR(-ESTALE);
-	if (unlikely(ino >= NM_I(sbi)->max_nid))
+	if (check_nid_range(sbi, ino))
 		return ERR_PTR(-ESTALE);
 
 	/*
-- 
1.7.9.5



------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems

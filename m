From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: introduce help macro ADDRS_PER_PAGE()
Date: Sat, 26 Apr 2014 19:59:52 +0800
Message-ID: <004901cf6147$21bed300$653c7900$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1We1Hh-00089B-Mh
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Apr 2014 12:00:45 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1We1Hf-0005DA-MJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Apr 2014 12:00:45 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N4N00CIX00ZQJB0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Apr 2014 21:00:35 +0900 (KST)
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
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce help macro ADDRS_PER_PAGE() to get the number of address pointers in
direct node or inode.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c          |    6 ++----
 fs/f2fs/file.c          |    5 +----
 fs/f2fs/recovery.c      |    5 +----
 include/linux/f2fs_fs.h |    3 +++
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 150c12a..6daef54 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -652,8 +652,7 @@ static int get_data_block(struct inode *inode, sector_t iblock,
 		goto put_out;
 	}
 
-	end_offset = IS_INODE(dn.node_page) ?
-			ADDRS_PER_INODE(F2FS_I(inode)) : ADDRS_PER_BLOCK;
+	end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 	bh_result->b_size = (((size_t)1) << blkbits);
 	dn.ofs_in_node++;
 	pgofs++;
@@ -675,8 +674,7 @@ get_next:
 		if (dn.data_blkaddr == NEW_ADDR)
 			goto put_out;
 
-		end_offset = IS_INODE(dn.node_page) ?
-			ADDRS_PER_INODE(F2FS_I(inode)) : ADDRS_PER_BLOCK;
+		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 	}
 
 	if (maxblocks > (bh_result->b_size >> blkbits)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 60e7d54..bb365c9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -288,10 +288,7 @@ int truncate_blocks(struct inode *inode, u64 from)
 		return err;
 	}
 
-	if (IS_INODE(dn.node_page))
-		count = ADDRS_PER_INODE(F2FS_I(inode));
-	else
-		count = ADDRS_PER_BLOCK;
+	count = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 
 	count -= dn.ofs_in_node;
 	f2fs_bug_on(count < 0);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 9eb6487..be1e3e8 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -301,10 +301,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		goto out;
 
 	start = start_bidx_of_node(ofs_of_node(page), fi);
-	if (IS_INODE(page))
-		end = start + ADDRS_PER_INODE(fi);
-	else
-		end = start + ADDRS_PER_BLOCK;
+	end = start + ADDRS_PER_PAGE(page, fi);
 
 	f2fs_lock_op(sbi);
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index df53e17..8c03f71 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -146,6 +146,9 @@ struct f2fs_extent {
 #define ADDRS_PER_BLOCK		1018	/* Address Pointers in a Direct Block */
 #define NIDS_PER_BLOCK		1018	/* Node IDs in an Indirect Block */
 
+#define ADDRS_PER_PAGE(page, fi)	\
+	(IS_INODE(page) ? ADDRS_PER_INODE(fi) : ADDRS_PER_BLOCK)
+
 #define	NODE_DIR1_BLOCK		(DEF_ADDRS_PER_INODE + 1)
 #define	NODE_DIR2_BLOCK		(DEF_ADDRS_PER_INODE + 2)
 #define	NODE_IND1_BLOCK		(DEF_ADDRS_PER_INODE + 3)
-- 
1.7.9.5



------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform

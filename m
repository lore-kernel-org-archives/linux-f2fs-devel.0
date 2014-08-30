From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 10/17] fsck.f2fs: add fixing messeages
Date: Fri, 29 Aug 2014 17:28:57 -0700
Message-ID: <1409358544-54740-10-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWY7-0005RQ-IJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:47 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWY6-0001ku-PA for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:47 +0000
In-Reply-To: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 9 +++++++++
 include/f2fs_fs.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 17cf29b..00f5b27 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -344,6 +344,9 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 					node_blk->i.i_links =
 						cpu_to_le32(i_links + 1);
 					need_fix = 1;
+					FIX_MSG("File: 0x%x "
+						"i_links= 0x%x -> 0x%x",
+						nid, i_links, i_links + 1);
 				}
 			}
 			/* No need to go deep into the node */
@@ -375,6 +378,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			} else if (config.fix_cnt) {
 				node_blk->i.i_addr[idx] = 0;
 				need_fix = 1;
+				FIX_MSG("[0x%x] i_addr[%d] = 0", nid, idx);
 			}
 		}
 	}
@@ -399,6 +403,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			} else if (config.fix_cnt) {
 				node_blk->i.i_nid[idx] = 0;
 				need_fix = 1;
+				FIX_MSG("[0x%x] i_nid[%d] = 0", nid, idx);
 			}
 		}
 	}
@@ -421,6 +426,8 @@ check:
 		if (config.fix_cnt) {
 			node_blk->i.i_blocks = cpu_to_le64(*blk_cnt);
 			need_fix = 1;
+			FIX_MSG("[0x%x] i_blocks=0x%lx -> 0x%x",
+					nid, i_blocks, *blk_cnt);
 		}
 	}
 	if (ftype == F2FS_FT_DIR && i_links != child_cnt) {
@@ -429,6 +436,8 @@ check:
 		if (config.fix_cnt) {
 			node_blk->i.i_links = cpu_to_le32(child_cnt);
 			need_fix = 1;
+			FIX_MSG("Dir: 0x%x i_links= 0x%x -> 0x%x",
+						nid, i_links, child_cnt);
 		}
 	}
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 3b75bff..7242690 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -54,6 +54,12 @@ typedef unsigned long	pgoff_t;
 /*
  * Debugging interfaces
  */
+#define FIX_MSG(fmt, ...)						\
+	do {								\
+		printf("[FIX] (%s:%4d) ", __func__, __LINE__);		\
+		printf(" --> "fmt"\n", ##__VA_ARGS__);			\
+	} while (0)
+
 #define ASSERT_MSG(fmt, ...)						\
 	do {								\
 		printf("[ASSERT] (%s:%4d) ", __func__, __LINE__);	\
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/

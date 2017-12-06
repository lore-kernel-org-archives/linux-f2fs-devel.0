From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: no need return value in restore summary
 process
Date: Wed, 6 Dec 2017 11:31:29 +0800
Message-ID: <1512531089-13521-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eMQde-0002nK-T4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Dec 2017 03:44:50 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eMQdd-0006Ia-28
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Dec 2017 03:44:50 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com, heyunlei@huawei.com

No need return value in restore summary process

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/node.c    |  3 +--
 fs/f2fs/segment.c | 14 +++-----------
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 82f1dc3..d86fc1d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2627,7 +2627,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
 void recover_inline_xattr(struct inode *inode, struct page *page);
 int recover_xattr_data(struct inode *inode, struct page *page);
 int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
-int restore_node_summary(struct f2fs_sb_info *sbi,
+void restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
 void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 int build_node_manager(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a9c340e..35b079d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2325,7 +2325,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	return 0;
 }
 
-int restore_node_summary(struct f2fs_sb_info *sbi,
+void restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum)
 {
 	struct f2fs_node *rn;
@@ -2358,7 +2358,6 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
 		invalidate_mapping_pages(META_MAPPING(sbi), addr,
 							addr + nrpages);
 	}
-	return 0;
 }
 
 static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2d38c7f..40e1d20 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2823,7 +2823,7 @@ void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr)
 	}
 }
 
-static int read_compacted_summaries(struct f2fs_sb_info *sbi)
+static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct curseg_info *seg_i;
@@ -2880,7 +2880,6 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 		}
 	}
 	f2fs_put_page(page, 1);
-	return 0;
 }
 
 static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
@@ -2926,13 +2925,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 				ns->ofs_in_node = 0;
 			}
 		} else {
-			int err;
-
-			err = restore_node_summary(sbi, segno, sum);
-			if (err) {
-				f2fs_put_page(new, 1);
-				return err;
-			}
+			restore_node_summary(sbi, segno, sum);
 		}
 	}
 
@@ -2971,8 +2964,7 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 							META_CP, true);
 
 		/* restore for compacted data summary */
-		if (read_compacted_summaries(sbi))
-			return -EINVAL;
+		read_compacted_summaries(sbi);
 		type = CURSEG_HOT_NODE;
 	}
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

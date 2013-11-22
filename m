From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: send REQ_META or REQ_PRIO when reading meta area
Date: Fri, 22 Nov 2013 13:20:49 +0900
Message-ID: <1385094049-32219-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Let's send REQ_META or REQ_PRIO when reading meta area such as NAT/SIT
etc.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c |    2 +-
 fs/f2fs/node.c       |    4 ++--
 fs/f2fs/segment.c    |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index eae8dc3..7fe69ff 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -61,7 +61,7 @@ repeat:
 	if (PageUptodate(page))
 		goto out;
 
-	if (f2fs_readpage(sbi, page, index, READ_SYNC))
+	if (f2fs_readpage(sbi, page, index, READ_SYNC | REQ_META | REQ_PRIO))
 		goto repeat;
 
 	lock_page(page);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c06871f..4315712 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -105,11 +105,11 @@ static void ra_nat_pages(struct f2fs_sb_info *sbi, int nid)
 			f2fs_put_page(page, 1);
 			continue;
 		}
-		submit_read_page(sbi, page, index, READ_SYNC);
+		submit_read_page(sbi, page, index, READ_SYNC | REQ_META);
 
 		f2fs_put_page(page, 0);
 	}
-	f2fs_submit_read_bio(sbi, READ_SYNC);
+	f2fs_submit_read_bio(sbi, READ_SYNC | REQ_META);
 }
 
 static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2211719..a95a723 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1731,13 +1731,13 @@ repeat:
 			continue;
 		}
 
-		submit_read_page(sbi, page, blk_addr, READ_SYNC);
+		submit_read_page(sbi, page, blk_addr, READ_SYNC | REQ_META);
 
 		mark_page_accessed(page);
 		f2fs_put_page(page, 0);
 	}
 
-	f2fs_submit_read_bio(sbi, READ_SYNC);
+	f2fs_submit_read_bio(sbi, READ_SYNC | REQ_META);
 	return blkno - start;
 }
 
-- 
1.7.9.5


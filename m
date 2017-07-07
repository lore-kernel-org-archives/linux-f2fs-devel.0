From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2 v2] f2fs: avoid deadlock caused by lock
 order of page and lock_op
Date: Fri, 7 Jul 2017 12:13:59 -0700
Message-ID: <20170707191359.GB29629@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170624162522.48931-1-jaegeuk@kernel.org>
 <f572292c-026a-7167-89b4-864b60d05865@huawei.com>
 <20170626145433.GA8560@jaegeuk-macbookpro.roam.corp.google.com>
 <060e5c2d-50cd-9f76-9efc-0cdec0d3df3b@kernel.org>
 <20170701072827.GB83795@jaegeuk-macbookpro.roam.corp.google.com>
 <556d8042-92f3-cb02-26c4-69e89b781c8c@kernel.org>
 <20170701142722.GA901@jaegeuk-macbookpro.roam.corp.google.com>
 <dd02d51c-ce5b-5b1a-eb12-847ef7b3cfc7@kernel.org>
 <20170705032834.GA15448@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170705032834.GA15448@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

- punch_hole
 - fill_zero
  - f2fs_lock_op
  - get_new_data_page
   - lock_page

- f2fs_write_data_pages
 - lock_page
 - do_write_data_page
  - f2fs_lock_op

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
 - hide EAGAIN to users

 fs/f2fs/data.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 72fc866cad19..7dd5fb647d43 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1404,8 +1404,9 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		}
 	}
 
-	if (fio->need_lock == LOCK_REQ)
-		f2fs_lock_op(fio->sbi);
+	/* Deadlock due to between page->lock and f2fs_lock_op */
+	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi))
+		return -EAGAIN;
 
 	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
 	if (err)
@@ -1667,7 +1668,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			}
 
 			done_index = page->index;
-
+retry_write:
 			lock_page(page);
 
 			if (unlikely(page->mapping != mapping)) {
@@ -1703,6 +1704,15 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 					unlock_page(page);
 					ret = 0;
 					continue;
+				} else if (ret == -EAGAIN) {
+					ret = 0;
+					if (wbc->sync_mode == WB_SYNC_ALL) {
+						cond_resched();
+						congestion_wait(BLK_RW_ASYNC,
+									HZ/50);
+						goto retry_write;
+					}
+					continue;
 				}
 				done_index = page->index + 1;
 				done = 1;
-- 
2.13.0.rc1.294.g07d810a77f-goog

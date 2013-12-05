From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH 2/3] f2fs: avoid unneeded page release for correct
 _count of page
Date: Thu, 05 Dec 2013 09:54:56 +0800
Message-ID: <001801cef15d$2e3e4b10$8abae130$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In find_fsync_dnodes() and recover_data(), our flow is like this:

->f2fs_submit_page_bio()
	-> f2fs_put_page()
		-> page_cache_release()	---- page->_count declined to zero.
->__free_pages()
	-> put_page_testzero() ---- page->_count will be declined again.

We will get a segment fault in put_page_testzero when CONFIG_DEBUG_VM
is on, or return MM with a bad page with wrong _count num.

So let's just release this page.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/recovery.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 7dda1f28..d075465 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -145,7 +145,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 
 		err = f2fs_submit_page_bio(sbi, page, blkaddr, READ_SYNC);
 		if (err)
-			goto out;
+			return err;
 
 		lock_page(page);
 
@@ -191,9 +191,10 @@ next:
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
 	}
+
 	unlock_page(page);
-out:
 	__free_pages(page, 0);
+
 	return err;
 }
 
@@ -388,7 +389,7 @@ static int recover_data(struct f2fs_sb_info *sbi,
 
 		err = f2fs_submit_page_bio(sbi, page, blkaddr, READ_SYNC);
 		if (err)
-			goto out;
+			return err;
 
 		lock_page(page);
 
@@ -412,8 +413,8 @@ next:
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
 	}
+
 	unlock_page(page);
-out:
 	__free_pages(page, 0);
 
 	if (!err)
-- 
1.7.9.5

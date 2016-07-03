From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/4] f2fs: fix to detect truncation prior rather
	than EIO during read
Date: Sun,  3 Jul 2016 22:05:12 +0800
Message-ID: <1467554714-5125-2-git-send-email-chao@kernel.org>
References: <1467554714-5125-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bJi3X-00021W-Nd
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Jul 2016 14:07:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bJi3W-00034T-Qw
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Jul 2016 14:07:31 +0000
In-Reply-To: <1467554714-5125-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In procedure of synchonized read, after sending out the read request, reader
will try to lock the page for waiting device to finish the read jobs and
unlock the page, but meanwhile, truncater will race with reader, so after
reader get lock of the page, it should check page's mapping to detect
whether someone has truncated the page in advance, then reader has the
chance to do the retry if truncation was done, otherwise read can be failed
due to previous condition check.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 16 ++++++++--------
 fs/f2fs/gc.c   |  4 ++--
 fs/f2fs/node.c |  6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2bfb4f1..1a4700c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -500,14 +500,14 @@ repeat:
 
 	/* wait for read completion */
 	lock_page(page);
-	if (unlikely(!PageUptodate(page))) {
-		f2fs_put_page(page, 1);
-		return ERR_PTR(-EIO);
-	}
 	if (unlikely(page->mapping != mapping)) {
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
+	if (unlikely(!PageUptodate(page))) {
+		f2fs_put_page(page, 1);
+		return ERR_PTR(-EIO);
+	}
 	return page;
 }
 
@@ -1647,14 +1647,14 @@ repeat:
 		__submit_bio(sbi, READ_SYNC, bio, DATA);
 
 		lock_page(page);
-		if (unlikely(!PageUptodate(page))) {
-			err = -EIO;
-			goto fail;
-		}
 		if (unlikely(page->mapping != mapping)) {
 			f2fs_put_page(page, 1);
 			goto repeat;
 		}
+		if (unlikely(!PageUptodate(page))) {
+			err = -EIO;
+			goto fail;
+		}
 	}
 out_update:
 	SetPageUptodate(page);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a15ae8a..d888490 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -593,11 +593,11 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	/* write page */
 	lock_page(fio.encrypted_page);
 
-	if (unlikely(!PageUptodate(fio.encrypted_page))) {
+	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi))) {
 		err = -EIO;
 		goto put_page_out;
 	}
-	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi))) {
+	if (unlikely(!PageUptodate(fio.encrypted_page))) {
 		err = -EIO;
 		goto put_page_out;
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 729fb1e..69171ce 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1146,13 +1146,13 @@ repeat:
 
 	lock_page(page);
 
-	if (unlikely(!PageUptodate(page)))
-		goto out_err;
-
 	if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
+
+	if (unlikely(!PageUptodate(page)))
+		goto out_err;
 page_hit:
 	if(unlikely(nid != nid_of_node(page))) {
 		f2fs_bug_on(sbi, 1);
-- 
2.7.2


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape

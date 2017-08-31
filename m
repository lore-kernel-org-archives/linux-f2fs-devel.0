From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to wake up all sleeping flusher
Date: Thu, 31 Aug 2017 18:56:06 +0800
Message-ID: <20170831105606.99384-2-yuchao0@huawei.com>
References: <20170831105606.99384-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dnN9d-0000yn-SR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Aug 2017 10:56:57 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dnN9c-0005b6-5L
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Aug 2017 10:56:57 +0000
In-Reply-To: <20170831105606.99384-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In scenario of remount_ro vs flush, after flush_thread exits in
->remount_fs, flusher will only clean up golbal issue_list, but
without waking up flushers waiting on that list, result in hang
related user threads.

In order to fix this issue, this patch enables the flusher to
take charge of issue_flush thread: executes merged flush command,
and wake up all sleeping flushers.

Fixes: 5eba8c5d1fb3 ("f2fs: fix to access nullified flush_cmd_control pointer")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1215ca1bd4e2..265c3bc44f2d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -558,8 +558,27 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 		wait_for_completion(&cmd.wait);
 		atomic_dec(&fcc->issing_flush);
 	} else {
-		llist_del_all(&fcc->issue_list);
-		atomic_set(&fcc->issing_flush, 0);
+		struct llist_node *list;
+
+		list = llist_del_all(&fcc->issue_list);
+		if (!list) {
+			wait_for_completion(&cmd.wait);
+			atomic_dec(&fcc->issing_flush);
+		} else {
+			struct flush_cmd *tmp, *next;
+
+			ret = submit_flush_wait(sbi);
+
+			llist_for_each_entry_safe(tmp, next, list, llnode) {
+				if (tmp == &cmd) {
+					cmd.ret = ret;
+					atomic_dec(&fcc->issing_flush);
+					continue;
+				}
+				tmp->ret = ret;
+				complete(&tmp->wait);
+			}
+		}
 	}
 
 	return cmd.ret;
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

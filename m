From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] f2fs: remove unused pend_list_tag
Date: Mon, 8 Jan 2018 18:48:34 +0800
Message-ID: <20180108104834.108983-4-yuchao0@huawei.com>
References: <20180108104834.108983-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eYUzO-0002JN-TY
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jan 2018 10:49:10 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYUzN-00074D-UA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jan 2018 10:49:10 +0000
In-Reply-To: <20180108104834.108983-1-yuchao0@huawei.com>
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

In commit 78997b569f56 ("f2fs: split discard policy"), we have get rid
of using pend_list_tag field in struct discard_cmd_control, but forgot
to remove it, now do it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3c3a055c3d4a..b13ee958a539 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -269,7 +269,6 @@ struct discard_cmd_control {
 	struct task_struct *f2fs_issue_discard;	/* discard thread */
 	struct list_head entry_list;		/* 4KB discard entry list */
 	struct list_head pend_list[MAX_PLIST_NUM];/* store pending entries */
-	unsigned char pend_list_tag[MAX_PLIST_NUM];/* tag for pending entries */
 	struct list_head wait_list;		/* store on-flushing entries */
 	struct list_head fstrim_list;		/* in-flight discard from fstrim */
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

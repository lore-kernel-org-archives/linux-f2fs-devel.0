From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2] f2fs: use set_page_private marcro in
	f2fs_trace_pid
Date: Wed, 22 Mar 2017 11:59:30 +0800
Message-ID: <20170322035930.20657-2-heyunlei@huawei.com>
References: <20170322035930.20657-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cqXNR-0004mf-H6
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 03:56:01 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqXNQ-0007Zb-It
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 03:56:01 +0000
In-Reply-To: <20170322035930.20657-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Use set_page_private marcro instead of operte page struct
directly

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index c82ab40..bccbbf2 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -59,7 +59,7 @@ void f2fs_trace_pid(struct page *page)
 	pid_t pid = task_pid_nr(current);
 	void *p;
 
-	page->private = pid;
+	set_page_private(page, (unsigned long)pid);
 
 	if (radix_tree_preload(GFP_NOFS))
 		return;
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

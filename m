From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 2/3] f2fs: don't wait with each discards under
 gc_urgent
Date: Tue, 14 May 2019 15:36:22 +0900
Message-ID: <20190514063623.57162-2-qkrwngud825@gmail.com>
References: <20190514063623.57162-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hQR3O-0001TN-Eg
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 06:36:46 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hQR3K-00GFFF-Tx
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 06:36:46 +0000
Received: by mail-pf1-f194.google.com with SMTP id g3so8568826pfi.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 May 2019 23:36:42 -0700 (PDT)
In-Reply-To: <20190514063623.57162-1-qkrwngud825@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

f2fs already addresses gc_urgent under discard, but still uses the
default wait_ms.

To gain as many free segments as fast as possible,
use 1 for wait_ms under gc_urgent for discards.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8dee063c833f..dece5ebfb8f0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1685,7 +1685,8 @@ static int issue_discard_thread(void *data)
 		wait_event_interruptible_timeout(*q,
 				kthread_should_stop() || freezing(current) ||
 				dcc->discard_wake,
-				msecs_to_jiffies(wait_ms));
+				msecs_to_jiffies((sbi->gc_mode == GC_URGENT) ?
+						 1 : wait_ms));
 
 		if (dcc->discard_wake)
 			dcc->discard_wake = 0;
-- 
2.21.0

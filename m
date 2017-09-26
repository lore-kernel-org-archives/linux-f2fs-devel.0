From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH] f2fs: set ioprio of GC kthread to idle
Date: Tue, 26 Sep 2017 11:36:26 +0900
Message-ID: <20170926023626.864-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <qkrwngud825@gmail.com>)
 id 1dwfk6-0007Cs-LM
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Sep 2017 02:37:02 +0000
Received: from mail-pg0-f67.google.com ([74.125.83.67])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dwfk5-0000JZ-Qy
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Sep 2017 02:37:02 +0000
Received: by mail-pg0-f67.google.com with SMTP id u18so5926677pgo.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 25 Sep 2017 19:37:01 -0700 (PDT)
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

GC should run conservatively as possible to reduce latency spikes to the user.

Setting ioprio to idle class will allow the kernel to schedule GC thread's I/O
to not affect any other processes' I/O requests.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 fs/f2fs/gc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index bfe6a8ccc3a0..54d2d74e9afe 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -143,6 +143,8 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
 		kfree(gc_th);
 		sbi->gc_thread = NULL;
 	}
+	set_task_ioprio(sbi->gc_thread->f2fs_gc_task,
+			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
 out:
 	return err;
 }
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

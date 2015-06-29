From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/12] f2fs: avoid freed stat information
Date: Mon, 29 Jun 2015 11:39:25 -0700
Message-ID: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z9dy8-0002zb-1p
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:39:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z9dy7-0005AE-0T for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:39:48 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

The write_checkpoint can update stat information, so we should destroy the stat
structure after it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a06b0b4..da27710 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -498,7 +498,6 @@ static void f2fs_put_super(struct super_block *sb)
 	}
 	kobject_del(&sbi->s_kobj);
 
-	f2fs_destroy_stats(sbi);
 	stop_gc_thread(sbi);
 
 	/*
@@ -514,6 +513,9 @@ static void f2fs_put_super(struct super_block *sb)
 		write_checkpoint(sbi, &cpc);
 	}
 
+	/* write_checkpoint can update stat informaion */
+	f2fs_destroy_stats(sbi);
+
 	/*
 	 * normally superblock is clean, so we need to release this.
 	 * In addition, EIO will skip do checkpoint, we need this as well.
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/

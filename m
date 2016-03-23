From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/7] fsck.f2fs: nullify the freed ckpt pointer
Date: Wed, 23 Mar 2016 13:41:20 -0700
Message-ID: <1458765681-24123-6-git-send-email-jaegeuk@kernel.org>
References: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aipaz-0003rC-BY
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aipay-0007P0-Mc
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:37 +0000
In-Reply-To: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Otherwise, we get a double free error by:

In fsck/main.c,

545 out_err:
546         if (sbi->ckpt)
547                 free(sbi->ckpt);

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 51d50ec..37a0025 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -502,6 +502,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 
 fail_no_cp:
 	free(sbi->ckpt);
+	sbi->ckpt = NULL;
 	return -EINVAL;
 }
 
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140

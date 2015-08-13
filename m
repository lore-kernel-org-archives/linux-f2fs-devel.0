From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2 v3] f2fs: skip checkpoint if there is no
 dirty segments
Date: Wed, 12 Aug 2015 18:26:49 -0700
Message-ID: <20150813012649.GA7458@jaegeuk-mac02.mot.com>
References: <1439256205-8906-1-git-send-email-jaegeuk@kernel.org>
	<1439256205-8906-2-git-send-email-jaegeuk@kernel.org>
	<20150812050916.GA22780@jaegeuk-mac02.hsd1.ca.comcast.net>
	<00b701d0d4e3$718ee800$54acb800$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZPhIL-0005Xs-PJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Aug 2015 01:27:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZPhII-0001pb-0E for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Aug 2015 01:27:01 +0000
Content-Disposition: inline
In-Reply-To: <00b701d0d4e3$718ee800$54acb800$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Change log from v2:
 - consider omitting current dirty segments

>From 181cb245f6a406e89c00976f65a5727956a72942 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 11 Aug 2015 21:59:49 -0700
Subject: [PATCH] f2fs: skip checkpoint if there is no dirty and prefree
 segments

We should avoid needless checkpoints when there is no dirty and prefree segment.

eviewed-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index fcb263a..81de28d8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -792,7 +792,8 @@ static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
 
 int f2fs_gc(struct f2fs_sb_info *sbi)
 {
-	unsigned int segno, i;
+	unsigned int segno = NULL_SEGNO;
+	unsigned int i;
 	int gc_type = BG_GC;
 	int nfree = 0;
 	int ret = -1;
@@ -811,10 +812,11 @@ gc_more:
 
 	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, nfree)) {
 		gc_type = FG_GC;
-		write_checkpoint(sbi, &cpc);
+		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi))
+			write_checkpoint(sbi, &cpc);
 	}
 
-	if (!__get_victim(sbi, &segno, gc_type))
+	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
 		goto stop;
 	ret = 0;
 
-- 
2.1.1


------------------------------------------------------------------------------

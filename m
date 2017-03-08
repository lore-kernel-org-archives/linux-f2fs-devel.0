From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix the fault of calculating blkstart
	twice
Date: Tue, 7 Mar 2017 17:11:13 -0800
Message-ID: <20170308011113.GC2499@jaegeuk.local>
References: <9f3a4202-11cb-5861-838c-ebbc94b71554@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1clQ8R-0003aw-K2
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 01:11:23 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1clQ8Q-0007T3-N6
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 01:11:23 +0000
Content-Disposition: inline
In-Reply-To: <9f3a4202-11cb-5861-838c-ebbc94b71554@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On 03/04, Kinglong Mee wrote:
> When the zone type is BLK_ZONE_TYPE_CONVENTIONAL, the blkstart is 
> calculated twice.
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> ---
>  fs/f2fs/segment.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4bd7a8b..ed181d1 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -772,11 +772,6 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
>  
>  	trace_f2fs_issue_discard(bdev, blkstart, blklen);
>  
> -	if (sbi->s_ndevs) {
> -		int devi = f2fs_target_device_index(sbi, blkstart);
> -
> -		blkstart -= FDEV(devi).start_blk;
> -	}

No, you can't do this, since the blkstart will be used for dc->lstart.
So, it needs to do like this?

>From 01cfee96f3568590ba58f6d2b36150dce7054491 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 7 Mar 2017 16:32:35 -0800
Subject: [PATCH] f2fs: fix the fault of calculating blkstart twice

When the zone type is BLK_ZONE_TYPE_CONVENTIONAL, the blkstart is
calculated twice.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 401f25de80fb..2c512c6aa6f3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -818,11 +818,6 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	sector_t sector, nr_sects;
 	int devi = 0;
 
-	if (sbi->s_ndevs) {
-		devi = f2fs_target_device_index(sbi, blkstart);
-		blkstart -= FDEV(devi).start_blk;
-	}
-
 	/*
 	 * We need to know the type of the zone: for conventional zones,
 	 * use regular discard if the drive supports it. For sequential
@@ -836,6 +831,12 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		return __f2fs_issue_discard_async(sbi, bdev, blkstart, blklen);
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
+
+		if (sbi->s_ndevs) {
+			devi = f2fs_target_device_index(sbi, blkstart);
+			blkstart -= FDEV(devi).start_blk;
+		}
+
 		sector = SECTOR_FROM_BLOCK(blkstart);
 		nr_sects = SECTOR_FROM_BLOCK(blklen);
 
-- 
2.11.0


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford

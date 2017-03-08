From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH] f2fs: fix the fault of calculating blkstart
	twice
Date: Wed, 8 Mar 2017 09:53:50 +0800
Message-ID: <6d4a74e7-cbbb-21d6-7ee6-045c3db46f31@gmail.com>
References: <9f3a4202-11cb-5861-838c-ebbc94b71554@gmail.com>
	<20170308011113.GC2499@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1clQnn-0008Nm-SL
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 01:54:07 +0000
Received: from mail-it0-f65.google.com ([209.85.214.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1clQnl-0000SN-IB
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 01:54:07 +0000
Received: by mail-it0-f65.google.com with SMTP id g138so2552441itb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 07 Mar 2017 17:54:05 -0800 (PST)
In-Reply-To: <20170308011113.GC2499@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 3/8/2017 09:11, Jaegeuk Kim wrote:
> Hi,
> 
> On 03/04, Kinglong Mee wrote:
>> When the zone type is BLK_ZONE_TYPE_CONVENTIONAL, the blkstart is 
>> calculated twice.
>>
>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>> ---
>>  fs/f2fs/segment.c | 22 +++++++++-------------
>>  1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 4bd7a8b..ed181d1 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -772,11 +772,6 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
>>  
>>  	trace_f2fs_issue_discard(bdev, blkstart, blklen);
>>  
>> -	if (sbi->s_ndevs) {
>> -		int devi = f2fs_target_device_index(sbi, blkstart);
>> -
>> -		blkstart -= FDEV(devi).start_blk;
>> -	}
> 
> No, you can't do this, since the blkstart will be used for dc->lstart.
> So, it needs to do like this?

Sorry, I miss that.

But, get_blkz_type() needs the new blkaddr for blkz_type as
"FDEV(i).blkz_type[zno]", so that, the blkaddr must be calculated
in front of __f2fs_issue_discard_zone, just like this?

>From efd182428830898cc31d49f74d4bd2ab7455cec4 Mon Sep 17 00:00:00 2001
From: Kinglong Mee <kinglongmee@gmail.com>
Date: Wed, 8 Mar 2017 09:49:53 +0800
Subject: [PATCH] f2fs: fix the fault of calculating blkstart twice

When the zone type is BLK_ZONE_TYPE_CONVENTIONAL, the blkstart is
calculated twice.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 401f25d..dbd2e7a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -816,6 +816,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
 {
 	sector_t sector, nr_sects;
+	block_t lblkstart = blkstart;
 	int devi = 0;
 
 	if (sbi->s_ndevs) {
@@ -833,7 +834,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	case BLK_ZONE_TYPE_CONVENTIONAL:
 		if (!blk_queue_discard(bdev_get_queue(bdev)))
 			return 0;
-		return __f2fs_issue_discard_async(sbi, bdev, blkstart, blklen);
+		return __f2fs_issue_discard_async(sbi, bdev, lblkstart, blklen);
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
 		sector = SECTOR_FROM_BLOCK(blkstart);
-- 
2.9.3



------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford

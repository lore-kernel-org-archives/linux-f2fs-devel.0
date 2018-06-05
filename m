From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH] resize.f2fs: skip cursegs when finding next
 free block
Date: Tue, 5 Jun 2018 10:08:17 +0800
Message-ID: <a6ad18d7-96e4-9976-006f-3ea6c55173e1@huawei.com>
References: <20180604081436.146277-1-shengyong1@huawei.com>
 <20180604205559.GA72668@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fQ1Ow-0007GV-Kb
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Jun 2018 02:08:46 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fQ1Ou-000tiS-BN
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Jun 2018 02:08:46 +0000
In-Reply-To: <20180604205559.GA72668@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Sheng Yong <shengyong1@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/6/5 4:55, Jaegeuk Kim wrote:
> On 06/04, Sheng Yong wrote:
>> resize.f2fs (f2fs_defragment) tries to migrate blocks to new positions.
>> However, if a curseg is selected, and f2fs_defragment is broken by any
>> error, curseg->next_blkoff is left not updated.
>>
>> To avoid this, we skip cursegs when finding next free block.
> 
> Don't we update the curseg at the end of resize/defrag?
> 

Yeah, currently, at the beginning of resize, we finds the next free block
from the beginning of main instead of from cursegs. So, we needn't to update
the curseg if we skip cursegs while finding next free block.

Besides, the logic of IS_CUR_SEGNO is puzzling, does it mean to check the
type of curseg? If the type of curseg with specified segno is not that we
need, then returns nonzero?

>>
>> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
>> ---
>>  fsck/f2fs.h  | 5 +----
>>  fsck/fsck.c  | 2 +-
>>  fsck/mount.c | 8 +++-----
>>  3 files changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/fsck/f2fs.h b/fsck/f2fs.h
>> index d0e08aa..d216444 100644
>> --- a/fsck/f2fs.h
>> +++ b/fsck/f2fs.h
>> @@ -380,16 +380,13 @@ static inline bool IS_VALID_BLK_ADDR(struct f2fs_sb_info *sbi, u32 addr)
>>  	return 1;
>>  }
>>  
>> -static inline int IS_CUR_SEGNO(struct f2fs_sb_info *sbi, u32 segno, int type)
>> +static inline int IS_CUR_SEGNO(struct f2fs_sb_info *sbi, u32 segno)
>>  {
>>  	int i;
>>  
>>  	for (i = 0; i < NO_CHECK_TYPE; i++) {
>>  		struct curseg_info *curseg = CURSEG_I(sbi, i);
>>  
>> -		if (type == i)
>> -			continue;
>> -
>>  		if (segno == curseg->segno)
>>  			return 1;
>>  	}
>> diff --git a/fsck/fsck.c b/fsck/fsck.c
>> index 5b6dbc8..8145199 100644
>> --- a/fsck/fsck.c
>> +++ b/fsck/fsck.c
>> @@ -1741,7 +1741,7 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
>>  		se = get_seg_entry(sbi, i);
>>  		if (se->valid_blocks != 0)
>>  			sit_valid_segs++;
>> -		else if (IS_CUR_SEGNO(sbi, i, NO_CHECK_TYPE)) {
>> +		else if (IS_CUR_SEGNO(sbi, i)) {
>>  			/* curseg has not been written back to device */
>>  			MSG(1, "\tInfo: curseg %u is counted in valid segs\n", i);
>>  			sit_valid_segs++;
>> diff --git a/fsck/mount.c b/fsck/mount.c
>> index 0a30adb..8d4704e 100644
>> --- a/fsck/mount.c
>> +++ b/fsck/mount.c
>> @@ -35,8 +35,7 @@ u32 get_free_segments(struct f2fs_sb_info *sbi)
>>  	for (i = 0; i < TOTAL_SEGS(sbi); i++) {
>>  		struct seg_entry *se = get_seg_entry(sbi, i);
>>  
>> -		if (se->valid_blocks == 0x0 &&
>> -				!IS_CUR_SEGNO(sbi, i, NO_CHECK_TYPE))
>> +		if (se->valid_blocks == 0x0 && !IS_CUR_SEGNO(sbi, i))
>>  			free_segs++;
>>  	}
>>  	return free_segs;
>> @@ -1891,8 +1890,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi)
>>  							se->valid_blocks);
>>  		rewrite_current_sit_page(sbi, segno, sit_blk);
>>  
>> -		if (se->valid_blocks == 0x0 &&
>> -				!IS_CUR_SEGNO(sbi, segno, NO_CHECK_TYPE))
>> +		if (se->valid_blocks == 0x0 && !IS_CUR_SEGNO(sbi, segno))
>>  			free_segs++;
>>  	}
>>  
>> @@ -1922,7 +1920,7 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
>>  		se = get_seg_entry(sbi, segno);
>>  
>>  		if (se->valid_blocks == sbi->blocks_per_seg ||
>> -				IS_CUR_SEGNO(sbi, segno, type)) {
>> +				IS_CUR_SEGNO(sbi, segno)) {
>>  			*to = left ? START_BLOCK(sbi, segno) - 1:
>>  						START_BLOCK(sbi, segno + 1);
>>  			continue;
>> -- 
>> 2.17.0
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

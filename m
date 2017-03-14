From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: restrict write IO alignment
	condition
Date: Tue, 14 Mar 2017 19:32:16 +0800
Message-ID: <07e43857-1387-eb9b-478d-57d2f14d81e4@huawei.com>
References: <20170313130216.108395-1-yuchao0@huawei.com>
	<20170313200544.GE41055@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cnkgw-00089H-L2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Mar 2017 11:32:38 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cnkgt-0002Jh-If
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Mar 2017 11:32:38 +0000
In-Reply-To: <20170313200544.GE41055@jaegeuk.local>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/3/14 4:05, Jaegeuk Kim wrote:
> On 03/13, Chao Yu wrote:
>> We should only align start offset of bio with defined IO_SIZE for below
>> conditions:
>> a. mode=lfs mount option
>> b. write IOs
>> c. Out-place-update
>> d. non-meta pages
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 1375fef11146..53fe79c70406 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -190,6 +190,9 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
>>  			current->plug && (type == DATA || type == NODE))
>>  			blk_finish_plug(current->plug);
>>  
>> +		if (!test_opt(sbi, LFS))
>> +			goto submit_io;
> 
> The parse_options in fill_super checks this.

You're right, I missed that one...

> 
>> +
>>  		if (type != DATA && type != NODE)
>>  			goto submit_io;
>>  
>> @@ -395,11 +398,12 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
>>  		__submit_merged_bio(io);
>>  alloc_new:
>>  	if (io->bio == NULL) {
>> -		if ((fio->type == DATA || fio->type == NODE) &&
>> +		if (test_opt(sbi, LFS) &&
>> +			!is_read && (fio->type == DATA || fio->type == NODE) &&
> 
> The missing case is !is_read, here?
> But, actually, DATA and NODE don't issue any read commands at all.

Correct, let me add BUG_ON here. :)

Thanks,

> 
> Thanks,
> 
>>  				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
>>  			err = -EAGAIN;
>> -			if (!is_read)
>> -				dec_page_count(sbi, WB_DATA_TYPE(bio_page));
>> +			f2fs_bug_on(sbi, fio->new_blkaddr == fio->old_blkaddr);
>> +			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
>>  			goto out_fail;
>>  		}
>>  		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
>> -- 
>> 2.8.2.295.g3f1c1d0
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

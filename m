From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: check blkaddr more accuratly before
 issue a bio
Date: Tue, 27 Feb 2018 16:59:12 +0800
Message-ID: <f598b4d1-b784-b298-a23d-35882a53ed9f@huawei.com>
References: <1519646809-1624-1-git-send-email-heyunlei@huawei.com>
 <42B685BFA705F94C860C6DD0752F05654833BB7F@DGGEMA503-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eqb3P-005GIx-EL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Feb 2018 08:56:07 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eqb3L-003zL5-6E
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Feb 2018 08:56:05 +0000
In-Reply-To: <42B685BFA705F94C860C6DD0752F05654833BB7F@DGGEMA503-MBX.china.huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: heyunlei <heyunlei@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Jianing (Euler)" <ning.jia@huawei.com>

On 2018/2/26 20:31, heyunlei wrote:
> 
> 
>> -----Original Message-----
>> From: heyunlei
>> Sent: Monday, February 26, 2018 8:07 PM
>> To: jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net; Yuchao (T)
>> Cc: Jianing (Euler); Wangbintian; heyunlei
>> Subject: [f2fs-dev][PATCH] f2fs: check blkaddr more accuratly before issue a bio
>>
>> This patch check blkaddr more accuratly before issue a
>> write or read bio.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>> fs/f2fs/data.c    | 6 ++++--
>> fs/f2fs/segment.h | 9 +++++++--
>> 2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 62ead5e..5dc93bc 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -383,6 +383,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>> 	struct page *page = fio->encrypted_page ?
>> 			fio->encrypted_page : fio->page;
>>
>> +	verify_block_addr(fio->sbi, fio->new_blkaddr,
>> +					PAGE_TYPE_OF_BIO(fio->type));
> 
> 
> I'm sorry that read io will check fail during recovery or restore summary.
> 
> Could we check read io by previous method, write io with new method?

Hmm.. for META_POR or migration of encrypted pages pathes, we can add a
parameter (.use_meta?) in fio structure to indicate that current user will
borrow meta inode's mapping to issue read/write IO into main area, and then in
verify_block_addr we can check blkaddr as node's or data's one. How do you think?

Thanks,

> For I came across a broken partition, whose sit area is covered by a log file
> data.
> 
>> 	trace_f2fs_submit_page_bio(page, fio);
>> 	f2fs_trace_ios(fio, 0);
>>
>> @@ -428,8 +430,8 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
>> 	}
>>
>> 	if (fio->old_blkaddr != NEW_ADDR)
>> -		verify_block_addr(sbi, fio->old_blkaddr);
>> -	verify_block_addr(sbi, fio->new_blkaddr);
>> +		verify_block_addr(sbi, fio->old_blkaddr, btype);
>> +	verify_block_addr(sbi, fio->new_blkaddr, btype);
>>
>> 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
>>
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index f11c4bc..45c4e8d 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -630,9 +630,14 @@ static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
>> 	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
>> }
>>
>> -static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
>> +static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr,
>> +								enum page_type btype)
>> {
>> -	BUG_ON(blk_addr < SEG0_BLKADDR(sbi)
>> +	if (btype == META)
>> +		BUG_ON(blk_addr < SEG0_BLKADDR(sbi)
>> +			|| blk_addr >= MAIN_BLKADDR(sbi));
>> +	else
>> +		BUG_ON(blk_addr < MAIN_BLKADDR(sbi)
>> 			|| blk_addr >= MAX_BLKADDR(sbi));
>> }
>>
>> --
>> 2.7.4
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

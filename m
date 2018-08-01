From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH] f2fs: remove unused cp_blkaddr in
 f2fs_sanity_check_ckpt
Date: Wed, 1 Aug 2018 16:06:14 +0800
Message-ID: <a8a6a9e8-80a1-310c-ba9c-4ac7d5428ac3@huawei.com>
References: <20180731052152.64939-1-zhengjunling@huawei.com>
 <f021a184-bfe1-64c2-fb52-510e690c3a8e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fkm9X-0002bW-B6
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Aug 2018 08:06:39 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fkm9V-004UXA-0F
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Aug 2018 08:06:39 +0000
In-Reply-To: <f021a184-bfe1-64c2-fb52-510e690c3a8e@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/8/1 14:54, Chao Yu wrote:
> Hi Junling,
> 
> On 2018/7/31 13:21, Junling Zheng wrote:
>> Remove unused cp_blkaddr in f2fs_sanity_check_ckpt().
> 
> Since this issue is introduced by recent change, and the related patch has not
> been upstreamed yet, can we merge this into that patch, if you don't mind?
> 

OK, I don't mind :)

> Thanks,
> 
>>
>> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
>> ---
>>  fs/f2fs/super.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index d56bc6eb8760..6ee003e87f63 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2297,7 +2297,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>>  	unsigned int sit_bitmap_size, nat_bitmap_size;
>>  	unsigned int log_blocks_per_seg;
>>  	unsigned int segment_count_main;
>> -	unsigned int cp_pack_start_sum, cp_blkaddr, cp_payload;
>> +	unsigned int cp_pack_start_sum, cp_payload;
>>  	block_t user_block_count;
>>  	int i;
>>  
>> @@ -2359,7 +2359,6 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>>  	}
>>  
>>  	cp_pack_start_sum = __start_sum_addr(sbi);
>> -	cp_blkaddr = __start_cp_addr(sbi);
>>  	cp_payload = __cp_payload(sbi);
>>  	if (cp_pack_start_sum < cp_payload + 1 ||
>>  		cp_pack_start_sum > blocks_per_seg - 1 -
>>
> 
> 
> .
> 



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

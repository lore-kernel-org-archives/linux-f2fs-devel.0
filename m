From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH 4/5] f2fs: disable small discard in lfs mode
Date: Fri, 13 Jul 2018 11:39:45 +0800
Message-ID: <f6cefb97-dc10-5c07-7a75-ab53a72f7a22@huawei.com>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
 <1531408170-45758-5-git-send-email-yunlong.song@huawei.com>
 <ad6411b6-effd-6dc1-c7c6-43047806784d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yunlong.song@huawei.com>) id 1fdowa-0002pq-1b
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Jul 2018 03:40:32 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fdowY-00GcJJ-0g
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Jul 2018 03:40:31 +0000
In-Reply-To: <ad6411b6-effd-6dc1-c7c6-43047806784d@huawei.com>
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
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

How about change test_opt(sbi, LFS) to f2fs_sb_has_blkzoned(sbi->sb) in 
this patch, we apply
this patch to zoned block device?

On 2018/7/13 11:17, Chao Yu wrote:
> On 2018/7/12 23:09, Yunlong Song wrote:
>> In lfs mode, it is better to send the discard of the overall section
>> each time to avoid missing alignment with flash.
> Hmm.. I think LFS mode can be used widely on different kind of device instead of
> just on zoned block device, so let's just keep old implementation here.
>
> Thanks,
>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/segment.c | 3 ++-
>>   fs/f2fs/sysfs.c   | 4 ++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index fd38b61..f6c20e0 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1766,7 +1766,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>   	atomic_set(&dcc->issing_discard, 0);
>>   	atomic_set(&dcc->discard_cmd_cnt, 0);
>>   	dcc->nr_discards = 0;
>> -	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>> +	dcc->max_discards = test_opt(sbi, LFS) ? 0 :
>> +				MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>>   	dcc->undiscard_blks = 0;
>>   	dcc->root = RB_ROOT;
>>   	dcc->rbtree_check = false;
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index 2e7e611..4b6c457 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -271,6 +271,10 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>   		return count;
>>   	}
>>   
>> +	if (!strcmp(a->attr.name, "max_small_discards") &&
>> +		test_opt(sbi, LFS))
>> +		return -EINVAL;
>> +
>>   	*ui = t;
>>   
>>   	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
>>
>
> .
>

-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

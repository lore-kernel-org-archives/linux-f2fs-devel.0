From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 4/5] f2fs: disable small discard in lfs mode
Date: Fri, 13 Jul 2018 11:45:39 +0800
Message-ID: <2566d6f6-4f3b-e2d8-326e-450372b71b44@huawei.com>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
 <1531408170-45758-5-git-send-email-yunlong.song@huawei.com>
 <ad6411b6-effd-6dc1-c7c6-43047806784d@huawei.com>
 <f6cefb97-dc10-5c07-7a75-ab53a72f7a22@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f6cefb97-dc10-5c07-7a75-ab53a72f7a22@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/13 11:39, Yunlong Song wrote:
> How about change test_opt(sbi, LFS) to f2fs_sb_has_blkzoned(sbi->sb) in 
> this patch, we apply
> this patch to zoned block device?

IIRC, we will use blkdev_reset_zones instead of __queue_discard_cmd for such
kind of device, so we will not encounter the issue you described.

Thanks,

> 
> On 2018/7/13 11:17, Chao Yu wrote:
>> On 2018/7/12 23:09, Yunlong Song wrote:
>>> In lfs mode, it is better to send the discard of the overall section
>>> each time to avoid missing alignment with flash.
>> Hmm.. I think LFS mode can be used widely on different kind of device instead of
>> just on zoned block device, so let's just keep old implementation here.
>>
>> Thanks,
>>
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>   fs/f2fs/segment.c | 3 ++-
>>>   fs/f2fs/sysfs.c   | 4 ++++
>>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index fd38b61..f6c20e0 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1766,7 +1766,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>>   	atomic_set(&dcc->issing_discard, 0);
>>>   	atomic_set(&dcc->discard_cmd_cnt, 0);
>>>   	dcc->nr_discards = 0;
>>> -	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>>> +	dcc->max_discards = test_opt(sbi, LFS) ? 0 :
>>> +				MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>>>   	dcc->undiscard_blks = 0;
>>>   	dcc->root = RB_ROOT;
>>>   	dcc->rbtree_check = false;
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index 2e7e611..4b6c457 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -271,6 +271,10 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>>   		return count;
>>>   	}
>>>   
>>> +	if (!strcmp(a->attr.name, "max_small_discards") &&
>>> +		test_opt(sbi, LFS))
>>> +		return -EINVAL;
>>> +
>>>   	*ui = t;
>>>   
>>>   	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
>>>
>>
>> .
>>
> 

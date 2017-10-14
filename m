From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add bug_on when f2fs_gc even fails to
 get one victim
Date: Sat, 14 Oct 2017 20:34:43 +0800
Message-ID: <31f2c1b6-58ee-bb52-0b75-f6172b6f801f@huawei.com>
References: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
 <1507901500-162168-1-git-send-email-yunlong.song@huawei.com>
 <7f05bef6-929f-ea7b-9d60-e9a6d8e70d3c@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7f05bef6-929f-ea7b-9d60-e9a6d8e70d3c@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Do you mean check out-of-space test? I have tried that but no bugon.

On 2017/10/14 8:17, Chao Yu wrote:
> On 2017/10/13 21:31, Yunlong Song wrote:
>> This can help us to debug on some corner case.
> I can hit this bugon with generic/015 of fstest easily, could have a look at
> this?
>
> Thanks,
>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/gc.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 197ebf4..2b03202 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -986,6 +986,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>   		.ilist = LIST_HEAD_INIT(gc_list.ilist),
>>   		.iroot = RADIX_TREE_INIT(GFP_NOFS),
>>   	};
>> +	bool need_fggc = false;
>>   
>>   	trace_f2fs_gc_begin(sbi->sb, sync, background,
>>   				get_pages(sbi, F2FS_DIRTY_NODES),
>> @@ -1018,8 +1019,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>   			if (ret)
>>   				goto stop;
>>   		}
>> -		if (has_not_enough_free_secs(sbi, 0, 0))
>> +		if (has_not_enough_free_secs(sbi, 0, 0)) {
>>   			gc_type = FG_GC;
>> +			need_fggc = true;
>> +		}
>>   	}
>>   
>>   	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
>> @@ -1028,6 +1031,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>   		goto stop;
>>   	}
>>   	if (!__get_victim(sbi, &segno, gc_type)) {
>> +		f2fs_bug_on(sbi, !total_freed && need_fggc);
>>   		ret = -ENODATA;
>>   		goto stop;
>>   	}
>>
> .
>

-- 
Thanks,
Yunlong Song

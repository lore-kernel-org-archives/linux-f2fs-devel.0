From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v2] f2fs: collect prefree segments to avoild write
 checkpoint fail
Date: Tue, 31 Oct 2017 10:05:23 +0800
Message-ID: <be5636e5-da54-3159-83f7-b5c1a98ddca6@huawei.com>
References: <1503748019-152845-1-git-send-email-yunlong.song@huawei.com>
 <1504267219-76575-1-git-send-email-yunlong.song@huawei.com>
 <e7966d00-c63c-060b-2b1d-c9a9cb134b3b@huawei.com>
 <6e9b8697-3340-6057-57e2-b98550e310a9@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6e9b8697-3340-6057-57e2-b98550e310a9@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

So I use CHECK_FS config to control it. When CHECK_FS is off, all the 
other f2fs_bug_on also
only printk WARNING info rather than trigger BUG_ON.

On 2017/10/31 9:59, Chao Yu wrote:
> On 2017/10/31 9:33, Yunlong Song wrote:
>> ping...
>>
>> On 2017/9/1 20:00, Yunlong Song wrote:
>>> In come corner case, the reserved segments are used to do gc, and there are
>>> not enough free segments for write checkpoint to finish its job, then the
>>> gc process will fail to change the prefree segments to free segments.
> I agreed to use this in production for robustness, but for upstream, it's better
> to investigate and fix this issue rather than covering up it.
>
> Thanks,
>
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>    fs/f2fs/gc.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index cd147e7..6552b04 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -1056,6 +1056,16 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>    	if (!sync) {
>>>    		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
>>>    			segno = NULL_SEGNO;
>>> +#ifndef CONFIG_F2FS_CHECK_FS
>>> +			if (prefree_segments(sbi) &&
>>> +				has_not_enough_free_secs(sbi,
>>> +					reserved_sections(sbi), 0)) {
>>> +				ret = write_checkpoint(sbi, &cpc);
>>> +				if (ret)
>>> +					goto stop;
>>> +				sec_freed = 0;
>>> +			}
>>> +#endif
>>>    			goto gc_more;
>>>    		}
>>>    
>
> .
>

-- 
Thanks,
Yunlong Song

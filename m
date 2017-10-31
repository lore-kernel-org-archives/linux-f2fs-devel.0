From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: collect prefree segments to avoild
 write checkpoint fail
Date: Tue, 31 Oct 2017 10:56:00 +0800
Message-ID: <367077e1-c83e-0685-757a-230cdb3ef74e@huawei.com>
References: <1503748019-152845-1-git-send-email-yunlong.song@huawei.com>
 <1504267219-76575-1-git-send-email-yunlong.song@huawei.com>
 <e7966d00-c63c-060b-2b1d-c9a9cb134b3b@huawei.com>
 <6e9b8697-3340-6057-57e2-b98550e310a9@huawei.com>
 <be5636e5-da54-3159-83f7-b5c1a98ddca6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e9Mna-0007NI-P6
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:01:06 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e9MnZ-0006zg-AI
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:01:06 +0000
In-Reply-To: <be5636e5-da54-3159-83f7-b5c1a98ddca6@huawei.com>
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
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/31 10:05, Yunlong Song wrote:
> So I use CHECK_FS config to control it. When CHECK_FS is off, all the 
> other f2fs_bug_on also
> only printk WARNING info rather than trigger BUG_ON.

If this runing out-of-free-segments issue explicitly happens, IMO, its better
to face and fix it.

BTW, it's better to add bug_on here to detect the issue?

Thanks,

> 
> On 2017/10/31 9:59, Chao Yu wrote:
>> On 2017/10/31 9:33, Yunlong Song wrote:
>>> ping...
>>>
>>> On 2017/9/1 20:00, Yunlong Song wrote:
>>>> In come corner case, the reserved segments are used to do gc, and there are
>>>> not enough free segments for write checkpoint to finish its job, then the
>>>> gc process will fail to change the prefree segments to free segments.
>> I agreed to use this in production for robustness, but for upstream, it's better
>> to investigate and fix this issue rather than covering up it.
>>
>> Thanks,
>>
>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>> ---
>>>>    fs/f2fs/gc.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>> index cd147e7..6552b04 100644
>>>> --- a/fs/f2fs/gc.c
>>>> +++ b/fs/f2fs/gc.c
>>>> @@ -1056,6 +1056,16 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>    	if (!sync) {
>>>>    		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
>>>>    			segno = NULL_SEGNO;
>>>> +#ifndef CONFIG_F2FS_CHECK_FS
>>>> +			if (prefree_segments(sbi) &&
>>>> +				has_not_enough_free_secs(sbi,
>>>> +					reserved_sections(sbi), 0)) {
>>>> +				ret = write_checkpoint(sbi, &cpc);
>>>> +				if (ret)
>>>> +					goto stop;
>>>> +				sec_freed = 0;
>>>> +			}
>>>> +#endif
>>>>    			goto gc_more;
>>>>    		}
>>>>    
>>
>> .
>>
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

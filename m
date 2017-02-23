From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH 3/3] f2fs: provide more chance for node and data to get
 ssr segment
Date: Thu, 23 Feb 2017 10:41:21 +0800
Message-ID: <58AE4BD1.90301@huawei.com>
References: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
 <1487767851-819-3-git-send-email-yunlong.song@huawei.com>
 <20170223011754.GH4003@jaegeuk.local> <58AE452D.60500@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58AE452D.60500@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jay,
    I miss some codes from your mail, now I check all your patch codes and make clear with question 2 and 3, it's fine.

    But still, how about question 1?

On 2017/2/23 10:13, Yunlong Song wrote:
> Hi Jay,
>     But there are some differences:
> 1 Why not take "neighboring temperature" for ssr? For example, if type == CURSEG_COLD_DATA,
>     your new patch selects CURSEG_HOT_DATA first, how about select CURSEG_WARM_DATA first?
>     The patch I sent ensure this "neighboring temperature" for ssr.
> 2 Your new patch returns 0 for node ssr, does get_ssr_segment work only for data?
> 3 I see your new patch just "continue" when i == type, why not consider the current type?
>
> On 2017/2/23 9:17, Jaegeuk Kim wrote:
>> Hi Yunlong,
>>
>> I've been testing the similar patches as I attached.
>>
>> Thanks,
>>
>> On 02/22, Yunlong Song wrote:
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>  fs/f2fs/segment.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 9d13743..5fe71b9 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1540,12 +1540,17 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
>>>  {
>>>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
>>>  	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
>>> +	int old_type = type;
>>>  
>>>  	if (IS_NODESEG(type)) {
>>>  		for (; type >= CURSEG_HOT_NODE; type--)
>>>  			if (v_ops->get_victim(sbi, &(curseg)->next_segno,
>>>  							BG_GC, type, SSR))
>>>  				return 1;
>>> +		for (type = old_type + 1; type <= CURSEG_COLD_NODE; type++)
>>> +			if (v_ops->get_victim(sbi, &(curseg)->next_segno,
>>> +							BG_GC, type, SSR))
>>> +				return 1;
>>>  		return 0;
>>>  	}
>>>  
>>> @@ -1554,6 +1559,10 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
>>>  		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
>>>  						BG_GC, type, SSR))
>>>  			return 1;
>>> +	for (type = old_type + 1; type <= CURSEG_COLD_DATA; type++)
>>> +		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
>>> +						BG_GC, type, SSR))
>>> +			return 1;
>>>  	return 0;
>>>  }
>>>  
>>> -- 
>>> 1.8.5.2
>


-- 
Thanks,
Yunlong Song

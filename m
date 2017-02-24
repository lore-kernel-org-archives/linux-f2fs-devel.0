From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH 3/3] f2fs: provide more chance for node and data to get
 ssr segment
Date: Fri, 24 Feb 2017 17:19:13 +0800
Message-ID: <58AFFA91.2030904@huawei.com>
References: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
 <1487767851-819-3-git-send-email-yunlong.song@huawei.com>
 <20170223011754.GH4003@jaegeuk.local>
 <3d4b064b-817f-402f-3eb5-df3ec7c06b44@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <3d4b064b-817f-402f-3eb5-df3ec7c06b44@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk and Chao,

    How about the question I pointed out in last mail:
    Why not take "neighboring temperature" for ssr? For example, if type == CURSEG_COLD_DATA,
    the new patch selects CURSEG_HOT_DATA first, why not select CURSEG_WARM_DATA first?
    The patch I sent ensure this "neighboring temperature" for ssr. This is to reduce the influence of
    mixing different levels of hot/code node types.

On 2017/2/24 17:05, Chao Yu wrote:
> Hi Jaegeuk,
>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>
> For your attached two patches.
>
> Thanks,
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
> .
>


-- 
Thanks,
Yunlong Song

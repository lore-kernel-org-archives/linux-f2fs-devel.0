From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/3] f2fs: provide more chance for node and
 data to get ssr segment
Date: Fri, 24 Feb 2017 17:05:28 +0800
Message-ID: <3d4b064b-817f-402f-3eb5-df3ec7c06b44@huawei.com>
References: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
	<1487767851-819-3-git-send-email-yunlong.song@huawei.com>
	<20170223011754.GH4003@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1chBp4-0007Uk-5W
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 09:05:54 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chBp2-0005g1-GG
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 09:05:54 +0000
In-Reply-To: <20170223011754.GH4003@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, sylinux@163.com, linux-fsdevel@vger.kernel.org

Hi Jaegeuk,

Reviewed-by: Chao Yu <yuchao0@huawei.com>

For your attached two patches.

Thanks,

On 2017/2/23 9:17, Jaegeuk Kim wrote:
> Hi Yunlong,
> 
> I've been testing the similar patches as I attached.
> 
> Thanks,
> 
> On 02/22, Yunlong Song wrote:
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>  fs/f2fs/segment.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 9d13743..5fe71b9 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1540,12 +1540,17 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
>>  {
>>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
>>  	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
>> +	int old_type = type;
>>  
>>  	if (IS_NODESEG(type)) {
>>  		for (; type >= CURSEG_HOT_NODE; type--)
>>  			if (v_ops->get_victim(sbi, &(curseg)->next_segno,
>>  							BG_GC, type, SSR))
>>  				return 1;
>> +		for (type = old_type + 1; type <= CURSEG_COLD_NODE; type++)
>> +			if (v_ops->get_victim(sbi, &(curseg)->next_segno,
>> +							BG_GC, type, SSR))
>> +				return 1;
>>  		return 0;
>>  	}
>>  
>> @@ -1554,6 +1559,10 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
>>  		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
>>  						BG_GC, type, SSR))
>>  			return 1;
>> +	for (type = old_type + 1; type <= CURSEG_COLD_DATA; type++)
>> +		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
>> +						BG_GC, type, SSR))
>> +			return 1;
>>  	return 0;
>>  }
>>  
>> -- 
>> 1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

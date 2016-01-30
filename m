From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: avoid fix ssa in some case
Date: Sat, 30 Jan 2016 09:43:52 +0800
Message-ID: <56AC1558.80806@huawei.com>
References: <1453969096-11522-1-git-send-email-heyunlei@huawei.com>
	<20160129171207.GA77478@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aPKaH-0003Bx-5p
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:44:17 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aPKaC-0000U6-MO
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:44:17 +0000
In-Reply-To: <20160129171207.GA77478@jaegeuk.gateway>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2016/1/30 1:12, Jaegeuk Kim wrote:
> Hi Yunlei,
>
> On Thu, Jan 28, 2016 at 04:18:16PM +0800, Yunlei He wrote:
>> In some case, we need confirm node or data blkaddr is ok at first,
>> and then fix the conflict in ssa block. If the node blkaddr happen to
>> locate in data type segment caused by something error, may be we 'd
>> better ignore it, and it's same with data blkaddr.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>>   fsck/fsck.c | 34 +++++++++++++++++++++++++---------
>>   1 file changed, 25 insertions(+), 9 deletions(-)
>>
>> diff --git a/fsck/fsck.c b/fsck/fsck.c
>> index e7dd02f..fd82bef 100644
>> --- a/fsck/fsck.c
>> +++ b/fsck/fsck.c
>> @@ -129,6 +129,7 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
>>   {
>>   	struct f2fs_summary_block *sum_blk;
>>   	struct f2fs_summary *sum_entry;
>> +	struct seg_entry * se;
>>   	u32 segno, offset;
>>   	int need_fix = 0, ret = 0;
>>   	int type;
>> @@ -145,9 +146,16 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
>>   			ret = -EINVAL;
>>   			goto out;
>>   		}
>> -		FIX_MSG("Summary footer indicates a node segment: 0x%x", segno);
>> -		sum_blk->footer.entry_type = SUM_TYPE_NODE;
>> +
>>   		need_fix = 1;
>> +		se = get_seg_entry(sbi, segno);
>> +		if(se->type >= 3 && se->type <= 5) {
>
> IS_NODESEG(se->type) ?
>
>> +			FIX_MSG("Summary footer indicates a node segment: 0x%x", segno);
>> +			sum_blk->footer.entry_type = SUM_TYPE_NODE;
>> +		} else {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>>   	}
>>
>>   	sum_entry = &(sum_blk->entries[offset]);
>> @@ -235,6 +243,7 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
>>   {
>>   	struct f2fs_summary_block *sum_blk;
>>   	struct f2fs_summary *sum_entry;
>> +	struct seg_entry * se;
>>   	u32 segno, offset;
>>   	int need_fix = 0, ret = 0;
>>   	int type;
>> @@ -251,9 +260,16 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
>>   			ret = -EINVAL;
>>   			goto out;
>>   		}
>> -		FIX_MSG("Summary footer indicates a data segment: 0x%x", segno);
>> -		sum_blk->footer.entry_type = SUM_TYPE_DATA;
>> +
>>   		need_fix = 1;
>> +		se = get_seg_entry(sbi, segno);
>> +		if (se->type >=0 && se->type <= 2) {
>
> IS_DATASEG(se->type) ?

yeah, it's good!

Thanks.
>
>> +			FIX_MSG("Summary footer indicates a data segment: 0x%x", segno);
>> +			sum_blk->footer.entry_type = SUM_TYPE_DATA;
>> +		} else {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>>   	}
>>
>>   	sum_entry = &(sum_blk->entries[offset]);
>> @@ -352,11 +368,6 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
>>   		return -EINVAL;
>>   	}
>>
>> -	if (is_valid_ssa_node_blk(sbi, nid, ni->blk_addr)) {
>> -		ASSERT_MSG("summary node block is not valid. [0x%x]", nid);
>> -		return -EINVAL;
>> -	}
>> -
>>   	ret = dev_read_block(node_blk, ni->blk_addr);
>>   	ASSERT(ret >= 0);
>>
>> @@ -427,6 +438,11 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
>>   		ASSERT_MSG("orphan or xattr nid is duplicated [0x%x]\n",
>>   				nid);
>>
>> +	if (is_valid_ssa_node_blk(sbi, nid, ni->blk_addr)) {
>> +		ASSERT_MSG("summary node block is not valid. [0x%x]", nid);
>> +		return -EINVAL;
>> +	}
>> +
>>   	if (f2fs_test_sit_bitmap(sbi, ni->blk_addr) == 0)
>>   		ASSERT_MSG("SIT bitmap is 0x0. blk_addr[0x%x]",
>>   				ni->blk_addr);
>> --
>> 1.9.1
>>
>>
>> ------------------------------------------------------------------------------
>> Site24x7 APM Insight: Get Deep Visibility into Application Performance
>> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
>> Monitor end-to-end web transactions and take corrective actions now
>> Troubleshoot faster and improve end-user experience. Signup Now!
>> http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
> .
>


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140

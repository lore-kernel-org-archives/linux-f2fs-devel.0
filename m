From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: get victim segment again after new
	cp
Date: Sun, 24 Jul 2016 06:38:46 +0800
Message-ID: <6fbd66c3-ccfc-0389-dde5-81b901cb4586@kernel.org>
References: <1469185711-27932-1-git-send-email-heyunlei@huawei.com>
	<20160722185922.GA36408@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bR5ZS-000514-Sq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jul 2016 22:38:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bR5ZR-00081e-Nn
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jul 2016 22:38:58 +0000
In-Reply-To: <20160722185922.GA36408@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Yunlei He <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2016/7/23 2:59, Jaegeuk Kim wrote:
> Hi Yunlei,
> 
> On Fri, Jul 22, 2016 at 07:08:31PM +0800, Yunlei He wrote:
>> Previous selected segment may become free after write_checkpoint,
>> if we do garbage collect on this segment, and then new_curseg happen
>> to reuse it, it may cause f2fs_bug_on as below.
>>
>> 	panic+0x154/0x29c
>> 	do_garbage_collect+0x15c/0xaf4
>> 	f2fs_gc+0x2dc/0x444
>> 	f2fs_balance_fs.part.22+0xcc/0x14c
>> 	f2fs_balance_fs+0x28/0x34
>> 	f2fs_map_blocks+0x5ec/0x790
>> 	f2fs_preallocate_blocks+0xe0/0x100
>> 	f2fs_file_write_iter+0x64/0x11c
>> 	new_sync_write+0xac/0x11c
>> 	vfs_write+0x144/0x1e4
>> 	SyS_write+0x60/0xc0
>>
>> Here, maybe we check sit and ssa type during reset_curseg. So, we check
>> segment is stale or not, and select a new victim to avoid this.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>>  fs/f2fs/gc.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index de6c41c..ec17096 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -908,10 +908,14 @@ gc_more:
>>  		 * enough free sections, we should flush dent/node blocks and do
>>  		 * garbage collections.
>>  		 */
>> -		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi))
>> +		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi)) {
>>  			write_checkpoint(sbi, &cpc);
>> -		else if (has_not_enough_free_secs(sbi, 0))
> 
> If segno is NULL_SEGNO, we get a panic when checking the below conditions.
> Anyway, I don't think we need this condition at all.

I thinks the condition which trigger our f2fs_bug_on is really a corner case,
we'd better not waste the victim we found everytime, especially for these
victims from last background gc's victims.

What about checking segno first?

if(segno != NULL_SEGNO && (!get_valid_blocks(sbi, segno, sbi->segs_per_sec) ||
	IS_CURSEC(sbi, GET_SECNO(sbi, segno)))
	segno = NULL_SEGNO;

Thanks,

> Let me remove them and just set NULL_SEGNO only after checkpoint.
> Please check the dev-test repo.
> 
> Thanks,
> 
>> +			if(!get_valid_blocks(sbi, segno, sbi->segs_per_sec)
>> +					|| IS_CURSEC(sbi, segno / sbi->segs_per_sec))
>> +				segno = NULL_SEGNO;
>> +		} else if (has_not_enough_free_secs(sbi, 0)) {
>>  			write_checkpoint(sbi, &cpc);
>> +		}
>>  	}
>>  
>>  	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
>> -- 
>> 1.9.1
> 
> ------------------------------------------------------------------------------
> What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
> patterns at an interface-level. Reveals which users, apps, and protocols are 
> consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
> J-Flow, sFlow and other flows. Make informed decisions using capacity planning
> reports.http://sdm.link/zohodev2dev
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev

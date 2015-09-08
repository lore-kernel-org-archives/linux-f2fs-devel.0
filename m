From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: add a judgment in add_discard_addrs
Date: Wed, 9 Sep 2015 07:53:31 +0800
Message-ID: <55EF74FB.8050600@huawei.com>
References: <1441709473-21297-1-git-send-email-heyunlei@huawei.com>
	<001d01d0ea27$9d4c6cc0$d7e54640$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZZSiH-0000Mq-8y
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Sep 2015 23:54:09 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZZSiE-0001Er-1o
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Sep 2015 23:54:09 +0000
In-Reply-To: <001d01d0ea27$9d4c6cc0$d7e54640$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2015/9/8 19:14, Chao Yu wrote:
> Hi Yunlei,
>
>> -----Original Message-----
>> From: Yunlei He [mailto:heyunlei@huawei.com]
>> Sent: Tuesday, September 08, 2015 6:51 PM
>> To: chao2.yu@samsung.com; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
>> Cc: bintian.wang@huawei.com; Yunlei He
>> Subject: [f2fs-dev] [PATCH] f2fs: add a judgment in add_discard_addrs
>>
>> CP_DISCARD traverse all segments in fstrim_range to add small discards,
>> it is better to select entry->len bigger than trim_minlen.
>
> If we mount with 'discard' option, f2fs will trigger real-time discard
> when do checkpoint. If we add judgment condition here, fragmented invalid
> blocks will not be discarded since we stop adding them in pending list
> through __add_discard_entry.

This judgment condition is only valid for cp reason CP_DISCARD, and has no influence
to other checkpoint. The process of fstrim adds all invalid blocks in pending list and
deletes entries which len < trim_minlen when issue discard. Can we do the selection
when added?

Thanks,

>
> Thanks,
>
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>>   fs/f2fs/segment.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 78e6d06..a0dab7a 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -599,7 +599,8 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control
>> *cpc)
>>   			break;
>>
>>   		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
>> -		__add_discard_entry(sbi, cpc, se, start, end);
>> +		if(force && cpc->trim_minlen >= (end - start))
>> +			__add_discard_entry(sbi, cpc, se, start, end);
>>   	}
>>   }
>>
>> --
>> 1.9.1
>
>
>


------------------------------------------------------------------------------

From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: avoid hungtask problem caused by
 losing wake_up
Date: Tue, 23 Feb 2016 19:45:39 +0800
Message-ID: <56CC4663.704@huawei.com>
References: <1456200476-9811-1-git-send-email-heyunlei@huawei.com>
	<009501d16dfd$52a518c0$f7ef4a40$@samsung.com>
	<56CC0410.50103@huawei.com> <56CC2714.7040901@kernel-upstream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aYBQE-0003sn-5x
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 11:46:30 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aYBQ8-0002UI-FW
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 11:46:30 +0000
In-Reply-To: <56CC2714.7040901@kernel-upstream.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Shawn Lin <shawn.lin@kernel-upstream.org>, Chao Yu <chao2.yu@samsung.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: 'Biao He' <hebiao6@huawei.com>, shawn.lin@rock-chips.com

On 2016/2/23 17:32, Shawn Lin wrote:
> On 2016/2/23 15:02, He YunLei wrote:
>> On 2016/2/23 13:44, Chao Yu wrote:
>>> Hi Yunlei,
>> Hi Chao,
>>>
>>>> -----Original Message-----
>>>> From: Yunlei He [mailto:heyunlei@huawei.com]
>>>> Sent: Tuesday, February 23, 2016 12:08 PM
>>>> To: chao2.yu@samsung.com; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
>>>> Cc: bintian.wang@huawei.com; Yunlei He; Biao He
>>>> Subject: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem caused by losing wake_up
>>>>
>>>> The D state of wait_on_all_pages_writeback should be waken by
>>>> function f2fs_write_end_io when all writeback pages have been
>>>> succesfully written to device. It's possible that wake_up comes
>>>> between get_pages and io_schedule. Maybe in this case it will
>>>> lost wake_up and still in D state even if all pages have been
>>>> write back to device, and finally, the whole system will be into
>>>> the hungtask state.
>>>
>>> I haven't encountered such issue so far, do you suffer this in real
>>> world?
>>>
>> yes, I have encounter it, the whole file system is blocked at function
>> wait_on_all_pages_writeback beyond 120s when write cp, and no error reported
>> by storage device driver.
>
Hi Shawn,
> Hi YunLei
>
> Interesting...
> How to prove the page isn't been locked by storage block layer which
> doesn't finish the related bio?
>
> I suffer that case before, but then I solve it by seting a timer to
> break my mmc driver while missing some important interrupts(chip
> problem) for data-transfer to finish the io queue by mmcqd.
>
Thanks for your review, I has replied Chao about the info of f2fs_sb_info,
and from the info we can make sure the block layer and device driver are
both ok.

> Another thing,
> why making 5HZ for timeout? why not 10HZ ,15HZ...
> io_schedule_timeout(5*HZ);
>

We choose 5HZ in our test, maybe other value is more reasonable.

>>>>
>>>>                   if (!get_pages(sbi, F2FS_WRITEBACK))
>>>>                            break;
>>>>                     <---------  wake_up
>>>
>>> wake_up will put all tasks linked in sbi->cp_wait on run-queue, so
>>> here it should be save to call io_schedule, after being rescheduled,
>>> it will get the chance to check above condition to break out.
>>>
>>> Thanks,
>>
>> Here, we just doubt something weird may cause wait_on_all_pages_writeback
>> could not be waken. Wake_up trigger only one time by last bio's end_io
>> function, if the thread happen to miss it, the thread will be in D state
>> forever. So we change the code to make wait_on_all_pages_writeback awaken
>> periodically, then check the condition.
>>
>>>
>>>>                   io_schedule();
>>>>
>>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>>> Signed-off-by: Biao He <hebiao6@huawei.com>
>>>> ---
>>>>    fs/f2fs/checkpoint.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index 2bac8a1..f55355d 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -920,7 +920,7 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
>>>>            if (!get_pages(sbi, F2FS_WRITEBACK))
>>>>                break;
>>>>
>>>> -        io_schedule();
>>>> +        io_schedule_timeout(5*HZ);
>>>>        }
>>>>        finish_wait(&sbi->cp_wait, &wait);
>>>>    }
>>>> --
>>>> 1.9.1
>>>
>>>
>>>
>>> .
>>>
>>
>>
>> ------------------------------------------------------------------------------
>> Site24x7 APM Insight: Get Deep Visibility into Application Performance
>> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
>> Monitor end-to-end web transactions and take corrective actions now
>> Troubleshoot faster and improve end-user experience. Signup Now!
>> http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
>
>
> .
>


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140

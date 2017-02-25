From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: avoid unnecessary fg_gc
Date: Sat, 25 Feb 2017 10:23:11 +0800
Message-ID: <ce5a4256-9275-eb89-e188-f5f200b8f77c@huawei.com>
References: <20170224100135.70000-1-houpengyang@huawei.com>
	<0486c0d4-541c-ee21-c598-6656a291a274@huawei.com>
	<58B0E17C.1030306@huawei.com> <20170225020733.GB50867@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1chS2T-0001UH-MA
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 02:24:49 +0000
Received: from [45.249.212.191] (helo=dggrg05-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chS2R-0008HB-K7
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 02:24:49 +0000
In-Reply-To: <20170225020733.GB50867@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Hou Pengyang <houpengyang@huawei.com>
Cc: guoweichao@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi all,

I am really confused by the condition below use sec_freed, is it always equal to zero?

Or, gc more process will recheck this condition?

	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed, 0))


On 2017/2/25 10:07, Jaegeuk Kim wrote:
> On 02/25, Hou Pengyang wrote:
>> On 2017/2/24 18:28, Chao Yu wrote:
>>> On 2017/2/24 18:01, Hou Pengyang wrote:
>>>> Under scenerio with large number of dirty nodes, and these nodes are flushed
>>>> in SSR mode during cp. enough free segemts now, no need to do fggc.
>>>
>>> We'd better break out of GC flow once we encounter cp error, so additional
>>> condition judgment is not needed.
>>>
>>
>> In (ret || !has_not_enough_free_secs(sbi, sec_freed, 0)),
>> if cp return error(NOT zero), flow will goto stop directly without
>> has_not_enough_free_secs checking;
>> if cp return ok(zero), has_not_enough_free_secs would be checked.
>
> Well, I think it'd be fine to do one gc by a background thread.
>
> Thanks,
>
>>
>> Thanks,
>>
>>> Thanks,
>>>
>>>>
>>>> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
>>>> ---
>>>>   fs/f2fs/gc.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>> index 6c996e3..41bdfb7 100644
>>>> --- a/fs/f2fs/gc.c
>>>> +++ b/fs/f2fs/gc.c
>>>> @@ -959,7 +959,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
>>>>   		 * garbage collections.
>>>>   		 */
>>>>   		ret = write_checkpoint(sbi, &cpc);
>>>> -		if (ret)
>>>> +		if (ret || !has_not_enough_free_secs(sbi, sec_freed, 0))
>>>>   			goto stop;
>>>>   	} else if (gc_type == BG_GC && !background) {
>>>>   		/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
>>>>
>>>
>>>
>>> .
>>>
>>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

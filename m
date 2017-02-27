From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: skip checkpoint if having a dirty
 segment but no prefree at BG_GC -> FG_GC
Date: Mon, 27 Feb 2017 11:25:21 +0800
Message-ID: <b95af89a-de0c-1242-bf0e-8782eff797f1@huawei.com>
References: <20170224204357.220337-1-guoweichao@huawei.com>
	<20170224184959.GD39009@jaegeuk.local>
	<e3da3ac3-39d5-3880-2e38-ab523a7781ec@huawei.com>
	<20170225195603.GF51627@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciBwa-0007fA-7N
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 03:25:48 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciBwW-0000yZ-O9
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 03:25:48 +0000
In-Reply-To: <20170225195603.GF51627@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, guoweichao <guoweichao@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/2/26 3:56, Jaegeuk Kim wrote:
> On 02/25, guoweichao wrote:
>> Hi Jaegeuk,
>>
>> I regard no enough free sections as a precondition when talking about
>> BG_GC -> FG_GC. I mean that for both case a) and b) I mentioned has no enough
>> free sections implicitly. 
>>
>> On 2017/2/25 2:49, Jaegeuk Kim wrote:
>>> Hi Weichao,
>>>
>>> On 02/25, Weichao Guo wrote:
>>>> When turning to FG_GC from BG_GC, we need to write checkpoint in 2 cases:
>>>> * a) BG_GC have made some progress, e.g.: some prefree segments.
>>>> * b) There is no victim and no prefree segment.
>>>
>>> You missed
>>>   * c) has_not_enough_free_secs() introduced by
>>>       6e17bfbc75a5cb ("f2fs: fix to overcome inline_data floods")
>> As we have enabled SSR for warm node(5b6c6be2d8 ("f2fs: use SSR for warm node as well")),
>> I think inline data floods should not be a problem in most cases.
>>>
>>> And, Yunlong pointed that we can't find a case to avoid write_checkpoint()
>>> mostly due to c) condition.
>> As inline data floods is an extreme case, and there is little possibility caused panic
>> for inline data floods now, there should be lots of chance to skip checkpoint. I mean
>> that we can make some accurate inline data floods checking before writing checkpoint.
> 
> For now, the safest way is our first option. So, I decided to start with doing
> checkpoint due to previous inline_data flooding issue even though it's an
> extreme case under SSR.
> 
> Anyway, I agree that we need to find a way to detect when to avoid checkpoint.

Hi all,

I proposed a approach before, can you please check that one?

https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg03632.html

Thanks,

> 
> Thanks,
> 
>>>
>>> Thanks,
>>>
>>>>
>>>> For case a), previously, we also check if there is a dirty segment for
>>>> infering blocks moving in last BG_GC. But dirty segments do not always
>>>> indicate that, BG_GC may just start and do not move any blocks at all.
>>>> Futhermore, skipping checkpoint if there are some dirty segments but no
>>>> prefree segments is OK.
>>>
>>>
>>>>
>>>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>>>> ---
>>>>  fs/f2fs/gc.c | 7 ++++++-
>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>> index 6c996e3..30d206a 100644
>>>> --- a/fs/f2fs/gc.c
>>>> +++ b/fs/f2fs/gc.c
>>>> @@ -958,7 +958,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
>>>>  		 * enough free sections, we should flush dent/node blocks and do
>>>>  		 * garbage collections.
>>>>  		 */
>>>> -		ret = write_checkpoint(sbi, &cpc);
>>>> +		if (prefree_segments(sbi))
>>>> +			ret = write_checkpoint(sbi, &cpc);
>>>> +		else if (!__get_victim(sbi, &segno, gc_type) {
>>>> +			segno = NULL_SEGNO;
>>>> +			ret = write_checkpoint(sbi, &cpc);
>>>> +		}
>>>>  		if (ret)
>>>>  			goto stop;
>>>>  	} else if (gc_type == BG_GC && !background) {
>>>> -- 
>>>> 2.10.1
>>>
>>> .
>>>
>>
>> Thanks,
>> Weichao
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

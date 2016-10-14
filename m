From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix wrong sum_page pointer in f2fs_gc
Date: Fri, 14 Oct 2016 21:25:59 +0800
Message-ID: <3ed5607f-0fe6-02cb-8c95-782913e65b5b@kernel.org>
References: <20161012232304.6667-1-jaegeuk@kernel.org>
	<faeadd54-7814-41b5-b041-2d0eb819c3f6@huawei.com>
	<20161013171421.GA6363@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bv2VG-0008UJ-Ed
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 13:26:26 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bv2VF-0001Dt-Bc
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 13:26:26 +0000
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B34BF2040F
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 14 Oct 2016 13:26:18 +0000 (UTC)
Received: from [192.168.1.103] (unknown [180.111.32.219])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B847F203FB
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 14 Oct 2016 13:26:16 +0000 (UTC)
In-Reply-To: <20161013171421.GA6363@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

On 2016/10/14 1:14, Jaegeuk Kim wrote:
> On Thu, Oct 13, 2016 at 06:33:19PM +0800, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2016/10/13 7:23, Jaegeuk Kim wrote:
>>> This patch fixes using a wrong pointer for sum_page in f2fs_gc.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/gc.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index e48142f..9c18917 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -854,16 +854,16 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>  
>>>  	for (segno = start_segno; segno < end_segno; segno++) {
>>>  
>>> -		if (get_valid_blocks(sbi, segno, 1) == 0 ||
>>> -					unlikely(f2fs_cp_error(sbi)))
>>> -			goto next;
>>> -
>>>  		/* find segment summary of victim */
>>>  		sum_page = find_get_page(META_MAPPING(sbi),
>>>  					GET_SUM_BLOCK(sbi, segno));
>>> -		f2fs_bug_on(sbi, !PageUptodate(sum_page));
>>>  		f2fs_put_page(sum_page, 0);
>>>  
>>> +		if (get_valid_blocks(sbi, segno, 1) == 0 ||
>>> +				!PageUptodate(sum_page) ||
>>
>> Why uptodate flag of summary page can be cleared? someone truncates it?
> 
> Well, it looks like no problem to remove this, since it will hit
> f2fs_cp_error(). I just intended to handle the above f2fs_bug_on here.

If summary page becomes non-uptodate, it seems there is a bug in vfs/mm/f2fs,
why not keep it there to detect bug?

Thanks,

> 
> I found you added the above bug_on, but it's not a big deal to remain tho. :)
> 
> 718e53fa: f2fs: enhance foreground GC
> 
> Thanks,
> 
>>
>> Thanks,
>>
>>> +				unlikely(f2fs_cp_error(sbi)))
>>> +			goto next;
>>> +
>>>  		sum = page_address(sum_page);
>>>  		f2fs_bug_on(sbi, type != GET_SUM_TYPE((&sum->footer)));
>>>  
>>>
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most 
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

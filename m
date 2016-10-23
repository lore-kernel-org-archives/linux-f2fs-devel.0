From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix wrong sum_page pointer in f2fs_gc
Date: Sun, 23 Oct 2016 20:26:15 +0800
Message-ID: <3a96264b-b187-a5ce-2279-f9edd3748838@kernel.org>
References: <20161012232304.6667-1-jaegeuk@kernel.org>
	<faeadd54-7814-41b5-b041-2d0eb819c3f6@huawei.com>
	<20161013171421.GA6363@jaegeuk>
	<3ed5607f-0fe6-02cb-8c95-782913e65b5b@kernel.org>
	<20161014165700.GA67182@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1byHrI-0001xm-Rr
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 23 Oct 2016 12:26:36 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1byHrH-0002u0-Sn
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 23 Oct 2016 12:26:36 +0000
In-Reply-To: <20161014165700.GA67182@jaegeuk>
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

On 2016/10/15 0:57, Jaegeuk Kim wrote:
> On Fri, Oct 14, 2016 at 09:25:59PM +0800, Chao Yu wrote:
>> On 2016/10/14 1:14, Jaegeuk Kim wrote:
>>> On Thu, Oct 13, 2016 at 06:33:19PM +0800, Chao Yu wrote:
>>>> Hi Jaegeuk,
>>>>
>>>> On 2016/10/13 7:23, Jaegeuk Kim wrote:
>>>>> This patch fixes using a wrong pointer for sum_page in f2fs_gc.
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  fs/f2fs/gc.c | 10 +++++-----
>>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>> index e48142f..9c18917 100644
>>>>> --- a/fs/f2fs/gc.c
>>>>> +++ b/fs/f2fs/gc.c
>>>>> @@ -854,16 +854,16 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>>>  
>>>>>  	for (segno = start_segno; segno < end_segno; segno++) {
>>>>>  
>>>>> -		if (get_valid_blocks(sbi, segno, 1) == 0 ||
>>>>> -					unlikely(f2fs_cp_error(sbi)))
>>>>> -			goto next;
>>>>> -
>>>>>  		/* find segment summary of victim */
>>>>>  		sum_page = find_get_page(META_MAPPING(sbi),
>>>>>  					GET_SUM_BLOCK(sbi, segno));
>>>>> -		f2fs_bug_on(sbi, !PageUptodate(sum_page));
>>>>>  		f2fs_put_page(sum_page, 0);
>>>>>  
>>>>> +		if (get_valid_blocks(sbi, segno, 1) == 0 ||
>>>>> +				!PageUptodate(sum_page) ||
>>>>
>>>> Why uptodate flag of summary page can be cleared? someone truncates it?
>>>
>>> Well, it looks like no problem to remove this, since it will hit
>>> f2fs_cp_error(). I just intended to handle the above f2fs_bug_on here.
>>
>> If summary page becomes non-uptodate, it seems there is a bug in vfs/mm/f2fs,
>> why not keep it there to detect bug?
> 
> I found that the above get_sum_page() loop can give a page which is not uptodate
> caused by EIO. Then, we would get the above bug_on, if we move f2fs_cp_error()
> case like this patch.
> 
> Thoughts?

Seems this patch has already been merged into linus' tree...

Anyway, I can understand why you remove f2fs_bug_on & add PageUptodate here, but
why should we repositon below check?

if (get_valid_blocks(sbi, segno, 1) == 0 ||
		unlikely(f2fs_cp_error(sbi)))

Thanks,

> 
> Thanks,
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

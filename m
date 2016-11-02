From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: return directly if block has been
 removed from the victim
Date: Wed, 2 Nov 2016 15:19:27 +0800
Message-ID: <ef2c3b03-8b2c-d64c-fbbf-b32737b423ea@huawei.com>
References: <20161024033728.10780-1-heyunlei@huawei.com>
	<20161026010926.GA4173@jaegeuk>
	<5f96184b-43b9-871d-3c3b-32ef9e656449@huawei.com>
	<20161027223453.GA18682@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c1ps5-0000yb-6Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Nov 2016 07:22:05 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c1prx-0004Cz-M9
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Nov 2016 07:22:05 +0000
In-Reply-To: <20161027223453.GA18682@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, heyunlei <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2016/10/28 6:34, Jaegeuk Kim wrote:
> On Wed, Oct 26, 2016 at 10:14:04AM +0800, heyunlei wrote:
>>
>>
>> On 2016/10/26 9:09, Jaegeuk Kim wrote:
>> Hi Kim,
>>> Hi Yunlei,
>>>
>>> On Mon, Oct 24, 2016 at 11:37:28AM +0800, Yunlei He wrote:
>>>> If one block has been to written to a new place, just return
>>>> in move data process.
>>>>
>>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>>> ---
>>>>  fs/f2fs/gc.c | 17 ++++++++++++-----
>>>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>> index f35fca5..fc78f3e 100644
>>>> --- a/fs/f2fs/gc.c
>>>> +++ b/fs/f2fs/gc.c
>>>> @@ -545,7 +545,8 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>>  	return true;
>>>>  }
>>>>
>>>> -static void move_encrypted_block(struct inode *inode, block_t bidx)
>>>> +static void move_encrypted_block(struct inode *inode, block_t bidx,
>>>> +						unsigned int segno, int off)
>>>>  {
>>>>  	struct f2fs_io_info fio = {
>>>>  		.sbi = F2FS_I_SB(inode),
>>>> @@ -580,6 +581,9 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>>>>  	 * don't cache encrypted data into meta inode until previous dirty
>>>>  	 * data were writebacked to avoid racing between GC and flush.
>>>>  	 */
>>>> +	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>>> +		goto out;
>>>
>>> This is done by gc_data_segment() before calling move function.
>>> Why do we need this again?
>>
>> gc_data_segment() check this without lock the data page. If this block
>> is written to a new place between check in gc_data_segment() and locked
>> the page, it will need to wait this page write back, and write it again,
>> it's unnecessary.
>>
>>>
>>>> +
>>>>  	f2fs_wait_on_page_writeback(page, DATA, true);
>>>>
>>>>  	get_node_info(fio.sbi, dn.nid, &ni);
>>>> @@ -646,7 +650,8 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>>>>  	f2fs_put_page(page, 1);
>>>>  }
>>>>
>>>> -static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
>>>> +static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>>> +							unsigned int segno, int off)
>>>>  {
>>>>  	struct page *page;
>>>>
>>>> @@ -655,8 +660,10 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
>>>>  		return;
>>>>
>>>>  	if (gc_type == BG_GC) {
>>>> -		if (PageWriteback(page))
>>>
>>> Seems there is no reason to remove the existing writeback case.
>>> This is a BG_GC case and we don't need to proceed GC in this case.
>>    Here, PageWriteback(page) means two cases:
>> 1. write to this victim segment
>> 2. write to a new place
>>
>> In the first case, if we return directly, this victim bg_gc will fail
>> for some blocks are still valid.
> 
> It should be fine, and its main reason would be to avoid wait_on_page_writeback.
> Next bg_gc will do better.

Agreed.

Yunlei, I think it's better add this judgment condition after we grabbed locked
data page for covering both background and foreground GC cases, instead of
changing previous process logic.

Thanks,

> 
> Thanks,
> 
> ------------------------------------------------------------------------------
> The Command Line: Reinvented for Modern Developers
> Did the resurgence of CLI tooling catch you by surprise?
> Reconnect with the command line and become more productive. 
> Learn the new .NET and ASP.NET CLI. Get your free copy!
> http://sdm.link/telerik
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi

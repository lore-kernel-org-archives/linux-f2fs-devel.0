From: Hou Pengyang <houpengyang@huawei.com>
Subject: Re: [PATCH] f2fs: fix conflict between atomic_write and
 truncate
Date: Tue, 13 Dec 2016 09:34:29 +0800
Message-ID: <584F5025.9000004@huawei.com>
References: <20161212131618.92800-1-houpengyang@huawei.com>
	<20161212191851.GC61413@jaegeuk.local>
	<584F4AD8.4000008@huawei.com> <20161213012109.GA8811@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1cGbzo-00052d-KJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Dec 2016 01:35:08 +0000
Received: from [119.145.14.66] (helo=szxga03-in.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cGbzk-0006vn-KB
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Dec 2016 01:35:08 +0000
In-Reply-To: <20161213012109.GA8811@jaegeuk.local>
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
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/12/13 9:21, Jaegeuk Kim wrote:
> Hi,
>
> On 12/13, Hou Pengyang wrote:
>> On 2016/12/13 3:18, Jaegeuk Kim wrote:
>>> Hi Pengyang,
>>>
>> Hi, kim,
>>> On 12/12, Hou Pengyang wrote:
>>>> In fsync_node_pages path, after locking the last_page for setting dirty,
>>>> we should check if the page has been truncated. Or there may be a mem leak,
>>>> as this dirty last_page will NOT be found in next page-cache travese.
>>>>
>>>> This patch adds page->mapping checking, and will NOT rewrite the page if
>>>> it has been truncated.
>>>>
>>>> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
>>>> ---
>>>>    fs/f2fs/node.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>> index c1bbfdc..78c5b50 100644
>>>> --- a/fs/f2fs/node.c
>>>> +++ b/fs/f2fs/node.c
>>>> @@ -1410,6 +1410,11 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>>>>    			"Retry to write fsync mark: ino=%u, idx=%lx",
>>>>    					ino, last_page->index);
>>>>    		lock_page(last_page);
>>>
>>> We grabbed a reference count for this last_page, and thus, it won't be released.
>>> Something that I missed?
>>>
>> Some path (e.g. shrink) would NOT release the page if we've grabbed it,
>> But truncate operation will invalidate the page from page-cache
>> regardless of the page reference.
>
> This is a node page, and we guarantee that nobody will truncate them.
> Did you hit an issue regarding to this?
>
As my view, the truncate operations may lead to the related node pages 
being truncated, or I miss something.

> Thanks,
>
>> Patch: 0fac558b965 f2fs: make atomic/volatile operation exclusive
>> seems fix this issue by adding inode_lock(inode) to avoid conflict
>> between atomic/volatile and truncate operation.
>>
>> But this patch makes codes more robust.
>>
>> Thanks.
>>
>>> Thanks,
>>>
>>>> +		if (unlikely(last_page->mapping != NODE_MAPPING(sbi))) {
>>>> +			unlock_page(last_page);
>>>> +			f2fs_put_page(last_page, 0);
>>>> +			goto out;
>>>> +		}
>>>>    		f2fs_wait_on_page_writeback(last_page, NODE, true);
>>>>    		set_page_dirty(last_page);
>>>>    		unlock_page(last_page);
>>>> --
>>>> 2.10.1
>>>>
>>>>
>>>> ------------------------------------------------------------------------------
>>>> Developer Access Program for Intel Xeon Phi Processors
>>>> Access to Intel Xeon Phi processor-based developer platforms.
>>>> With one year of Intel Parallel Studio XE.
>>>> Training and support from Colfax.
>>>> Order your platform today.http://sdm.link/xeonphi
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
>>> .
>>>
>>
>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
> .
>



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

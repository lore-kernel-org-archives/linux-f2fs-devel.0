From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: enable to gc page whose inode
 already atomic commit
Date: Mon, 5 Feb 2018 17:37:40 +0800
Message-ID: <3182ade9-4153-9e47-f8a5-5c87371a3900@huawei.com>
References: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
 <a094cd40-d042-2a43-4e9a-e34c31e61d28@kernel.org>
 <f4e7b403-4945-a7f9-6bdc-214dc61c9160@huawei.com>
 <312d70f3-b1ae-9ced-44cb-fde83de362ff@huawei.com>
 <b39adaf3-f727-e6ad-ef0d-4789cdc38de5@huawei.com>
 <f3c1c01d-3d82-5546-7aec-73c2e69cd17a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eidEu-000753-Cq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Feb 2018 09:39:04 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eidEs-0006gq-R6
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Feb 2018 09:39:04 +0000
In-Reply-To: <f3c1c01d-3d82-5546-7aec-73c2e69cd17a@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yunlong.song@icloud.com
Cc: shengyong1@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, miaoxie@huawei.com


> OK, details as I explained before:
> 
> atomic_commit				GC
> - file_write_and_wait_range
> 					- move_data_block
> 					 - f2fs_submit_page_write
> 					  - f2fs_update_data_blkaddr
> 					   - set_page_dirty
>   - fsync_node_pages
> 
> 1. atomic writes data page #1 & update node #1
> 2. GC data page #2 & update node #2
> 3. page #1 & node #1 & #2 can be committed into nand flash before page #2 be
> committed.
> 
> After a sudden pow-cut, database transaction will be inconsistent. So I think
> there will be better to exclude gc/atomic_write to each other, with a lock
> instead of flag checking.
> 

I do not understand why this transaction is inconsistent, is it a
problem that page #2 is not committed into nand flash? Since normal
gc also has this problem:

Suppose that there is db file A, f2fs_gc moves data page #1 of db file
A. But if write checkpoint only commit node page #1 and then a sudden
power-cut happens. Data page #1 is not committed to nand flash, but
node page #1 is committed. Is the db transaction broken and
inconsistent?

Come back to your example, I think data page 2 of atomic file does not
belong to this transaction, so even node page 2 is committed, it is just
the same problem as what I have listed above(db file A), and it does not
break this transaction.

> Thanks,
> 
>>>>>
>>>>> So how about just using dio_rwsem[WRITE] during atomic committing to exclude
>>>>> GCing data block of atomic opened file?
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>>> ---
>>>>>>     fs/f2fs/data.c | 5 ++---
>>>>>>     fs/f2fs/gc.c   | 6 ++++--
>>>>>>     2 files changed, 6 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>> index 7435830..edafcb6 100644
>>>>>> --- a/fs/f2fs/data.c
>>>>>> +++ b/fs/f2fs/data.c
>>>>>> @@ -1580,14 +1580,13 @@ bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>>>>>>     		return true;
>>>>>>     	if (S_ISDIR(inode->i_mode))
>>>>>>     		return true;
>>>>>> -	if (f2fs_is_atomic_file(inode))
>>>>>> -		return true;
>>>>>>     	if (fio) {
>>>>>>     		if (is_cold_data(fio->page))
>>>>>>     			return true;
>>>>>>     		if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
>>>>>>     			return true;
>>>>>> -	}
>>>>>> +	} else if (f2fs_is_atomic_file(inode))
>>>>>> +		return true;
>>>>>>     	return false;
>>>>>>     }
>>>>>>     
>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>>> index b9d93fd..84ab3ff 100644
>>>>>> --- a/fs/f2fs/gc.c
>>>>>> +++ b/fs/f2fs/gc.c
>>>>>> @@ -622,7 +622,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>>>>>     	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>>>>>     		goto out;
>>>>>>     
>>>>>> -	if (f2fs_is_atomic_file(inode))
>>>>>> +	if (f2fs_is_atomic_file(inode) &&
>>>>>> +		!f2fs_is_commit_atomic_write(inode))
>>>>>>     		goto out;
>>>>>>     
>>>>>>     	if (f2fs_is_pinned_file(inode)) {
>>>>>> @@ -729,7 +730,8 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>>>>>     	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>>>>>     		goto out;
>>>>>>     
>>>>>> -	if (f2fs_is_atomic_file(inode))
>>>>>> +	if (f2fs_is_atomic_file(inode) &&
>>>>>> +		!f2fs_is_commit_atomic_write(inode))
>>>>>>     		goto out;
>>>>>>     	if (f2fs_is_pinned_file(inode)) {
>>>>>>     		if (gc_type == FG_GC)
>>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
>>>
>>>
>>> .
>>>
>>
> 
> 
> .
> 

-- 
Thanks,
Yunlong Song


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

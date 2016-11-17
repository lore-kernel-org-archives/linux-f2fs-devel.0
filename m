From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix fdatasync
Date: Thu, 17 Nov 2016 11:35:58 +0800
Message-ID: <3407da1c-ee9c-3a8d-de26-cebd18a79057@huawei.com>
References: <20161116121211.11790-1-yuchao0@huawei.com>
	<20161116191312.GA57609@jaegeuk>
	<25a9f225-ba22-d0cd-54ff-4a75031bb161@huawei.com>
	<20161117025911.GA67852@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c7DUs-0007yr-9P
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 03:36:22 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c7DUp-0005Jf-OU
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 03:36:22 +0000
In-Reply-To: <20161117025911.GA67852@jaegeuk>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/11/17 10:59, Jaegeuk Kim wrote:
> On Thu, Nov 17, 2016 at 10:51:37AM +0800, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2016/11/17 3:13, Jaegeuk Kim wrote:
>>> Hi Chao,
>>>
>>> On Wed, Nov 16, 2016 at 08:12:11PM +0800, Chao Yu wrote:
>>>> For below two cases, we can't guarantee data consistence:
>>>>
>>>> a)
>>>> 1. xfs_io "pwrite 0 4195328" "fsync"
>>>> 2. xfs_io "pwrite 4195328 1024" "fdatasync"
>>>> 3. godown
>>>> 4. umount & mount
>>>> --> isize we updated before fdatasync won't be recovered
>>>>
>>>> b)
>>>> 1. xfs_io "pwrite -S 0xcc 0 4202496" "fsync"
>>>> 2. xfs_io "fpunch 4194304 4096" "fdatasync"
>>>> 3. godown
>>>> 4. umount & mount
>>>> --> dnode we punched before fdatasync won't be recovered
>>>>
>>>> The reason is that normally fdatasync won't be aware of modification
>>>> of metadata in file, e.g. isize changing, dnode updating, so in ->fsync
>>>> we will skip flushing node pages for above cases, result in making
>>>> fdatasynced file being lost during recovery.
>>>>
>>>> Introduce FDATASYNC_INO global ino cache for tracking node changing,
>>>> later fdatasync choose to flush nodes depend on ino cache state.
>>>
>>> We don't need to add this additionally, and would be better to consider other
>>> major metadata as well.
>>>
>>> How about this?
>>
>> Seems it can't track file after evict?
> 
> Do we need that? That means inode page was already up-to-date?

I mean if node/data page of inode were writeback by kworker, after evict, if
user open it again and call fdatasync, after sudden power-off, we will not
recover it.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> ---
>>>  fs/f2fs/f2fs.h | 11 ++++++++++-
>>>  fs/f2fs/file.c |  2 +-
>>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index c9672a3..50ffa4f 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -1727,8 +1727,17 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
>>>  		set_inode_flag(inode, FI_AUTO_RECOVER);
>>>  }
>>>  
>>> -static inline bool f2fs_skip_inode_update(struct inode *inode)
>>> +static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
>>>  {
>>> +	if (dsync) {
>>> +		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>> +		bool ret;
>>> +
>>> +		spin_lock(&sbi->inode_lock[DIRTY_META]);
>>> +		ret = list_empty(&F2FS_I(inode)->gdirty_list);
>>> +		spin_unlock(&sbi->inode_lock[DIRTY_META]);
>>> +		return ret;
>>> +	}
>>>  	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER))
>>>  		return false;
>>>  	return F2FS_I(inode)->last_disk_size == i_size_read(inode);
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index d48c120..50123c6 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -212,7 +212,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>>  	}
>>>  
>>>  	/* if the inode is dirty, let's recover all the time */
>>> -	if (!datasync && !f2fs_skip_inode_update(inode)) {
>>> +	if (!f2fs_skip_inode_update(inode, datasync)) {
>>>  		f2fs_write_inode(inode, NULL);
>>>  		goto go_write;
>>>  	}
>>>
> 
> .
> 


------------------------------------------------------------------------------

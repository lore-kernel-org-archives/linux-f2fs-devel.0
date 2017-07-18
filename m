From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: avoid cpu lockup
Date: Tue, 18 Jul 2017 09:40:34 +0800
Message-ID: <b2ea8d06-fed6-1371-33b0-62db7af41eb7@huawei.com>
References: <20170715012245.24640-1-jaegeuk@kernel.org>
	<20170716010422.GA51202@jaegeuk-macbookpro.roam.corp.google.com>
	<330acf45-f218-cb85-28b6-08e12c4fb888@kernel.org>
	<20170717223858.GD81128@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dXHVl-0005QM-Ei
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Jul 2017 01:41:17 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dXHVj-0006F1-Ry
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Jul 2017 01:41:17 +0000
In-Reply-To: <20170717223858.GD81128@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/7/18 6:38, Jaegeuk Kim wrote:
> On 07/17, Chao Yu wrote:
>> On 2017/7/16 9:04, Jaegeuk Kim wrote:
>>> Before retrying to flush data or dentry pages, we need to release cpu in order
>>> to prevent watchdog.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>>> ---
>>> Change log from v1:
>>>  - timeout more specifically
>>>
>>>  fs/f2fs/checkpoint.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 56bbf592e487..5b876f6d3f6b 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -879,6 +879,7 @@ int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
>>>  	struct inode *inode;
>>>  	struct f2fs_inode_info *fi;
>>>  	bool is_dir = (type == DIR_INODE);
>>> +	unsigned long ino = 0;
>>>  
>>>  	trace_f2fs_sync_dirty_inodes_enter(sbi->sb, is_dir,
>>>  				get_pages(sbi, is_dir ?
>>> @@ -901,8 +902,17 @@ int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
>>>  	inode = igrab(&fi->vfs_inode);
>>>  	spin_unlock(&sbi->inode_lock[type]);
>>>  	if (inode) {
>>> +		unsigned long cur_ino = inode->i_ino;
>>> +
>>>  		filemap_fdatawrite(inode->i_mapping);
>>>  		iput(inode);
>>> +		/* We need to give cpu to another writers. */
>>> +		if (ino == cur_ino) {
>>
>> We failed to flush dirty pages of inode due to encountering -EAGAIN of writepage?
> 
> Actually, I found this from a bug case in experimental patches which just skips
> it accidently. I think WB_SYNC_ALL doesn't return EAGAIN.

Alright, thanks for explanation. :)

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>> +			congestion_wait(BLK_RW_ASYNC, HZ/50);
>>> +			cond_resched();
>>> +		} else {
>>> +			ino = cur_ino;
>>> +		}
>>>  	} else {
>>>  		/*
>>>  		 * We should submit bio, since it exists several
>>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

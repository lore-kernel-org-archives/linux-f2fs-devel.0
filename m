From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: fix to commit bio cache after flushing node
 pages
Date: Tue, 27 Sep 2016 10:09:03 +0800
Message-ID: <f9892d98-1e9a-900e-365c-6da2b9f8972e@huawei.com>
References: <1474906193-6487-1-git-send-email-chao@kernel.org>
 <20160926183321.GB33149@jaegeuk>
 <4a95fcaa-413c-5018-70a3-19480a39c59a@huawei.com>
 <20160927013923.GA35593@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160927013923.GA35593@jaegeuk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/9/27 9:39, Jaegeuk Kim wrote:
> On Tue, Sep 27, 2016 at 08:57:41AM +0800, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2016/9/27 2:33, Jaegeuk Kim wrote:
>>> Hi Chao,
>>>
>>> On Tue, Sep 27, 2016 at 12:09:52AM +0800, Chao Yu wrote:
>>>> From: Chao Yu <yuchao0@huawei.com>
>>>>
>>>> In sync_node_pages, we won't check and commit last merged pages in private
>>>> bio cache of f2fs, as these pages were taged as writeback, someone who is
>>>> waiting for writebacking of the page will be blocked until the cache was
>>>> committed by someone else.
>>>>
>>>> We need to commit node type bio cache to avoid potential deadlock or long
>>>> delay of waiting writeback.
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/node.c | 11 +++++++++--
>>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>> index 9faddcd..f73f774 100644
>>>> --- a/fs/f2fs/node.c
>>>> +++ b/fs/f2fs/node.c
>>>> @@ -1416,6 +1416,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
>>>>  	struct pagevec pvec;
>>>>  	int step = 0;
>>>>  	int nwritten = 0;
>>>> +	int ret = 0;
>>>>  
>>>>  	pagevec_init(&pvec, 0);
>>>>  
>>>> @@ -1436,7 +1437,8 @@ next_step:
>>>>  
>>>>  			if (unlikely(f2fs_cp_error(sbi))) {
>>>>  				pagevec_release(&pvec);
>>>> -				return -EIO;
>>>> +				ret = -EIO;
>>>> +				goto out;
>>>>  			}
>>>>  
>>>>  			/*
>>>> @@ -1487,6 +1489,8 @@ continue_unlock:
>>>>  
>>>>  			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
>>>>  				unlock_page(page);
>>>> +			else
>>>> +				nwritten++;
>>>>  
>>>>  			if (--wbc->nr_to_write == 0)
>>>>  				break;
>>>> @@ -1504,7 +1508,10 @@ continue_unlock:
>>>>  		step++;
>>>>  		goto next_step;
>>>>  	}
>>>> -	return nwritten;
>>>> +out:
>>>> +	if (nwritten)
>>>> +		f2fs_submit_merged_bio(sbi, NODE, WRITE);
>>>
>>> IIRC, we don't need to flush this, since f2fs_submit_merged_bio_cond() would
>>> handle this in f2fs_wait_on_page_writeback().
>>
>> Yes, it covers all the cases in f2fs private codes, but there are still some
>> codes in mm or fs directory, and they didn't use f2fs_wait_on_page_writeback
>> when waiting page writeback. Such as do_writepages && filemap_fdatawait in
>> __writeback_single_inode...
> 
> The do_writepages() is okay, which will call f2fs_write_node_pages().
> The __writeback_single_inode() won't do filemap_fdatawait() with WB_SYNC_ALL.
> We don't need to take care of truncation as well.
> 
> Any missing one?

Another is: while testing with first version of checkpoint error injection, I
encounter below dump stack:

"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
mount           D ffff8801c1bf7960     0 97685  97397 0x00080000
 ffff8801c1bf7960 ffff8801c1bf7930 ffff880175900000 ffff8801c1bf7980
 ffff8801c1bf8000 0000000000000000 7fffffffffffffff ffff88021f7be340
 ffffffff817c8880 ffff8801c1bf7978 ffffffff817c80a5 ffff880214f58fc0
Call Trace:
 [<ffffffff817c8880>] ? bit_wait+0x50/0x50
 [<ffffffff817c80a5>] schedule+0x35/0x80
 [<ffffffff817cb152>] schedule_timeout+0x292/0x3d0
 [<ffffffff81022ab5>] ? xen_clocksource_get_cycles+0x15/0x20
 [<ffffffff810eeb5c>] ? ktime_get+0x3c/0xb0
 [<ffffffff817c8880>] ? bit_wait+0x50/0x50
 [<ffffffff817c7906>] io_schedule_timeout+0xa6/0x110
 [<ffffffff817c889b>] bit_wait_io+0x1b/0x60
 [<ffffffff817c84e4>] __wait_on_bit+0x64/0x90
 [<ffffffff8117dcd4>] wait_on_page_bit+0xc4/0xd0
 [<ffffffff810bc4d0>] ? autoremove_wake_function+0x40/0x40
 [<ffffffff81190a29>] truncate_inode_pages_range+0x409/0x840
 [<ffffffff811a406d>] ? pcpu_free_area+0x13d/0x1a0
 [<ffffffff810bc025>] ? wake_up_bit+0x25/0x30
 [<ffffffff81190ecc>] truncate_inode_pages_final+0x4c/0x60
 [<ffffffffa025e9e8>] f2fs_evict_inode+0x48/0x390 [f2fs]
 [<ffffffff812212f7>] evict+0xc7/0x1a0
 [<ffffffff81221f77>] iput+0x197/0x200
 [<ffffffffa0268242>] f2fs_fill_super+0xab2/0x1130 [f2fs]
 [<ffffffff81209454>] mount_bdev+0x184/0x1c0
 [<ffffffffa0267790>] ? f2fs_commit_super+0x100/0x100 [f2fs]
 [<ffffffffa02646a5>] f2fs_mount+0x15/0x20 [f2fs]
 [<ffffffff81209e19>] mount_fs+0x39/0x160
 [<ffffffff81225e47>] vfs_kern_mount+0x67/0x110
 [<ffffffff812283bb>] do_mount+0x1bb/0xc80
 [<ffffffff81229163>] SyS_mount+0x83/0xd0
 [<ffffffff8100391e>] do_syscall_64+0x6e/0x170
 [<ffffffff817cc325>] entry_SYSCALL64_slow_path+0x25/0x25

Any thoughts?

> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>> +	return ret;
>>>>  }
>>>>  
>>>>  int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
>>>> -- 
>>>> 2.7.2
>>>
>>> .
>>>
> 
> .
> 

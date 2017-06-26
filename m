From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid deadlock caused by lock order
 of page and lock_op
Date: Mon, 26 Jun 2017 23:42:21 +0800
Message-ID: <060e5c2d-50cd-9f76-9efc-0cdec0d3df3b@kernel.org>
References: <20170624162522.48931-1-jaegeuk@kernel.org>
 <f572292c-026a-7167-89b4-864b60d05865@huawei.com>
 <20170626145433.GA8560@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170626145433.GA8560@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/6/26 22:54, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 06/26, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2017/6/25 0:25, Jaegeuk Kim wrote:
>>> - punch_hole
>>>  - fill_zero
>>>   - f2fs_lock_op
>>>   - get_new_data_page
>>>    - lock_page
>>>
>>> - f2fs_write_data_pages
>>>  - lock_page
>>>  - do_write_data_page
>>>   - f2fs_lock_op
>>
>> Good catch!
>>
>> With this implementation, page writeback can fail due to concurrent checkpoint,
>> this will make fsync/atomic_commit which trigger synchronous write failed randomly.
>>
>> How about unifying the lock order in punch_hole as one in writepages for regular
>> inode? We can add one more parameter in get_new_data_page to indicate whether
>> callee needs to lock cp_rwsem.
> 
> Currently, there would be some places to keep cp_rwsem -> page.lock, which seems
> not simple to change the lock order with page.lock -> cp_rwsem. IMO, we can retry
> flushing data in f2fs_sync_file, once it gets -EAGAIN.
> 
> Any thoughts?

What about adding inode_lock in f2fs_sync_file to exclude other
foreground operation which have reversed lock order? Atomic_commit is OK
since it has inode_lock in its path.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/data.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 7d3af48d34a9..9141bd19a902 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1404,8 +1404,9 @@ int do_write_data_page(struct f2fs_io_info *fio)
>>>  		}
>>>  	}
>>>  
>>> -	if (fio->need_lock == LOCK_REQ)
>>> -		f2fs_lock_op(fio->sbi);
>>> +	/* Deadlock due to between page->lock and f2fs_lock_op */
>>> +	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi))
>>> +		return -EAGAIN;
>>>  
>>>  	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
>>>  	if (err)
>>>
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

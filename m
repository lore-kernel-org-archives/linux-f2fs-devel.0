From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: add fi->commit_lock to protect commit GCed pages
Date: Fri, 9 Feb 2018 20:44:05 +0800
Message-ID: <ae9a153e-4e9a-648d-3804-2a1e4a21a9c1@kernel.org>
References: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
 <1517888990-96478-1-git-send-email-yunlong.song@huawei.com>
 <4493cbf2-6f37-6c04-a012-4b2516b3b4e7@kernel.org>
 <134848f9-2dd6-0efa-3ccf-3c29eeaf5534@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <134848f9-2dd6-0efa-3ccf-3c29eeaf5534@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/2/8 11:11, Yunlong Song wrote:
> Then the GCed data pages are totally mixed with the inmem atomic pages,

If we add dio_rwsem, GC flow is exclude with atomic write flow. There
will be not race case to mix GCed page into atomic pages.

Or you mean:

					- gc_data_segment
					 - move_data_page
					  - f2fs_is_atomic_file
- f2fs_ioc_start_atomic_write
 - set_inode_flag(inode, FI_ATOMIC_FILE);
					  - f2fs_set_data_page_dirty
					   - register_inmem_page

In this case, GCed page can be mixed into database transaction, but could
it cause any problem except break rule of isolation for transaction.

> this will cause the atomic commit ops write the GCed data pages twice
> (the first write happens in GC).
> 
> How about using the early two patches to separate the inmem data pages
> and GCed data pages, and use dio_rwsem instead of this patch to fix the
> dnode page problem (dnode page commited but data page are not committed
> for the GCed page)?

Could we fix the race case first, based on that fixing, and then find the
place that we can improve?

> 
> 
> On 2018/2/7 20:16, Chao Yu wrote:
>> On 2018/2/6 11:49, Yunlong Song wrote:
>>> This patch adds fi->commit_lock to avoid the case that GCed node pages
>>> are committed but GCed data pages are not committed. This can avoid the
>>> db file run into inconsistent state when sudden-power-off happens if
>>> data pages of atomic file is allowed to be GCed before.
>>
>> do_fsync:                GC:
>> - mutex_lock(&fi->commit_lock);
>>                     - lock_page()
>>                      - mutex_lock(&fi->commit_lock);
>>   - lock_page()
>>
>>
>> Well, please consider lock dependency & code complexity, IMO, reuse
>> fi->dio_rwsem[WRITE] will be enough as below:
>>
>> ---
>>   fs/f2fs/file.c | 3 +++
>>   fs/f2fs/gc.c   | 5 -----
>>   2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 672a542e5464..1bdc11feb8d0 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1711,6 +1711,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>>
>>       inode_lock(inode);
>>
>> +    down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
>> +
>>       if (f2fs_is_volatile_file(inode))
>>           goto err_out;
>>
>> @@ -1729,6 +1731,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>>           ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
>>       }
>>   err_out:
>> +    up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
>>       inode_unlock(inode);
>>       mnt_drop_write_file(filp);
>>       return ret;
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index b9d93fd532a9..e49416283563 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -622,9 +622,6 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>       if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>           goto out;
>>
>> -    if (f2fs_is_atomic_file(inode))
>> -        goto out;

Seems that we need this check.

>> -
>>       if (f2fs_is_pinned_file(inode)) {
>>           f2fs_pin_file_control(inode, true);
>>           goto out;
>> @@ -729,8 +726,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>       if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>           goto out;
>>
>> -    if (f2fs_is_atomic_file(inode))
>> -        goto out;

Ditto.

Thanks,

>>       if (f2fs_is_pinned_file(inode)) {
>>           if (gc_type == FG_GC)
>>               f2fs_pin_file_control(inode, true);
>>
> 

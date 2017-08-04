From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: provide f2fs_balance_fs to __write_data_page for
 dentry pages
Date: Fri, 4 Aug 2017 10:44:32 +0800
Message-ID: <e9432597-f4cb-4a23-cfe2-999da92a99b9@huawei.com>
References: <1501334365-123333-1-git-send-email-yunlong.song@huawei.com>
 <20170730073154.GA13058@jaegeuk-macbookpro.roam.corp.google.com>
 <4916ac46.daf0.15d943f23b9.Coremail.sylinux@163.com>
 <e2336730-40f4-efb9-48eb-7707fe3cbf11@huawei.com>
 <20170801182254.GA52047@jaegeuk-macbookpro.roam.corp.google.com>
 <4568e3fb-272c-1d67-ac9f-2f0e194bcdd5@huawei.com>
 <20170804015742.GC81291@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804015742.GC81291@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Yunlong Song <sylinux@163.com>, chao <chao@kernel.org>, yuchao0 <yuchao0@huawei.com>, miaoxie <miaoxie@huawei.com>, "bintian.wang" <bintian.wang@huawei.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Since __write_data_page will not do f2fs_balance_fs for dir inode, so 
there is no lock.
- f2fs_balance_fs
     - __write_data_page (dir inode)
          - f2fs_balance_fs again?    <- Can not happen!
And if let sync_dirty_inodes flush dentry page of inodeB, then inodeB 
will sikp the
f2fs_balance_fs check due to the same reason above (it is dir inode).

Besides, does any lock will lock the kernel writeback process? If not, 
when normal
writeback of inodeB just happens before sync_dirty_inodes fetch it from 
the dirty_list,
the normal writeback of indoeB will skip the f2fs_balance_fs check.

f2fs_trim(,sync)_fs normal dentry page writeback of inodeB
   -- write_checkpoint --f2fs_write_data_pages
--block_operations --f2fs_write_cache_pages
         --SBI_BLOCK_OPS is set --__write_data_page
--sync_dirty_inodes --test SBI_BLOCK_OPS is set and skip f2fs_balance_fs
--retry: write to reserved segments
                    inodeA <- list_first_entry(dirty_list)
                    filemap_fdatawrite(inodeA)
                    go to retry
         --SBI_BLOCK_OPS is clear



On 2017/8/4 9:57, Jaegeuk Kim wrote:
> On 08/02, Yunlong Song wrote:
>> Hi Jay,
>>      The case is like this:
>>    write_checkpoint:                                           normal dentry
>> page writeback of inodeB：
>>      -block_operations -f2fs_write_data_pages
>>          -SBI_BLOCK_OPS is set -f2fs_write_cache_pages
>>          -sync_dirty_inodes       -__write_data_page
>>             -retry:                    -test SBI_BLOCK_OPS is set and skip
>> f2fs_balance_fs
>>                  inodeA <- list_first_entry(dirty_list)
>>                  filemap_fdatawrite(inodeA)
>>                  goto retry
>>          -SBI_BLOCK_OPS is clear
>>
>> write_checkpoint flow call sync_dirty_inodes to traversal the dirty inode
>> list and filemap_fdatawrite each inode,
>> during this period, if normal dentry_page writeback is processing inodeB,
>> and syc_dirty_inodes is processing
>> inodeA, then inodeB writeback flow will skip f2fs_balance_fs and may write
>> the dentry page to reserved segments.
> If there are not enough sections, all the possible system calls were already
> blocked by gc_mutex. So, it doesn't have to do f2fs_balance_fs(), and let
> sync_dirty_inodes() flush dentry pages of inodeB.
>
> Oh, does it make livelock?
>
> - f2fs_balance_fs
>   - f2fs_gc
>     - write_checkpoint
>       - sync_dirty_inodes
>         - filemap_fdatawrite(inodeB)
>           - __write_data_page
> 	   - f2fs_balance_fs again?
>
>> On 2017/8/2 2:22, Jaegeuk Kim wrote:
>>> On 08/01, Yunlong Song wrote:
>>>> Hi Jay,
>>>>       The SBI_BLOCK_OPS can not cover all the case, once SBI_BLOCK_OPS is set,
>>>> all the normal writeback
>>>> (before the SBI_BLOCK_OPS is clear) of dentry pages which do not come from
>>>> write_checkpoint flow will
>>>> totally miss all the f2fs_balance_fs check.
>>> Why not? There must be no dirty dentry pages after sync_dirty_inodes() in that
>>> period which we grabbed the globla lock.
>>>
>>> Thanks,
>>>
>>>> On 2017/7/31 0:05, Yunlong Song wrote:
>>>>> Hi Jay,
>>>>>       Chao has pointed out one reason, besides, I have another reason: we
>>>>> should take care of writeback for f2fs_balance_fs carefully, because if
>>>>> some bugs cause reserved segments unlikely used, which means
>>>>> f2fs_balance_fs does not work or is skipped in some corner case that we
>>>>> have not noticed or found out yet, then the reserved segments may be
>>>>> continually used and even used up in the writeback process of dentry
>>>>> page,  since current  design believe in the f2fs_balance_fs in system
>>>>> call and has no check in denty page writeback. To avoid this, we can put
>>>>> a f2fs_balance_fs in the dentry page writeback process to give f2fs more
>>>>> robust in free segments reserved. This is worth, because free segments
>>>>> reserved are so important, if they are used up, f2fs will enter a
>>>>> totally wrong status and make a wrong image.
>>>>>
>>>>> On 07/30/2017 15:31, Jaegeuk Kim <mailto:jaegeuk@kernel.org> wrote:
>>>>>
>>>>>       On 07/29, Yunlong Song wrote:
>>>>>       > f2fs_balance_fs of dentry pages is skipped in __write_data_page
>>>>>       due to deadlock
>>>>>       > of gc_mutex in write_checkpoint flow. This patch enables
>>>>>       f2fs_balance_fs for
>>>>>       > normal dentry page writeback to ensure there are always enough
>>>>>       free segments.
>>>>>
>>>>>       Sorry, by the way, why do we need to do this? I subtly thought
>>>>>       that dirty node
>>>>>       pages can be produce by redirtied inodes from what we've not
>>>>>       covered through
>>>>>       filesystem calls. But, in dentry pages, we're controlling the
>>>>>       number of dirty
>>>>>       pages, and calling f2fs_balance_fs in each directory operations.
>>>>>
>>>>>       Chao?
>>>>>
>>>>>       Thanks,
>>>>>
>>>>>       >
>>>>>       > Reported-by: Chao Yu <yuchao0@huawei.com>
>>>>>       > Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>>       > ---
>>>>>       >  fs/f2fs/checkpoint.c |  2 +-
>>>>>       >  fs/f2fs/data.c       | 67
>>>>>       +++++++++++++++++++++++++++++++++++++++++++++-------
>>>>>       >  fs/f2fs/f2fs.h       |  1 +
>>>>>       >  3 files changed, 61 insertions(+), 9 deletions(-)
>>>>>       >
>>>>>       > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>>>       > index 3c84a25..2882878 100644
>>>>>       > --- a/fs/f2fs/checkpoint.c
>>>>>       > +++ b/fs/f2fs/checkpoint.c
>>>>>       > @@ -904,7 +904,7 @@ int sync_dirty_inodes(struct f2fs_sb_info
>>>>>       *sbi, enum inode_type type)
>>>>>       >      if (inode) {
>>>>>       >          unsigned long cur_ino = inode->i_ino;
>>>>>       >
>>>>>       > -        filemap_fdatawrite(inode->i_mapping);
>>>>>       > +        f2fs_filemap_fdatawrite(inode->i_mapping, is_dir);
>>>>>       >          iput(inode);
>>>>>       >          /* We need to give cpu to another writers. */
>>>>>       >          if (ino == cur_ino) {
>>>>>       > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>       > index aefc2a5..ed7efa5 100644
>>>>>       > --- a/fs/f2fs/data.c
>>>>>       > +++ b/fs/f2fs/data.c
>>>>>       > @@ -1475,7 +1475,7 @@ int do_write_data_page(struct f2fs_io_info
>>>>>       *fio)
>>>>>       >  }
>>>>>       >
>>>>>       >  static int __write_data_page(struct page *page, bool *submitted,
>>>>>       > -                struct writeback_control *wbc)
>>>>>       > +                struct writeback_control *wbc, bool do_balance)
>>>>>       >  {
>>>>>       >      struct inode *inode = page->mapping->host;
>>>>>       >      struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>>       > @@ -1578,7 +1578,7 @@ static int __write_data_page(struct page
>>>>>       *page, bool *submitted,
>>>>>       >      }
>>>>>       >
>>>>>       >      unlock_page(page);
>>>>>       > -    if (!S_ISDIR(inode->i_mode))
>>>>>       > +    if (do_balance)
>>>>>       >          f2fs_balance_fs(sbi, need_balance_fs);
>>>>>       >
>>>>>       >      if (unlikely(f2fs_cp_error(sbi))) {
>>>>>       > @@ -1602,7 +1602,7 @@ static int __write_data_page(struct page
>>>>>       *page, bool *submitted,
>>>>>       >  static int f2fs_write_data_page(struct page *page,
>>>>>       >                      struct writeback_control *wbc)
>>>>>       >  {
>>>>>       > -    return __write_data_page(page, NULL, wbc);
>>>>>       > +    return __write_data_page(page, NULL, wbc, true);
>>>>>       >  }
>>>>>       >
>>>>>       >  /*
>>>>>       > @@ -1611,7 +1611,7 @@ static int f2fs_write_data_page(struct
>>>>>       page *page,
>>>>>       >   * warm/hot data page.
>>>>>       >   */
>>>>>       >  static int f2fs_write_cache_pages(struct address_space *mapping,
>>>>>       > -                    struct writeback_control *wbc)
>>>>>       > +                    struct writeback_control *wbc, bool
>>>>>       do_balance)
>>>>>       >  {
>>>>>       >      int ret = 0;
>>>>>       >      int done = 0;
>>>>>       > @@ -1701,7 +1701,7 @@ static int f2fs_write_cache_pages(struct
>>>>>       address_space *mapping,
>>>>>       >              if (!clear_page_dirty_for_io(page))
>>>>>       >                  goto continue_unlock;
>>>>>       >
>>>>>       > -            ret = __write_data_page(page, &submitted, wbc);
>>>>>       > +            ret = __write_data_page(page, &submitted, wbc,
>>>>>       do_balance);
>>>>>       >              if (unlikely(ret)) {
>>>>>       >                  /*
>>>>>       >                   * keep nr_to_write, since vfs uses this to
>>>>>       > @@ -1756,8 +1756,8 @@ static int f2fs_write_cache_pages(struct
>>>>>       address_space *mapping,
>>>>>       >      return ret;
>>>>>       >  }
>>>>>       >
>>>>>       > -static int f2fs_write_data_pages(struct address_space *mapping,
>>>>>       > -                struct writeback_control *wbc)
>>>>>       > +static int _f2fs_write_data_pages(struct address_space *mapping,
>>>>>       > +                struct writeback_control *wbc, bool do_balance)
>>>>>       >  {
>>>>>       >      struct inode *inode = mapping->host;
>>>>>       >      struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>>       > @@ -1794,7 +1794,7 @@ static int f2fs_write_data_pages(struct
>>>>>       address_space *mapping,
>>>>>       >          goto skip_write;
>>>>>       >
>>>>>       >      blk_start_plug(&plug);
>>>>>       > -    ret = f2fs_write_cache_pages(mapping, wbc);
>>>>>       > +    ret = f2fs_write_cache_pages(mapping, wbc, do_balance);
>>>>>       >      blk_finish_plug(&plug);
>>>>>       >
>>>>>       >      if (wbc->sync_mode == WB_SYNC_ALL)
>>>>>       > @@ -1813,6 +1813,57 @@ static int f2fs_write_data_pages(struct
>>>>>       address_space *mapping,
>>>>>       >      return 0;
>>>>>       >  }
>>>>>       >
>>>>>       > +static int f2fs_write_data_pages(struct address_space *mapping,
>>>>>       > +                struct writeback_control *wbc)
>>>>>       > +{
>>>>>       > +    return    _f2fs_write_data_pages(mapping, wbc, true);
>>>>>       > +}
>>>>>       > +
>>>>>       > +/*
>>>>>       > + * This function was copied from do_writepages from
>>>>>       mm/page-writeback.c.
>>>>>       > + * The major change is changing writepages to
>>>>>       _f2fs_write_data_pages.
>>>>>       > + */
>>>>>       > +static int f2fs_do_writepages(struct address_space *mapping,
>>>>>       > +                struct writeback_control *wbc, bool is_dir)
>>>>>       > +{
>>>>>       > +    int ret;
>>>>>       > +
>>>>>       > +    if (wbc->nr_to_write <= 0)
>>>>>       > +        return 0;
>>>>>       > +    while (1) {
>>>>>       > +        ret = _f2fs_write_data_pages(mapping, wbc, !is_dir);
>>>>>       > +        if ((ret != -ENOMEM) || (wbc->sync_mode != WB_SYNC_ALL))
>>>>>       > +            break;
>>>>>       > +        cond_resched();
>>>>>       > +        congestion_wait(BLK_RW_ASYNC, HZ/50);
>>>>>       > +    }
>>>>>       > +    return ret;
>>>>>       > +}
>>>>>       > +
>>>>>       > +/*
>>>>>       > + * This function was copied from __filemap_fdatawrite_range from
>>>>>       > + * mm/filemap.c. The major change is changing do_writepages to
>>>>>       > + * f2fs_do_writepages.
>>>>>       > + */
>>>>>       > +int f2fs_filemap_fdatawrite(struct address_space *mapping, bool
>>>>>       is_dir)
>>>>>       > +{
>>>>>       > +    int ret;
>>>>>       > +    struct writeback_control wbc = {
>>>>>       > +        .sync_mode = WB_SYNC_ALL,
>>>>>       > +        .nr_to_write = LONG_MAX,
>>>>>       > +        .range_start = 0,
>>>>>       > +        .range_end = LLONG_MAX,
>>>>>       > +    };
>>>>>       > +
>>>>>       > +    if (!mapping_cap_writeback_dirty(mapping))
>>>>>       > +        return 0;
>>>>>       > +
>>>>>       > +    wbc_attach_fdatawrite_inode(&wbc, mapping->host);
>>>>>       > +    ret = f2fs_do_writepages(mapping, &wbc, is_dir);
>>>>>       > +    wbc_detach_inode(&wbc);
>>>>>       > +    return ret;
>>>>>       > +}
>>>>>       > +
>>>>>       >  static void f2fs_write_failed(struct address_space *mapping,
>>>>>       loff_t to)
>>>>>       >  {
>>>>>       >      struct inode *inode = mapping->host;
>>>>>       > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>       > index 9280283..ea9bebb 100644
>>>>>       > --- a/fs/f2fs/f2fs.h
>>>>>       > +++ b/fs/f2fs/f2fs.h
>>>>>       > @@ -2572,6 +2572,7 @@ void f2fs_invalidate_page(struct page
>>>>>       *page, unsigned int offset,
>>>>>       >  int f2fs_migrate_page(struct address_space *mapping, struct
>>>>>       page *newpage,
>>>>>       >              struct page *page, enum migrate_mode mode);
>>>>>       >  #endif
>>>>>       > +int f2fs_filemap_fdatawrite(struct address_space *mapping, bool
>>>>>       is_dir);
>>>>>       >
>>>>>       >  /*
>>>>>       >   * gc.c
>>>>>       > --
>>>>>       > 1.8.5.2
>>>>>
>>>> -- 
>>>> Thanks,
>>>> Yunlong Song
>>>>
>>> .
>>>
>> -- 
>> Thanks,
>> Yunlong Song
>>
> .
>

-- 
Thanks,
Yunlong Song

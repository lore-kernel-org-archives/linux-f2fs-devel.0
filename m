From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: fix out-of-free problem caused by atomic write
Date: Fri, 3 Nov 2017 23:23:04 +0800
Message-ID: <8bc47f71-2827-c80e-9099-d7a601e896be@kernel.org>
References: <1509027715-80477-1-git-send-email-yunlong.song@huawei.com>
 <1509368658-60355-1-git-send-email-yunlong.song@huawei.com>
 <20171103034618.GD11335@jaegeuk-macbookpro.roam.corp.google.com>
 <efa5f9e7-c1b8-ef1c-bd9b-02bcd9c1f809@huawei.com>
 <3ab54002-4164-1582-cb76-eb337e126ebf@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ab54002-4164-1582-cb76-eb337e126ebf@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/11/3 22:40, Yunlong Song wrote:
> Test:
> Newest kernel source code from f2fs-dev
> 1G zram with f2fs
> 8 threads to atomic write one same file on zram
> there are four kinds of atomic write at the same time:
> 1 no atomic start, with atomic commit
> 2 no atomic start, no atomic commit
> 3 atomic start, with atomic commit
> 4 atomic start, no atomic commit
> 
> And I add dump_stack after the check as following,
> +       if ((sbi->user_block_count - valid_user_blocks(sbi)) <
> +               fi->inmem_blocks) {

valid_user_blocks contains fi->inmem_blocks and all reserved new node blocks?

Thanks,

> +               dump_stack();
> +               err = -ENOSPC;
> +               goto drop;
> +       }
> 
> then we have:
> 
> [  136.237247] F2FS-fs (zram1): Unexpected flush for atomic writes: ino=4, npages=8193
> [  136.952469] CPU: 1 PID: 1274 Comm: atomic_t2 Not tainted 4.14.0-rc4+ #109
> [  136.952947] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
> [  136.953162] Call Trace:
> [  136.953162]  dump_stack+0x4d/0x6e
> [  136.953162]  commit_inmem_pages+0x258/0x270
> [  136.953162]  ? __sb_start_write+0x48/0x80
> [  136.953162]  ? __mnt_want_write_file+0x18/0x30
> [  136.953162]  f2fs_ioctl+0x1025/0x1e30
> [  136.953162]  ? up_write+0x25/0x30
> [  136.953162]  ? f2fs_file_write_iter+0xf3/0x1e0
> [  136.953162]  ? selinux_file_ioctl+0x114/0x1e0
> [  136.953162]  do_vfs_ioctl+0x96/0x5a0
> [  136.953162]  SyS_ioctl+0x79/0x90
> [  136.953162]  ? SyS_lseek+0x87/0xb0
> [  136.953162]  entry_SYSCALL_64_fastpath+0x13/0x94
> [  136.953162] RIP: 0033:0x434b97
> [  136.953162] RSP: 002b:00007ffc68859de8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> [  136.953162] RAX: ffffffffffffffda RBX: 00000000006b78e0 RCX: 0000000000434b97
> [  136.953162] RDX: 00000000006b70e8 RSI: 000000000000f502 RDI: 0000000000000003
> [  136.953162] RBP: 0000000002000010 R08: 00000000006b70e8 R09: 00000000006b7160
> [  136.953162] R10: 0000000000000022 R11: 0000000000000202 R12: 00007f491a1c4010
> [  136.953162] R13: 0000000002001000 R14: 0000000002000000 R15: 00000000006b7938
> 
> So I think we should add the check code.
> 
> On 2017/11/3 12:48, Yunlong Song wrote:
>> Because I found that it will still lead to out-of-free problem with out that check.
>> I trace and find that it is possible that the committing date pages of the atomic
>> file is bigger than the sbi->user_block_count - valid_user_blocks(sbi), so I add
>> this check.
>>
>> On 2017/11/3 11:46, Jaegeuk Kim wrote:
>>> On 10/30, Yunlong Song wrote:
>>>> f2fs_balance_fs only actives once in the commit_inmem_pages, but there
>>>> are more than one page to commit, so all the other pages will miss the
>>>> check. This will lead to out-of-free problem when commit a very large
>>>> file. However, we cannot do f2fs_balance_fs for each inmem page, since
>>>> this will break atomicity. As a result, we should collect prefree
>>>> segments if needed and stop atomic commit when there are not enough
>>>> available blocks to write atomic pages.
>>>>
>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>> ---
>>>>   fs/f2fs/f2fs.h    |  1 +
>>>>   fs/f2fs/segment.c | 29 ++++++++++++++++++++++++++++-
>>>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 13a96b8..04ce48f 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -610,6 +610,7 @@ struct f2fs_inode_info {
>>>>       struct list_head inmem_pages;    /* inmemory pages managed by f2fs */
>>>>       struct task_struct *inmem_task;    /* store inmemory task */
>>>>       struct mutex inmem_lock;    /* lock for inmemory pages */
>>>> +    unsigned long inmem_blocks;    /* inmemory blocks */
>>>>       struct extent_tree *extent_tree;    /* cached extent_tree entry */
>>>>       struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
>>>>       struct rw_semaphore i_mmap_sem;
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 46dfbca..813c110 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -210,6 +210,7 @@ void register_inmem_page(struct inode *inode, struct page *page)
>>>>           list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
>>>>       spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>>>>       inc_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
>>>> +    fi->inmem_blocks++;
>>>>       mutex_unlock(&fi->inmem_lock);
>>>>         trace_f2fs_register_inmem_page(page, INMEM);
>>>> @@ -221,6 +222,7 @@ static int __revoke_inmem_pages(struct inode *inode,
>>>>       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>       struct inmem_pages *cur, *tmp;
>>>>       int err = 0;
>>>> +    struct f2fs_inode_info *fi = F2FS_I(inode);
>>>>         list_for_each_entry_safe(cur, tmp, head, list) {
>>>>           struct page *page = cur->page;
>>>> @@ -263,6 +265,7 @@ static int __revoke_inmem_pages(struct inode *inode,
>>>>           list_del(&cur->list);
>>>>           kmem_cache_free(inmem_entry_slab, cur);
>>>>           dec_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
>>>> +        fi->inmem_blocks--;
>>>>       }
>>>>       return err;
>>>>   }
>>>> @@ -302,6 +305,10 @@ void drop_inmem_pages(struct inode *inode)
>>>>       if (!list_empty(&fi->inmem_ilist))
>>>>           list_del_init(&fi->inmem_ilist);
>>>>       spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>>>> +    if (fi->inmem_blocks) {
>>>> +        f2fs_bug_on(sbi, 1);
>>>> +        fi->inmem_blocks = 0;
>>>> +    }
>>>>       mutex_unlock(&fi->inmem_lock);
>>>>         clear_inode_flag(inode, FI_ATOMIC_FILE);
>>>> @@ -326,6 +333,7 @@ void drop_inmem_page(struct inode *inode, struct page *page)
>>>>         f2fs_bug_on(sbi, !cur || cur->page != page);
>>>>       list_del(&cur->list);
>>>> +    fi->inmem_blocks--;
>>>>       mutex_unlock(&fi->inmem_lock);
>>>>         dec_page_count(sbi, F2FS_INMEM_PAGES);
>>>> @@ -410,11 +418,26 @@ int commit_inmem_pages(struct inode *inode)
>>>>         INIT_LIST_HEAD(&revoke_list);
>>>>       f2fs_balance_fs(sbi, true);
>>>> +    if (prefree_segments(sbi)
>>>> +        && has_not_enough_free_secs(sbi, 0,
>>>> +        fi->inmem_blocks / BLKS_PER_SEC(sbi))) {
>>>> +        struct cp_control cpc;
>>>> +
>>>> +        cpc.reason = __get_cp_reason(sbi);
>>>> +        err = write_checkpoint(sbi, &cpc);
>>>> +        if (err)
>>>> +            goto drop;
>>>> +    }
>>>>       f2fs_lock_op(sbi);
>>>>         set_inode_flag(inode, FI_ATOMIC_COMMIT);
>>>>         mutex_lock(&fi->inmem_lock);
>>>> +    if ((sbi->user_block_count - valid_user_blocks(sbi)) <
>>> What does this mean? We already allocated blocks successfully?
>>>
>>>> +        fi->inmem_blocks) {
>>>> +        err = -ENOSPC;
>>>> +        goto drop;
>>>> +    }
>>>>       err = __commit_inmem_pages(inode, &revoke_list);
>>>>       if (err) {
>>>>           int ret;
>>>> @@ -429,7 +452,7 @@ int commit_inmem_pages(struct inode *inode)
>>>>           ret = __revoke_inmem_pages(inode, &revoke_list, false, true);
>>>>           if (ret)
>>>>               err = ret;
>>>> -
>>>> +drop:
>>>>           /* drop all uncommitted pages */
>>>>           __revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
>>>>       }
>>>> @@ -437,6 +460,10 @@ int commit_inmem_pages(struct inode *inode)
>>>>       if (!list_empty(&fi->inmem_ilist))
>>>>           list_del_init(&fi->inmem_ilist);
>>>>       spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>>>> +    if (fi->inmem_blocks) {
>>>> +        f2fs_bug_on(sbi, 1);
>>>> +        fi->inmem_blocks = 0;
>>>> +    }
>>>>       mutex_unlock(&fi->inmem_lock);
>>>>         clear_inode_flag(inode, FI_ATOMIC_COMMIT);
>>>> -- 
>>>> 1.8.5.2
>>> .
>>>
>>
> 

From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: fix sbi->extent_list corruption issue
Date: Mon, 26 Nov 2018 15:17:22 +0800
Message-ID: <d968cd81-ea64-3ae5-d5f4-13823aa8105a@huawei.com>
References: <1543207640-31033-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543207640-31033-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/11/26 12:47, Sahitya Tummala wrote:
> When there is a failure in f2fs_fill_super() after/during
> the recovery of fsync'd nodes, it frees the current sbi and
> retries again. This time the mount is successful, but the files
> that got recovered before retry, still holds the extent tree,
> whose extent nodes list is corrupted since sbi and sbi->extent_list
> is freed up. The list_del corruption issue is observed when the
> file system is getting unmounted and when those recoverd files extent
> node is being freed up in the below context.
> 
> list_del corruption. prev->next should be fffffff1e1ef5480, but was (null)
> <...>
> kernel BUG at kernel/msm-4.14/lib/list_debug.c:53!
> task: fffffff1f46f2280 task.stack: ffffff8008068000
> lr : __list_del_entry_valid+0x94/0xb4
> pc : __list_del_entry_valid+0x94/0xb4
> <...>
> Call trace:
> __list_del_entry_valid+0x94/0xb4
> __release_extent_node+0xb0/0x114
> __free_extent_tree+0x58/0x7c
> f2fs_shrink_extent_tree+0xdc/0x3b0
> f2fs_leave_shrinker+0x28/0x7c
> f2fs_put_super+0xfc/0x1e0
> generic_shutdown_super+0x70/0xf4
> kill_block_super+0x2c/0x5c
> kill_f2fs_super+0x44/0x50
> deactivate_locked_super+0x60/0x8c
> deactivate_super+0x68/0x74
> cleanup_mnt+0x40/0x78
> __cleanup_mnt+0x1c/0x28
> task_work_run+0x48/0xd0
> do_notify_resume+0x678/0xe98
> work_pending+0x8/0x14
> 
> Fix this by cleaning up inodes, extent tree and nodes of those
> recovered files before freeing up sbi and before next retry.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Looks good to me now. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

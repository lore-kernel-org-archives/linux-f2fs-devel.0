From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: don't give partially written atomic
 data from process crash
Date: Wed, 26 Jul 2017 22:07:59 +0800
Message-ID: <e7b3548b-3d2e-3ffb-fc13-9eae3397101d@kernel.org>
References: <20170726012921.53002-1-jaegeuk@kernel.org>
 <20170726012921.53002-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726012921.53002-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/7/26 9:29, Jaegeuk Kim wrote:
> This patch resolves the below scenario.
> 
> == Process 1 ==     == Process 2 ==
> open(w)             open(rw)
> begin
> write(new_#1)
> process_crash
>   f_op->flush
>   locks_remove_posix
>   f_op>release
>                     read (new_#1)
> 
> In order to avoid corrupted database caused by new_#1, we must do roll-back
> at process_crash time. In order to check that, this patch keeps task which
> triggers transaction begin, and does roll-back in f_op->flush before removing
> file locks.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/f2fs.h |  1 +
>  fs/f2fs/file.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index a336021b777f..3e48c2ac2f21 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -565,6 +565,7 @@ struct f2fs_inode_info {
>  	struct list_head dirty_list;	/* dirty list for dirs and files */
>  	struct list_head gdirty_list;	/* linked in global dirty list */
>  	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
> +	struct task_struct *inmem_task;	/* store inmemory task */
>  	struct mutex inmem_lock;	/* lock for inmemory pages */
>  	struct extent_tree *extent_tree;	/* cached extent_tree entry */
>  	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 0f4dbeb61845..cb0a013859e6 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1502,6 +1502,22 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static int f2fs_file_flush(struct file *file, fl_owner_t id)
> +{
> +	struct inode *inode = file_inode(file);
> +
> +	/*
> +	 * If the process doing a transaction is crashed, we should do
> +	 * roll-back. Otherwise, other reader/write can see corrupted database
> +	 * until all the writers close its file. Since this should be done
> +	 * before dropping file lock, it needs to do in ->flush.
> +	 */
> +	if (f2fs_is_atomic_file(inode) &&
> +			F2FS_I(inode)->inmem_task == current)
> +		drop_inmem_pages(inode);
> +	return 0;
> +}
> +
>  static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> @@ -1608,6 +1624,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  	}
>  
>  inc_stat:
> +	F2FS_I(inode)->inmem_task = current;
>  	stat_inc_atomic_write(inode);
>  	stat_update_max_atomic_write(inode);
>  out:
> @@ -2514,6 +2531,7 @@ const struct file_operations f2fs_file_operations = {
>  	.open		= f2fs_file_open,
>  	.release	= f2fs_release_file,
>  	.mmap		= f2fs_file_mmap,
> +	.flush		= f2fs_file_flush,
>  	.fsync		= f2fs_sync_file,
>  	.fallocate	= f2fs_fallocate,
>  	.unlocked_ioctl	= f2fs_ioctl,
> 

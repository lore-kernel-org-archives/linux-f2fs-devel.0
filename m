From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: don't skip recovering inode depend on i_times
Date: Thu, 3 Nov 2016 11:02:33 -0700
Message-ID: <20161103180233.GC76264@jaegeuk>
References: <20161103162656.2982-1-chao@kernel.org>
 <20161103162656.2982-2-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161103162656.2982-2-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, yuchao0@huawei.com, liushuoran@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Nov 04, 2016 at 12:26:56AM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> i_times of inode will be set with current system time which can be
> configured through 'date', so it's not safe to judge dnode block as
> garbage data depend on i_times.

This is not to detect garbage data, but to skip redundant unchanged inode.
Anyway, in the code part, looks good to me.

Thanks,

> 
> Now, we have used enhanced 'cp_ver + cp' crc method to verify valid
> dnode block, so I expect recoverying invalid dnode is almost not
> possible.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/recovery.c | 31 +------------------------------
>  1 file changed, 1 insertion(+), 30 deletions(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index d2ba4da..62523b2 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -196,32 +196,6 @@ static void recover_inode(struct inode *inode, struct page *page)
>  			ino_of_node(page), name);
>  }
>  
> -static bool is_same_inode(struct inode *inode, struct page *ipage)
> -{
> -	struct f2fs_inode *ri = F2FS_INODE(ipage);
> -	struct timespec disk;
> -
> -	if (!IS_INODE(ipage))
> -		return true;
> -
> -	disk.tv_sec = le64_to_cpu(ri->i_ctime);
> -	disk.tv_nsec = le32_to_cpu(ri->i_ctime_nsec);
> -	if (timespec_compare(&inode->i_ctime, &disk) > 0)
> -		return false;
> -
> -	disk.tv_sec = le64_to_cpu(ri->i_atime);
> -	disk.tv_nsec = le32_to_cpu(ri->i_atime_nsec);
> -	if (timespec_compare(&inode->i_atime, &disk) > 0)
> -		return false;
> -
> -	disk.tv_sec = le64_to_cpu(ri->i_mtime);
> -	disk.tv_nsec = le32_to_cpu(ri->i_mtime_nsec);
> -	if (timespec_compare(&inode->i_mtime, &disk) > 0)
> -		return false;
> -
> -	return true;
> -}
> -
>  static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
>  {
>  	struct curseg_info *curseg;
> @@ -248,10 +222,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
>  			goto next;
>  
>  		entry = get_fsync_inode(head, ino_of_node(page));
> -		if (entry) {
> -			if (!is_same_inode(entry->inode, page))
> -				goto next;
> -		} else {
> +		if (!entry) {
>  			if (IS_INODE(page) && is_dent_dnode(page)) {
>  				err = recover_inode_page(sbi, page);
>  				if (err)
> -- 
> 2.10.1

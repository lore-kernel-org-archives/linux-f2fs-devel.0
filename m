From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 7/7] f2fs: should check the remaining dentry
 bits
Date: Wed, 27 Apr 2016 10:40:27 -0700
Message-ID: <20160427174027.GA32350@jaegeuk.gateway>
References: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
 <1461629220-16280-7-git-send-email-jaegeuk@kernel.org>
 <5720CB1C.10207@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5720CB1C.10207@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Looks better.
Merged. :)

Thanks,

On Wed, Apr 27, 2016 at 10:22:20PM +0800, Chao Yu wrote:
> Hi Jaegeuk, Yunlei,
> 
> On 2016/4/26 8:07, Jaegeuk Kim wrote:
> > Let's consider a race condition between f2fs_add_regular_entry and
> > find_target_dentry.
> > 
> > 1.
> > - f2fs_add_regular_entry updated len: 24 first.
> >        |
> > Bits:  0 0 0 1
> > Lens: 24 0 0 3 (name: foo)
> >        |->
> > - find_target_dentry checks the first bit to find "foo", then ++pointer.
> > 
> > 2.
> > - f2fs_add_regular_entry updates bits.
> >        |>|>|
> > Bits:  1 1 1 1
> > Lens: 24 0 0 3 (name: foo)
> >          |
> > - find_target_dentry is checking second bit, but it's len is zero, which
> > makes the process being terminated.
> 
> As Pengyang reminded, there are no racing condition between find_target_dentry
> and f2fs_add_regular_entry since i_mutex lock make each of operations being
> atomical. So seems above condition can not happen.
> 
> But still we should handle dirent with zero-sized length correctly, as it may
> cause deadloop. So how do you think of following patch?
> 
> From: Chao Yu <yuchao0@huawei.com>
> Subject: [PATCH] f2fs: be aware of invalid filename length
> 
> The filename length in dirent of may become zero-sized after random junk
> data injection, once encounter such dirent, find_target_dentry or
> f2fs_add_inline_entries will run into an infinite loop. So let f2fs being
> aware of that to avoid deadloop.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/dir.c    | 14 +++++---------
>  fs/f2fs/inline.c | 14 ++++++--------
>  2 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index e90380d..3b1c14e 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -101,11 +101,6 @@ static struct f2fs_dir_entry *find_in_block(struct page
> *dentry_page,
>  	else
>  		kunmap(dentry_page);
> 
> -	/*
> -	 * For the most part, it should be a bug when name_len is zero.
> -	 * We stop here for figuring out where the bugs has occurred.
> -	 */
> -	f2fs_bug_on(F2FS_P_SB(dentry_page), d.max < 0);
>  	return de;
>  }
> 
> @@ -130,6 +125,11 @@ struct f2fs_dir_entry *find_target_dentry(struct
> fscrypt_name *fname,
> 
>  		de = &d->dentry[bit_pos];
> 
> +		if (unlikely(!de->name_len)) {
> +			bit_pos++;
> +			continue;
> +		}
> +
>  		/* encrypted case */
>  		de_name.name = d->filename[bit_pos];
>  		de_name.len = le16_to_cpu(de->name_len);
> @@ -147,10 +147,6 @@ struct f2fs_dir_entry *find_target_dentry(struct
> fscrypt_name *fname,
>  			*max_slots = max_len;
>  		max_len = 0;
> 
> -		/* remain bug on condition */
> -		if (unlikely(!de->name_len))
> -			d->max = -1;
> -
>  		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
>  	}
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 7720565..e61084c 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -303,11 +303,6 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
>  	else
>  		f2fs_put_page(ipage, 0);
> 
> -	/*
> -	 * For the most part, it should be a bug when name_len is zero.
> -	 * We stop here for figuring out where the bugs has occurred.
> -	 */
> -	f2fs_bug_on(sbi, d.max < 0);
>  	return de;
>  }
> 
> @@ -437,6 +432,12 @@ static int f2fs_add_inline_entries(struct inode *dir,
>  		}
> 
>  		de = &d.dentry[bit_pos];
> +
> +		if (unlikely(!de->name_len)) {
> +			bit_pos++;
> +			continue;
> +		}
> +
>  		new_name.name = d.filename[bit_pos];
>  		new_name.len = de->name_len;
> 
> @@ -448,9 +449,6 @@ static int f2fs_add_inline_entries(struct inode *dir,
>  		if (err)
>  			goto punch_dentry_pages;
> 
> -		if (unlikely(!de->name_len))
> -			d.max = -1;
> -
>  		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
>  	}
>  	return 0;
> -- 
> 2.7.2

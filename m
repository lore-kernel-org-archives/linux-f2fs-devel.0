From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] f2fs: check bdi->dirty_exceeded when trying to skip
 data writes
Date: Tue, 1 Jul 2014 22:54:20 -0700
Message-ID: <20140701225420.6cc94fb5.akpm@linux-foundation.org>
References: <1403956718-17575-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403956718-17575-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, 28 Jun 2014 20:58:38 +0900 Jaegeuk Kim <jaegeuk@kernel.org> wrote:

> If we don't check the current backing device status, balance_dirty_pages can
> fall into infinite pausing routine.
> 
> This can be occurred when a lot of directories make a small number of dirty
> dentry pages including files.
> 
> ...
>
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -43,6 +43,8 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
>  		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >> 12;
>  		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 2);
>  	} else if (type == DIRTY_DENTS) {
> +		if (sbi->sb->s_bdi->dirty_exceeded)
> +			return false;
>  		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
>  		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 1);
>  	}

err, filesystems should not be playing around with this.

Perhaps VFS changes are needed.  Please tell us much much more about
what is going on here.

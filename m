From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] f2fs: relax permission for atomic/volatile ioctls
Date: Thu, 6 Jul 2017 19:08:11 -0700
Message-ID: <20170707020811.GA561@zzz.localdomain>
References: <20170706022326.52594-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706022326.52594-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Jul 05, 2017 at 07:23:26PM -0700, Jaegeuk Kim wrote:
> This patch allows atomic/volatile ioctls for sqlite under sdcardfs.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f5d6357e8360..dd8f5d2caa48 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1587,9 +1587,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  	struct inode *inode = file_inode(filp);
>  	int ret;
>  
> -	if (!inode_owner_or_capable(inode))
> -		return -EACCES;
> -

Why not require that the file be open for writing (FMODE_WRITE)?

From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: move put_gc_inode into gc_mutex
Date: Thu, 27 Nov 2014 19:55:14 -0800
Message-ID: <20141128035514.GA59415@jaegeuk-mac02.mot-mobility.com>
References: <1417081374-31626-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417081374-31626-1-git-send-email-cm224.lee@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Changman,

On Thu, Nov 27, 2014 at 06:42:54PM +0900, Changman Lee wrote:
> There in no any lock to protect gc_inode list so let's move into
> gc_mutex, otherwise it might be lost links of list.

Could you explain why the links can be lost?
Cause the ilist is a local variable.

IIRC, the reason why put_gc_inode is called outside of gc_mutex is to avoid
deadlock between f2fs_evict_inode and gc operations.
I'm not sure it still has a problem, but it is unclear that we have to move
put_gc_inode inside gc_mutex.

Are you facing with any bug on this?

Thanks,

> 
> Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> ---
>  fs/f2fs/gc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 657683c9..99e1720 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -733,9 +733,9 @@ gc_more:
>  	if (gc_type == FG_GC)
>  		write_checkpoint(sbi, &cpc);
>  stop:
> -	mutex_unlock(&sbi->gc_mutex);
> -
>  	put_gc_inode(&ilist);
> +
> +	mutex_unlock(&sbi->gc_mutex);
>  	return ret;
>  }
>  
> -- 
> 1.9.1
> 
> 
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

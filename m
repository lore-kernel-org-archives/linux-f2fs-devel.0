From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs:remove unnecessary condition judgment
Date: Mon, 09 Mar 2015 10:21:44 +0900
Message-ID: <20150309012144.GB4450@lcm-devel.org>
References: <300031252.458581425722724194.JavaMail.weblogic@epmlwas08b>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <300031252.458581425722724194.JavaMail.weblogic@epmlwas08b>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuan Zhong <yuan.mark.zhong@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yuan,

On Sat, Mar 07, 2015 at 10:05:25AM +0000, Yuan Zhong wrote:
> Remove the unnecessary condition judgment, because 
> 'max_slots' has been initialized to '0' at the beginging 
> of the function, as following:
> if (max_slots)
>        max_len = 0;

There is wrong statement. It should be fixed as *max_slot = 0.

Thanks,

> 	
> Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>	
> ---
>  fs/f2fs/dir.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 590aeef..1f1a1bc 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -139,7 +139,7 @@ struct f2fs_dir_entry *find_target_dentry(struct qstr *name, int *max_slots,
>  			!memcmp(d->filename[bit_pos], name->name, name->len))
>  			goto found;
>  
> -		if (max_slots && *max_slots >= 0 && max_len > *max_slots) {
> +		if (max_slots && max_len > *max_slots) {
>  			*max_slots = max_len;
>  			max_len = 0;
>  		}
> -- 
> 1.7.9.5
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming The Go Parallel Website, sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub for all
> things parallel software development, from weekly thought leadership blogs to
> news, videos, case studies, tutorials and more. Take a look and join the 
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

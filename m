From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: clean up the do_submit_bio flow
Date: Tue, 19 Nov 2013 13:25:57 +0800
Message-ID: <001401cee4e8$09cf01b0$1d6d0510$@samsung.com>
References: <1384765922-24028-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1384765922-24028-1-git-send-email-jaegeuk.kim@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Monday, November 18, 2013 5:12 PM
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: clean up the do_submit_bio flow
> 
> This patch introduces PAGE_TYPE_OF_BIO() and cleans up do_submit_bio() with it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/segment.c | 39 +++++++++++++++++++++------------------
>  2 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index fe5c2fc..1c783fd 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -351,6 +351,7 @@ enum count_type {
>   *			with waiting the bio's completion
>   * ...			Only can be used with META.
>   */
> +#define PAGE_TYPE_OF_BIO(type)	(type) > META ? META : (type)
>  enum page_type {
>  	DATA,
>  	NODE,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1f83999..dad5f1a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -837,32 +837,35 @@ static void do_submit_bio(struct f2fs_sb_info *sbi,
>  				enum page_type type, bool sync)
>  {
>  	int rw = sync ? WRITE_SYNC : WRITE;
> -	enum page_type btype = type > META ? META : type;
> +	enum page_type btype = PAGE_TYPE_OF_BIO(type);

->f2fs_submit_bio()
	: enum page_type btype = PAGE_TYPE_OF_BIO(type);
	->do_submit_bio()
		: enum page_type btype = PAGE_TYPE_OF_BIO(type);

Could we remove PAGE_TYPE_OF_BIO or use f2fs_bug_on to instead
in do_submit_bio()? because it looks redundant , and also 
submit_write_page() will not pass the type which is larger than META.

> +	struct bio *bio = sbi->bio[btype];
> +	struct bio_private *p;
> +
> +	if (!bio)
> +		return;
> +
> +	sbi->bio[btype] = NULL;
> 
>  	if (type >= META_FLUSH)
>  		rw = WRITE_FLUSH_FUA;
> -
>  	if (btype == META)
>  		rw |= REQ_META;
> 
> -	if (sbi->bio[btype]) {
> -		struct bio_private *p = sbi->bio[btype]->bi_private;
> -		p->sbi = sbi;
> -		sbi->bio[btype]->bi_end_io = f2fs_end_io_write;
> +	p = bio->bi_private;
> +	p->sbi = sbi;
> +	bio->bi_end_io = f2fs_end_io_write;
> 
> -		trace_f2fs_do_submit_bio(sbi->sb, btype, sync, sbi->bio[btype]);
> +	trace_f2fs_do_submit_bio(sbi->sb, btype, sync, bio);
> 
> -		if (type == META_FLUSH) {
> -			DECLARE_COMPLETION_ONSTACK(wait);
> -			p->is_sync = true;
> -			p->wait = &wait;
> -			submit_bio(rw, sbi->bio[btype]);
> -			wait_for_completion(&wait);
> -		} else {
> -			p->is_sync = false;
> -			submit_bio(rw, sbi->bio[btype]);
> -		}
> -		sbi->bio[btype] = NULL;
> +	if (type == META_FLUSH) {
> +		DECLARE_COMPLETION_ONSTACK(wait);
> +		p->is_sync = true;
> +		p->wait = &wait;
> +		submit_bio(rw, bio);
> +		wait_for_completion(&wait);
> +	} else {
> +		p->is_sync = false;
> +		submit_bio(rw, bio);
>  	}
>  }
> 
> --
> 1.8.4.474.g128a96c
> 
> 
> ------------------------------------------------------------------------------
> DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
> OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
> Free app hosting. Or install the open source package on any LAMP server.
> Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
> http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

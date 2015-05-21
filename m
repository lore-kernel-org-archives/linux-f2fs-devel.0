From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH RFC] f2fs: recovering broken superblock
	during mount
Date: Thu, 21 May 2015 15:44:14 -0700
Message-ID: <20150521224414.GA71279@jaegeuk-mac02>
References: <555C3130.9010205@huawei.com>
	<20150521010635.GA63442@jaegeuk-mac02.mot.com>
	<555D7E6D.2050103@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YvZCW-0008Ap-DE
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 May 2015 22:44:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YvZCV-0000ve-33 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 May 2015 22:44:28 +0000
Content-Disposition: inline
In-Reply-To: <555D7E6D.2050103@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: hujianyang <hujianyang@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Hu,

Looks good to me, except one minor thing where 

+	int recovery = 0, i;
 -> AFAIK, kernel coding style recommends to split them.
 Let me change that to

 	int recovery = 0;
	int i;


Merged.

Thanks,

On Thu, May 21, 2015 at 02:42:53PM +0800, hujianyang wrote:
> On 2015/5/21 9:07, Jaegeuk Kim wrote:
> > Hi Hu,
> > 
> > On Wed, May 20, 2015 at 03:01:04PM +0800, hujianyang wrote:
> >> Hi Jaegeuk,
> >>
> >> There are two superblocks in f2fs. I wrapped one of them by 'dd' in
> >> a reliability test. After this, the polluted f2fs partition can be
> >> mounted with an error message:
> >>
> >> F2FS-fs (sdd3): Magic Mismatch, valid(0xf2f52010) - read(0x0)
> >> F2FS-fs (sdd3): Can't find valid F2FS filesystem in 1th superblock
> >>
> >> Seems the broken superblock can't be recovered by f2fs driver or
> >> fsck.f2fs. Tell me how to recover if I was wrong.:)
> >>
> >> So I'd like to provide a patch to recover broken f2fs superblock
> >> during mount. But I'm not pleased with my patch. I wish you and
> >> others could give me some suggestions.
> >>
> >> Do you think it's necessary to recover the superblock? and can
> >> we change 'f2fs_commit_super' a little to reuse this function
> >> during superblock recovery?
> > 
> > What is the real problem in the original code?
> > It's the message problem, isn't it?
> > Even though the first superblock is missing with that message, mount must be
> > done with the second superblock, right?
> > 
> > If so, it would be good to use f2fs_commit_super to recover that and leave some
> > messages.
> > 
> > Thanks,
> > 
> 
> Hi Jaegeuk,
> 
> Thanks for your suggestions. I've reworked the patch, how do you feel
> about the following one?
> 
> Current f2fs doesn't check the 2th superblock if the first one is
> valid, my patch changes to check both of superblocks during mount
> because I think either of them may corrupted and we should detect the
> corruption at once, then recover it.
> 
> Thanks,
> Hu
> 
> Signed-off-by: hujianyang <hujianyang@huawei.com>
> ---
>  fs/f2fs/super.c |   56 ++++++++++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ae14fc4..8e5cd83 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -972,29 +972,36 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>   */
>  static int read_raw_super_block(struct super_block *sb,
>  			struct f2fs_super_block **raw_super,
> -			struct buffer_head **raw_super_buf)
> +			struct buffer_head **raw_super_buf,
> +			int *recovery)
>  {
>  	int block = 0;
> +	struct buffer_head *buffer;
> +	struct f2fs_super_block *super;
> +	int err = 0;
> 
>  retry:
> -	*raw_super_buf = sb_bread(sb, block);
> -	if (!*raw_super_buf) {
> +	buffer = sb_bread(sb, block);
> +	if (!buffer) {
> +		*recovery = 1;
>  		f2fs_msg(sb, KERN_ERR, "Unable to read %dth superblock",
>  				block + 1);
>  		if (block == 0) {
>  			block++;
>  			goto retry;
>  		} else {
> -			return -EIO;
> +			err = -EIO;
> +			goto out;
>  		}
>  	}
> 
> -	*raw_super = (struct f2fs_super_block *)
> -		((char *)(*raw_super_buf)->b_data + F2FS_SUPER_OFFSET);
> +	super = (struct f2fs_super_block *)
> +		((char *)(buffer)->b_data + F2FS_SUPER_OFFSET);
> 
>  	/* sanity checking of raw super */
> -	if (sanity_check_raw_super(sb, *raw_super)) {
> -		brelse(*raw_super_buf);
> +	if (sanity_check_raw_super(sb, super)) {
> +		brelse(buffer);
> +		*recovery = 1;
>  		f2fs_msg(sb, KERN_ERR,
>  			"Can't find valid F2FS filesystem in %dth superblock",
>  								block + 1);
> @@ -1002,10 +1009,30 @@ retry:
>  			block++;
>  			goto retry;
>  		} else {
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto out;
>  		}
>  	}
> 
> +	if (!*raw_super) {
> +		*raw_super_buf = buffer;
> +		*raw_super = super;
> +	} else {
> +		/* already have a valid superblock */
> +		brelse(buffer);
> +	}
> +
> +	/* check the validity of the second superblock */
> +	if (block == 0) {
> +		block++;
> +		goto retry;
> +	}
> +
> +out:
> +	/* No valid superblock */
> +	if (!*raw_super)
> +		return err;
> +
>  	return 0;
>  }
> 
> @@ -1042,7 +1069,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	long err = -EINVAL;
>  	bool retry = true, need_fsck = false;
>  	char *options = NULL;
> -	int i;
> +	int recovery = 0, i;
> 
>  try_onemore:
>  	/* allocate memory for f2fs-specific super block info */
> @@ -1056,7 +1083,7 @@ try_onemore:
>  		goto free_sbi;
>  	}
> 
> -	err = read_raw_super_block(sb, &raw_super, &raw_super_buf);
> +	err = read_raw_super_block(sb, &raw_super, &raw_super_buf, &recovery);
>  	if (err)
>  		goto free_sbi;
> 
> @@ -1255,6 +1282,13 @@ try_onemore:
>  			goto free_kobj;
>  	}
>  	kfree(options);
> +
> +	/* recover broken superblock */
> +	if (recovery && !f2fs_readonly(sb) && !bdev_read_only(sb->s_bdev)) {
> +		f2fs_msg(sb, KERN_INFO, "Superblock recovery");
> +		f2fs_commit_super(sbi);
> +	}
> +
>  	return 0;
> 
>  free_kobj:
> -- 
> 1.6.0.2

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y

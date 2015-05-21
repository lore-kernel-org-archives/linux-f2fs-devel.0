From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH RFC] f2fs: recovering broken superblock
	during mount
Date: Wed, 20 May 2015 18:07:54 -0700
Message-ID: <20150521010635.GA63442@jaegeuk-mac02.mot.com>
References: <555C3130.9010205@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YvExz-00066D-6W
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 May 2015 01:08:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YvExy-0000vX-06 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 May 2015 01:08:07 +0000
Content-Disposition: inline
In-Reply-To: <555C3130.9010205@huawei.com>
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

On Wed, May 20, 2015 at 03:01:04PM +0800, hujianyang wrote:
> Hi Jaegeuk,
> 
> There are two superblocks in f2fs. I wrapped one of them by 'dd' in
> a reliability test. After this, the polluted f2fs partition can be
> mounted with an error message:
> 
> F2FS-fs (sdd3): Magic Mismatch, valid(0xf2f52010) - read(0x0)
> F2FS-fs (sdd3): Can't find valid F2FS filesystem in 1th superblock
> 
> Seems the broken superblock can't be recovered by f2fs driver or
> fsck.f2fs. Tell me how to recover if I was wrong.:)
> 
> So I'd like to provide a patch to recover broken f2fs superblock
> during mount. But I'm not pleased with my patch. I wish you and
> others could give me some suggestions.
> 
> Do you think it's necessary to recover the superblock? and can
> we change 'f2fs_commit_super' a little to reuse this function
> during superblock recovery?

What is the real problem in the original code?
It's the message problem, isn't it?
Even though the first superblock is missing with that message, mount must be
done with the second superblock, right?

If so, it would be good to use f2fs_commit_super to recover that and leave some
messages.

Thanks,

> 
> Thanks,
> Hu
> 
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ae14fc4..126f8fa 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -965,6 +965,33 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	clear_sbi_flag(sbi, SBI_NEED_FSCK);
>  }
> 
> +static int get_valid_super_block(struct super_block *sb,
> +			struct buffer_head **buffer, int block)
> +{
> +	struct f2fs_super_block *super;
> +
> +	*buffer = sb_bread(sb, block);
> +	if (!*buffer) {
> +		f2fs_msg(sb, KERN_ERR, "Unable to read %dth superblock",
> +				block + 1);
> +		return -EIO;
> +	}
> +
> +	super = (struct f2fs_super_block *)
> +		((char *)(*buffer)->b_data + F2FS_SUPER_OFFSET);
> +
> +	/* sanity checking of raw super */
> +	if (sanity_check_raw_super(sb, super)) {
> +		brelse(*buffer);
> +		f2fs_msg(sb, KERN_ERR,
> +			"Can't find valid F2FS filesystem in %dth superblock",
> +								block + 1);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Read f2fs raw super block.
>   * Because we have two copies of super block, so read the first one at first,
> @@ -975,37 +1002,41 @@ static int read_raw_super_block(struct super_block *sb,
>  			struct buffer_head **raw_super_buf)
>  {
>  	int block = 0;
> -
> -retry:
> -	*raw_super_buf = sb_bread(sb, block);
> -	if (!*raw_super_buf) {
> -		f2fs_msg(sb, KERN_ERR, "Unable to read %dth superblock",
> -				block + 1);
> -		if (block == 0) {
> -			block++;
> -			goto retry;
> -		} else {
> -			return -EIO;
> -		}
> +	struct buffer_head *buffer0 = NULL, *buffer1 = NULL;
> +	bool readonly = f2fs_readonly(sb) || bdev_read_only(sb->s_bdev);
> +	int err0, err1;
> +
> +	err0 = get_valid_super_block(sb, &buffer0, 0);
> +	if (!err0 && readonly)
> +		goto set_raw_super;
> +
> +	err1 = get_valid_super_block(sb, &buffer1, 1);
> +	if (err0 && err1)
> +		return err1;
> +
> +	if (err0 && !err1) {
> +		buffer0 = buffer1;
> +		if (readonly)
> +			goto set_raw_super;
> +	} else if (!err0 && !err1) {
> +		brelse(buffer1);
> +		goto set_raw_super;
>  	}
> 
> +	f2fs_msg(sb, KERN_INFO, "Recover superblock");
> +	block = buffer0->b_blocknr;
> +	buffer0->b_blocknr = block ? 0 : 1;
> +	mark_buffer_dirty(buffer0);
> +	sync_dirty_buffer(buffer0);
> +	buffer0->b_blocknr = block;
> +	clear_buffer_write_io_error(buffer0);
> +	set_buffer_uptodate(buffer0);
> +
> +set_raw_super:
> +	*raw_super_buf = buffer0;
>  	*raw_super = (struct f2fs_super_block *)
>  		((char *)(*raw_super_buf)->b_data + F2FS_SUPER_OFFSET);
> 
> -	/* sanity checking of raw super */
> -	if (sanity_check_raw_super(sb, *raw_super)) {
> -		brelse(*raw_super_buf);
> -		f2fs_msg(sb, KERN_ERR,
> -			"Can't find valid F2FS filesystem in %dth superblock",
> -								block + 1);
> -		if (block == 0) {
> -			block++;
> -			goto retry;
> -		} else {
> -			return -EINVAL;
> -		}
> -	}
> -
>  	return 0;
>  }

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y

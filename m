From: Damien Le Moal <Damien.LeMoal@hgst.com>
Subject: Re: [PATCH 1/2] f2fs: detect host-managed SMR by feature flag
Date: Wed, 15 Jun 2016 04:21:13 +0000
Message-ID: <BY2PR04MB19767501012B2D01073F1AA09F550@BY2PR04MB1976.namprd04.prod.outlook.com>
References: <20160614184322.88117-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Jaegeuk,

On 6/15/16 03:45, Jaegeuk Kim wrote:
> If mkfs.f2fs gives a feature flag for host-managed SMR, we can set mode=lfs
> by default.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h  | 21 +++++++++++++++++++++
>  fs/f2fs/super.c | 14 ++++++++------
>  2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 32be19e..1a19c02 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -133,6 +133,7 @@ struct f2fs_mount_info {
>  };
>
>  #define F2FS_FEATURE_ENCRYPT	0x0001
> +#define F2FS_FEATURE_HMSMR	0x0002
>
>  #define F2FS_HAS_FEATURE(sb, mask)					\
>  	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
> @@ -2354,6 +2355,26 @@ static inline int f2fs_sb_has_crypto(struct super_block *sb)
>  	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_ENCRYPT);
>  }
>
> +static inline int f2fs_sb_mounted_hmsmr(struct super_block *sb)
> +{
> +	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_HMSMR);
> +}
> +
> +static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
> +{
> +	clear_opt(sbi, ADAPTIVE);
> +	clear_opt(sbi, LFS);
> +
> +	switch (mt) {
> +	case F2FS_MOUNT_ADAPTIVE:
> +		set_opt(sbi, ADAPTIVE);
> +		break;
> +	case F2FS_MOUNT_LFS:
> +		set_opt(sbi, LFS);
> +		break;
> +	}
> +}
> +
>  static inline bool f2fs_may_encrypt(struct inode *inode)
>  {
>  #ifdef CONFIG_F2FS_FS_ENCRYPTION
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index edc736d..71b6066 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -515,12 +515,10 @@ static int parse_options(struct super_block *sb, char *options)
>  				return -ENOMEM;
>  			if (strlen(name) == 8 &&
>  					!strncmp(name, "adaptive", 8)) {
> -				set_opt(sbi, ADAPTIVE);
> -				clear_opt(sbi, LFS);
> +				set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
>  			} else if (strlen(name) == 3 &&
>  					!strncmp(name, "lfs", 3)) {
> -				clear_opt(sbi, ADAPTIVE);
> -				set_opt(sbi, LFS);
> +				set_opt_mode(sbi, F2FS_MOUNT_LFS);
>  			} else {
>  				kfree(name);
>  				return -EINVAL;
> @@ -980,7 +978,10 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	set_opt(sbi, EXTENT_CACHE);
>  	sbi->sb->s_flags |= MS_LAZYTIME;
>  	set_opt(sbi, FLUSH_MERGE);
> -	set_opt(sbi, ADAPTIVE);
> +	if (f2fs_sb_mounted_hmsmr(sbi->sb))
> +		set_opt_mode(sbi, F2FS_MOUNT_LFS);
> +	else
> +		set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);

Strictly speaking, host-aware drives would not require the LFS mode
as any zone of the disk can be randomly written and so the occasional 
in-place updates of the adaptive mode would be OK. However, randomly 
writing host-aware drives can lead to a lot of background activity on 
the drive side for internal management of the accumulated random writes, 
with a potential performance drop over time (this is highly dependent on 
the drive FW implementation though).

So I think it would be good to also enable the LFS mode by default for 
host-aware devices, unless the user has explicitly specified mount with 
adaptive mode (if the user "knows" that the drive FW handles very 
efficiently random writes).

So how about also introducing a F2FS_FEATURE_HASMR feature flag to 
handle these different cases ?

Also, I think that the DISCARD option must be enabled by default for 
HMSMR disks. Otherwise, zones write pointer will never get reset.
The same applies to HASMR devices mounted with the LFS mode.
(In any case, the discard handling does not look like it will always 
align to the device zone size, which will fail on a zoned disk (discard 
granularity is the zone size). I may be missing something though. Still 
checking.)

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Group, HGST Research,
HGST, a Western Digital company
Damien.LeMoal@hgst.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

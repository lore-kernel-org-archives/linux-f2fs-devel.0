From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: introduce on-disk layout version
 checking functionality
Date: Mon, 23 May 2016 14:13:57 -0700
Message-ID: <20160523211357.GA17297@jaegeuk.gateway>
References: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b4xAs-00080I-8K
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 May 2016 21:14:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b4xAr-0005Tn-9E
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 May 2016 21:14:06 +0000
Content-Disposition: inline
In-Reply-To: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Cyril.Guyot@hgst.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com, Vyacheslav.Dubeyko@hgst.com, linux-fsdevel@vger.kernel.org

Hi Slava,

On Thu, May 19, 2016 at 10:46:06AM -0700, Viacheslav Dubeyko wrote:
...
>  
> +#ifdef CONFIG_F2FS_16TB_VOLUME_SUPPORT
> +#define F2FS_MAX_SUPP_MAJOR_VERSION		(2)
> +#define F2FS_MIN_16TB_VOLUME_SUPPORT_VERSION	(2)
> +#else
> +#define F2FS_MAX_SUPP_MAJOR_VERSION		(1)
> +#endif
> +
...
>  
> +static int f2fs_check_version_and_features(struct super_block *sb,
> +					   struct f2fs_super_block *raw_super)
> +{
> +	u16 major_ver = le16_to_cpu(raw_super->major_ver);
> +	u32 feature = le32_to_cpu(raw_super->feature);
> +
> +	if (major_ver > F2FS_MAX_SUPP_MAJOR_VERSION) {

This means, for example, f2fs driver in v4.8 will deny to mount a partition
formatted by mkfs.f2fs v3.x, which doesn't make sense, IIUC.

As Christoph mentioned, how about checking the feature only like this?

1. if the feature is ON,
 - go 64 bits   , when compiled w/  F2FS_MIN_16TB_VOLUME_SUPPORT
 - fail to mount, when compiled w/o F2FS_MIN_16TB_VOLUME_SUPPORT

2. if the feature is OFF,
 - fail to mount, when compiled w/  F2FS_MIN_16TB_VOLUME_SUPPORT
 - go 32 bits   , when compiled w/o F2FS_MIN_16TB_VOLUME_SUPPORT

Thoughts?

Thanks,

> +		f2fs_msg(sb, KERN_CRIT,
> +			 "Failed to mount volume: "
> +			 "major version %u, max supported version %u",
> +			 major_ver,
> +			 F2FS_MAX_SUPP_MAJOR_VERSION);
> +		return -EOPNOTSUPP;
> +	}
> +
> +#ifdef CONFIG_F2FS_16TB_VOLUME_SUPPORT
> +
> +	if (major_ver < F2FS_MIN_16TB_VOLUME_SUPPORT_VERSION) {
> +		if (feature & F2FS_FEATURE_16TB_SUPPORT) {
> +			f2fs_msg(sb, KERN_CRIT,
> +				 "Failed to mount corrupted volume. "
> +				 "Please, check the volume by FSCK utility.");
> +			return -EOPNOTSUPP;
> +		}
> +	} else {
> +		if (!(feature & F2FS_FEATURE_16TB_SUPPORT)) {
> +			f2fs_msg(sb, KERN_CRIT,
> +				 "Failed to mount corrupted volume. "
> +				 "Please, check the volume by FSCK utility.");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +#else
> +
> +	if (feature & F2FS_FEATURE_16TB_SUPPORT) {
> +		f2fs_msg(sb, KERN_CRIT,
> +			 "Failed to mount corrupted volume. "
> +			 "Please, check the volume by FSCK utility.");
> +		return -EOPNOTSUPP;
> +	}
> +
> +#endif
> +
> +	return 0;
> +}
> +
>  static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  {
>  	struct f2fs_sb_info *sbi;
> @@ -1360,6 +1407,10 @@ try_onemore:
>  	if (err)
>  		goto free_sbi;
>  
> +	err = f2fs_check_version_and_features(sb, raw_super);
> +	if (err)
> +		goto free_sbi;
> +
>  	sb->s_fs_info = sbi;
>  	default_options(sbi);
>  	/* parse mount options */
> -- 
> 1.9.1
> 
> 

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j

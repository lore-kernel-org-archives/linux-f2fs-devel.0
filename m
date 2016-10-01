From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/2 v2] f2fs: use crc and cp version to
 determine roll-forward recovery
Date: Sat, 1 Oct 2016 08:26:20 +0800
Message-ID: <5758dbdd-610e-64cf-3cef-44794e5b32b4@kernel.org>
References: <20160920025504.72524-1-jaegeuk@kernel.org>
	<20160930171005.GC46477@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bq88a-00057j-Jp
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Oct 2016 00:26:44 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bq88Z-0005tG-Ma
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Oct 2016 00:26:44 +0000
In-Reply-To: <20160930171005.GC46477@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/10/1 1:10, Jaegeuk Kim wrote:
> @@ -1089,6 +1079,9 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>  		set_ckpt_flags(ckpt, CP_FSCK_FLAG);
>  
> +	/* set this flag to activate crc|cp_ver for recovery */
> +	set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);

Should let new introduced spinlock cover the flag updating in ("f2fs: introduce
cp_lock to protect updating of ckpt_flags").

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

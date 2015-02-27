From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: fix max orphan inodes calculation
Date: Fri, 27 Feb 2015 17:39:39 +0800
Message-ID: <018001d05271$6cc02c20$46408460$@samsung.com>
References: <1425020704-10355-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YRHPW-0004wP-14
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Feb 2015 09:40:42 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YRHPT-00082y-OU
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Feb 2015 09:40:42 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NKF00IEHC7JJQA0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Feb 2015 18:40:31 +0900 (KST)
In-reply-to: <1425020704-10355-1-git-send-email-wanpeng.li@linux.intel.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Wanpeng Li' <wanpeng.li@linux.intel.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Wanpeng,

> -----Original Message-----
> From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
> Sent: Friday, February 27, 2015 3:05 PM
> To: Jaegeuk Kim
> Cc: Wanpeng Li; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: fix max orphan inodes calculation
> 
> cp_payload is introduced for sit bitmap to support large volume, and it is
> just after the block of f2fs_checkpoint + nat bitmap, so the first segment
> should include F2FS_CP_PACKS + NR_CURSEG_TYPE + cp_payload + orphan blocks.
> However, current max orphan inodes calculation don't consider cp_payload,
> this patch fix it by reducing the number of cp_payload from total blocks of
> the first segment when calculate max orphan inodes.
> 
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
> ---
>  fs/f2fs/checkpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index db82e09..3c9d677 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1109,7 +1109,7 @@ void init_ino_entry_info(struct f2fs_sb_info *sbi)
>  	 * for cp pack we can have max 1020*504 orphan entries

The description above should be wrong, can you please update it in this patch?

>  	 */
>  	sbi->max_orphans = (sbi->blocks_per_seg - F2FS_CP_PACKS -
> -			NR_CURSEG_TYPE) * F2FS_ORPHANS_PER_BLOCK;
> +			NR_CURSEG_TYPE - __cp_payload(sbi)) * F2FS_ORPHANS_PER_BLOCK;

There is a trivial coding style issue: "line over 80 characters"

Thanks,



------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/

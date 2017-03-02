From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: correct cp_ver for compatibility to
	old image
Date: Thu, 2 Mar 2017 10:55:18 -0800
Message-ID: <20170302185518.GA1030@jaegeuk.local>
References: <20170302032233.89189-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cjVst-00038V-Ex
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Mar 2017 18:55:27 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cjVss-0003NR-AV
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Mar 2017 18:55:27 +0000
Content-Disposition: inline
In-Reply-To: <20170302032233.89189-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 03/02, Chao Yu wrote:
> There is no CP_CRC_RECOVERY_FLAG tagged in checkpoint pack, calculate
> cp_version as old format.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/node.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 6c027b6833f4..0d46404ca769 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2507,7 +2507,9 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>  		f2fs_put_page(page, 1);
>  	}
>  
> -	cp_ver |= (cur_cp_crc(ckpt) << 32);
> +	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
> +		cp_ver |= (cur_cp_crc(ckpt) << 32);

Well, we always write nat_bits with crc. So if it's different, something is
wrong and we need to drop it. CP-CRC_RECOVERY_FLAG is used for roll-forward
recovery, which is a different context.

> +
>  	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
>  		disable_nat_bits(sbi, true);
>  		return 0;
> -- 
> 2.8.2.295.g3f1c1d0

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

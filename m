From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: don't finalize device early
Date: Mon, 16 Oct 2017 11:52:48 +0800
Message-ID: <e902d75b-4e51-158b-ddbe-0f06102bb387@huawei.com>
References: <20171014192252.52845-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e3wSm-0005CW-M7
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Oct 2017 03:53:12 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e3wSl-00031k-It
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Oct 2017 03:53:12 +0000
In-Reply-To: <20171014192252.52845-1-jaegeuk@kernel.org>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: He Yunlei <heyunlei@huawei.com>

On 2017/10/15 3:22, Jaegeuk Kim wrote:
> We should close the device by main body of each tools.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fsck/mount.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 7a28314..c78314e 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1941,9 +1941,6 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>  	if (flags & CP_NAT_BITS_FLAG)
>  		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
>  
> -	/* in case of sudden power off */
> -	f2fs_finalize_device();

IIRC, Yunlei wants to fsync previous data in checkpoint area before write last
CP pack, in order to avoid checkpoint corruption in sudden-power-off case.

Shouldn't we use fsync(main-device-fd) here instead?

Thanks,

> -
>  	/* write the last cp */
>  	ret = dev_write_block(cp, cp_blk_no++);
>  	ASSERT(ret >= 0);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fsck.f2fs: fix to skip repairing initialized
 i_gc_failures
Date: Mon, 26 Nov 2018 16:04:35 -0800
Message-ID: <20181127000435.GE55960@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181126141914.8238-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gRQrs-0003nt-Dv
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 00:04:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRQrp-004vTn-Ei
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 00:04:44 +0000
Content-Disposition: inline
In-Reply-To: <20181126141914.8238-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 11/26, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> =

> As Michael reported:
> =

> after updating to f2fs-tools 1.12.0, a routine fsck of my file systems
> took quite a while and output ten-thousands instances of the following
> line:
> =

> > [FIX] (fsck_chk_inode_blk: 954)  --> Regular: 0xXYZ reset i_gc_failures=
 from 0x1 to 0x00
> =

> In old kernel, we initialized i_gc_failures as 0x01, let's skip
> resetting such unchanged initialized value to avoid unnecessary
> repairing.
> =

> Reported-by: Michael La=DF <bevan@bi-co.net>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fsck/fsck.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> =

> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 970d150..db0e72f 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -941,7 +941,9 @@ skip_blkcnt_fix:
>  	}
>  =

>  	i_gc_failures =3D le16_to_cpu(node_blk->i.i_gc_failures);
> -	if (ftype =3D=3D F2FS_FT_REG_FILE && i_gc_failures) {
> +
> +	/* old kernel initialized i_gc_failures as 0x01, skip repairing */
> +	if (ftype =3D=3D F2FS_FT_REG_FILE && i_gc_failures > 1) {

This will break the current implementation.

>  =

>  		DBG(1, "Regular Inode: 0x%x [%s] depth: %d\n\n",
>  				le32_to_cpu(node_blk->footer.ino), en,
> -- =

> 2.18.0

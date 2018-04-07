From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] common/config: support f2fs-tools v1.9 and
 later
Date: Sat, 7 Apr 2018 23:29:52 +0800
Message-ID: <20180407152952.GP30836@localhost.localdomain>
References: <20180405221901.41861-1-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guaneryu@gmail.com>) id 1f4pn5-00060y-5W
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Apr 2018 15:30:07 +0000
Received: from mail-pf0-f196.google.com ([209.85.192.196])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f4pn3-00HA2N-7H
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Apr 2018 15:30:07 +0000
Received: by mail-pf0-f196.google.com with SMTP id u86so2857986pfd.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 07 Apr 2018 08:30:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180405221901.41861-1-ebiggers@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Apr 05, 2018 at 03:19:01PM -0700, Eric Biggers wrote:
> Pass the -f option to mkfs.f2fs when it appears to support it.  This is
> required by f2fs-tools v1.9 and later in order to format the filesystem
> even when an existing filesystem is detected.  But earlier versions did
> not accept this option.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks fine to me, but I'd like an ACK from f2fs developers.

> ---
>  common/config | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 20f0e5f3..7c046a78 100644
> --- a/common/config
> +++ b/common/config
> @@ -94,10 +94,11 @@ set_prog_path()
>  	type -P $1
>  }
>  
> -# Handle mkfs.btrfs which does (or does not) require -f to overwrite
> -set_btrfs_mkfs_prog_path_with_opts()
> +# Handle mkfs.$fstyp which does (or does not) require -f to overwrite
> +set_mkfs_prog_path_with_opts()
>  {
> -	p=`set_prog_path mkfs.btrfs`
> +	local fstyp=$1
> +	local p=`set_prog_path mkfs.$fstyp`
>  	if [ "$p" != "" ] && grep -q 'force overwrite' $p; then

Also grep the "$p -h" output instead of the binary file?

Thanks,
Eryu

>  		echo "$p -f"
>  	else
> @@ -223,8 +224,8 @@ case "$HOSTOS" in
>          export MKFS_XFS_PROG="`set_prog_path mkfs.xfs`"
>          export MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
>          export MKFS_UDF_PROG="`set_prog_path mkudffs`"
> -        export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
> -        export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
> +        export MKFS_BTRFS_PROG="`set_mkfs_prog_path_with_opts btrfs`"
> +        export MKFS_F2FS_PROG="`set_mkfs_prog_path_with_opts f2fs`"
>          export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
>          export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
>          export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
> -- 
> 2.17.0.484.g0c8726318c-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

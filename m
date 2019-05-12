From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [RFC PATCH 1/7] common/encrypt: introduce helpers
 for set_encpolicy and get_encpolicy
Date: Sun, 12 May 2019 20:21:52 +0800
Message-ID: <20190512122152.GI15846@desktop>
References: <20190426204153.101861-1-ebiggers@kernel.org>
 <20190426204153.101861-2-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guaneryu@gmail.com>) id 1hPnUV-0005Tj-Cy
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 12 May 2019 12:22:07 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hPnUU-000a7R-21
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 12 May 2019 12:22:07 +0000
Received: by mail-pg1-f196.google.com with SMTP id e6so5302818pgc.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 12 May 2019 05:22:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190426204153.101861-2-ebiggers@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Fri, Apr 26, 2019 at 01:41:47PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> For conciseness in tests, add helper functions that wrap the xfs_io
> commands 'set_encpolicy' and 'get_encpolicy'.  Then update all
> encryption tests to use them.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  common/encrypt        | 34 ++++++++++++++++++++++++++++++++--
>  tests/ext4/024        |  3 +--
>  tests/generic/395     | 28 +++++++++++++---------------
>  tests/generic/395.out |  2 +-
>  tests/generic/396     | 15 +++++++--------
>  tests/generic/397     |  3 +--
>  tests/generic/398     |  5 ++---
>  tests/generic/399     |  3 +--
>  tests/generic/419     |  3 +--
>  tests/generic/421     |  3 +--
>  tests/generic/429     |  3 +--
>  tests/generic/435     |  3 +--
>  tests/generic/440     |  5 ++---
>  13 files changed, 64 insertions(+), 46 deletions(-)
> 
> diff --git a/common/encrypt b/common/encrypt
> index 1b10aa71..54d873fa 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -38,8 +38,7 @@ _require_scratch_encryption()
>  	# presence of /sys/fs/ext4/features/encryption, but this is broken on
>  	# some older kernels and is ext4-specific anyway.)
>  	mkdir $SCRATCH_MNT/tmpdir
> -	if $XFS_IO_PROG -c set_encpolicy $SCRATCH_MNT/tmpdir \
> -		2>&1 >>$seqres.full | \
> +	if _set_encpolicy $SCRATCH_MNT/tmpdir 2>&1 >>$seqres.full | \
>  		egrep -q 'Inappropriate ioctl for device|Operation not supported'
>  	then
>  		_notrun "kernel does not support $FSTYP encryption"
> @@ -175,3 +174,34 @@ _revoke_encryption_key()
>  	local keyid=$($KEYCTL_PROG search @s logon $FSTYP:$keydesc)
>  	$KEYCTL_PROG revoke $keyid >>$seqres.full
>  }
> +
> +# Set an encryption policy on the specified directory.
> +_set_encpolicy()
> +{
> +	local dir=$1
> +	shift
> +
> +	$XFS_IO_PROG -c "set_encpolicy $*" "$dir"
> +}
> +
> +_user_do_set_encpolicy()
> +{
> +	local dir=$1
> +	shift
> +
> +	_user_do "$XFS_IO_PROG -c \"set_encpolicy $*\" \"$dir\""
> +}
> +
> +_require_get_encpolicy()
> +{
> +	_require_xfs_io_command "get_encpolicy"
> +}

This doesn't seem necessary to me, just calling

_require_xfs_io_command "get_encpolicy"

explicitly is fine to me.

Thanks,
Eryu

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031A4C61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fg+Poxae/W/Hxkwzt4Ygd4lc9BpeakHeeLIcKLAlh1A=; b=gKFKi7q36Cn6R5BA9dI7pSfIuG
	0zBx17bQ74suHQGqE9WmNGG+/Ny3IjWtypfAlJH3kkeTkI8HauSvKLXcITzwsOcHWK2/EEeGwsssb
	fRnsgB6KsZgqMZpPGmC2Ou3t5dwrvZcFHsjxguC42KKr/n2m9GElwx7E6TN0b/3Xqa/w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1K1P-0001PL-BU;
	Tue, 01 Sep 2026 08:39:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1K1O-0001PD-AG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 08:39:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zhkPVoqdfinJ81L4Qda11eGJhGh7cb57yzPtQyej4UY=; b=SWf0ZpO4pWYgRcU3hl7dB/MAlK
 7fqZ7rYlGHvdid4r/0JrJ4HKTgy5uYwp1kKWG73KgWRpDETK4vznbDcz0rx0MUMQsIBGLUNdcKTfB
 5BHwgxuToBn/roxAnCyfy+SuOpkFN4ehcU4UoCY9J/6dg/37651hwccg8CZCz+tsR/A8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zhkPVoqdfinJ81L4Qda11eGJhGh7cb57yzPtQyej4UY=; b=T6+Fwdiw9Zmfzuvk2PeAQ7Y+/M
 pgIOTEWNnPaZjputl1KdXsANXKmevOeTX/IKqASD2tCivtY+8eP2MmdKCjiNdKFDVC95febuRcqcK
 iIE+COgOvgGO979Xph5mS4YLzUmElipHxfagSyBjmDiwyjfwTx/UjIYScCN/1gvTJ5g8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1K1M-00015y-Bj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 08:39:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF93D601DB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 08:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A971F000E9;
 Tue,  1 Sep 2026 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788251942;
 bh=zhkPVoqdfinJ81L4Qda11eGJhGh7cb57yzPtQyej4UY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WJuxSrOJHVIaYS/NlK4tlQD+/TDWYLeVY0YHxIv5/5+arLO9bCoXq1XQQn7W0WQTk
 OewR+G1WLuEEQ+OVVVUDoXomVVDUtVLtYmSfvmJlgYBvxOEJxQDt+fPlqyfleE0N6x
 6JaEjX/c975qqbBneSKvwQ2atHc60iK+VjMn9cDm4V+2e1FMsDIaGHM1F0BA6rubXZ
 PRCmjJzQa08KshgjKq3q/5CxJz5kElWeVWNpyAE3dAJJsf7pOFfzmQ6Of1v3ekrRrp
 LX0sK1h/kPFqx8mqDAWL/Pvl3zJIQpUTzcOClDHpsD+KDzNFPXWGitJiEhThdYJndt
 w4+dB9trevm6g==
Date: Tue, 1 Sep 2026 20:33:35 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <apa_4wZ21FydhN8U@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <4fa4f6bc500e0496e3d8598d38cf69597493a25b.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4fa4f6bc500e0496e3d8598d38cf69597493a25b.1784949154.git.asj@kernel.org>
X-Headers-End: 1x1K1M-00015y-Bj
Subject: Re: [f2fs-dev] [PATCH v8 01/13] fstests: add
 _loop_image_create_clone() helper
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: djwong@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jul 25, 2026 at 03:38:58PM +0800, Anand Jain wrote:
> Introduce _loop_image_create_clone() and _loop_image_destroy() to mkfs an
> image file and clone it to another image file, and attach a loop device to
> them. And its destroy part.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  common/rc | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 106f044adc2d..e8ff5be0c547 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1520,6 +1520,71 @@ _scratch_resvblks()
>  	esac
>  }
>  
> +# Create a small loop image, run an optional tuning function ($2) on it,
> +# clone it, and attach both to loop devices, returned in ($1).
> +# Args:
> +#   $1: Nameref to return the array of allocated loop devices [base, clone].
> +#   $2: Optional callback function to tune the base filesystem before cloning.
> +_loop_image_create_clone()

To capture both the relationship and distinction between this function and
existing _create_loop_device, I'd like to rename it to *_create_cloned_loop_devs*.

> +{
> +	local -n _ret=$1
> +	local pre_clone_tune_func="$2"
> +	local img_file=$TEST_DIR/${seq}.img
> +	local img_file_clone=$TEST_DIR/${seq}_clone.img
> +	local size=$(_small_fs_size_mb 128) # Smallest possible
> +	local loop_devs=()
> +
> +	# Since we copy the block device image, we keep its size small.
> +	_require_fs_space $TEST_DIR $((size * 1024 * 2))
> +
> +	_create_file_sized $((size * 1024 * 1024)) $img_file ||
> +				_fail "Failed: Create $img_file $size"
> +
> +	loop_devs=("$(_create_loop_device $img_file)")
> +
> +	case $FSTYP in
> +	xfs)
> +		_mkfs_dev -s size=4096 "${loop_devs[0]}"

Why xfs needs a specific "-s size=4096" ? Hardcoding this parameter might cause
failures in certain incompatible environments.

> +		;;
> +	btrfs)
> +		_mkfs_dev "${loop_devs[0]}"

If btrfs is handled the same way as the default `*)` branch below, there is
no need to have a dedicated branch for it.

> +		;;
> +	*)
> +		_mkfs_dev "${loop_devs[0]}"
> +		;;
> +	esac
> +
> +	# Only execute if the function argument is not empty
> +	if [ -n "$pre_clone_tune_func" ]; then
> +		$pre_clone_tune_func "${loop_devs[0]}"
> +	fi
> +
> +	sync "${loop_devs[0]}"

Since the mkfs command above operates directly on a loop device, I wanted to
make sure, can the sync command be targeted at a block device, and does it
guarantee a cache flush or blockdev page cache sync ?

How about:
  sync -d "${loop_devs[0]}"
  blockdev --flushbufs "${loop_devs[0]}"
or any better idea?

> +	cp $img_file $img_file_clone || _fail "Failed to copy cloned image"
> +
> +	loop_devs+=("$(_create_loop_device $img_file_clone)")
> +
> +	_ret=()
> +	for i in "${loop_devs[@]}"; do
> +		_ret+=("$i")
> +	done

How about:
  _ret=("${loop_devs[@]}")
directly?

> +}
> +
> +# Teardown loop devices and delete their underlying backing image files.
> +# Accepts a list of loop device paths (e.g., /dev/loop0 /dev/loop1).
> +_loop_image_destroy()

To keep it consistent with the renamed function above, we could rename this
to *_destroy_cloned_loop_devs*. Alternatively, if we don't consider it
clone-specific, *destroy_loop_devs* would also be good to me.

Thanks,
Zorro

> +{
> +	for d in "$@"; do
> +		# Retrieve the path of the backing file
> +		local f=$(losetup --noheadings --output BACK-FILE $d)
> +
> +		# Detach the loop device from the backing file
> +		_destroy_loop_device "$d"
> +
> +		# Clean up the backing disk image file
> +		[ -n "$f" ] && rm -f "$f"
> +	done
> +}
>  
>  # Repair scratch filesystem.  Returns 0 if the FS is good to go (either no
>  # errors found or errors were fixed) and nonzero otherwise; also spits out
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

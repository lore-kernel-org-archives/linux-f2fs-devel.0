Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739CF606A693
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WtZ1PoRS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g8pK/JcK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dRb2Rsi4;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzoA6nYv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qDJ1+zhyLTiwdvBxXGyO6vg2PN6I1IUL8I7+wNC9oAA=; b=WtZ1PoRS9mHEHMp7NvTeE8uoLK
	o3r0kPnLW3tVaCCvZ/xy5qulGElpmvJcymneW0sRgp+i7g7j8dZ74zu0JTdR9lRl7BQz65aaorlLX
	BGiA6TevsJepqNvOZIfOpOzPYuZIZWq4mURUi3hEjea2DyzaX0CZRptCcrKgWsK57E04=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVXyP-000000007N8-2brs;
	Mon, 23 Nov 2026 17:37:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVXyO-000000007Ms-1CfE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Y6aOWkpjpSTVf2HoD6BSvDp+T6/1/XKZfs2BsPaJSI=; b=g8pK/JcKQBv1WMV7xB133AwmRi
 DZ0vswFT8/Zb6TUvMQGVWcx0x+McGzHlVMEaTnGe8pbGoFUWiwRV2HsUp7G3ghjm0cJrDqElhr+TZ
 K+5JqrHytfdY+obgRxoYCkBX3WWtWmPUTJUO2QGikuIP4EPiaMi6SSu1Iw21EyvwMlFI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Y6aOWkpjpSTVf2HoD6BSvDp+T6/1/XKZfs2BsPaJSI=; b=dRb2Rsi4pIVQMkma7fjY+vNtVO
 V3LxhDVOJc4YTEkB3zk46tHeEBtXM5ewEM0Rf7dDlMOCdk0PNcrPNrJmc0hh+h7EFVZ/w0mjRLI6U
 gi7EYSI3+GYulI6bAiujIXr0f17Rgg98s9YD11fhXPonBixkhJfqFf/J9CFjQyQDaR1s=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVXyM-000000001tW-3Xsr
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:37:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E858623B1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 17:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9A61F000D2;
 Mon, 23 Nov 2026 17:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795455412;
 bh=9Y6aOWkpjpSTVf2HoD6BSvDp+T6/1/XKZfs2BsPaJSI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mzoA6nYvtMEt6dkhL+n8rOfWS/EDMN0nEK7E8HbmA/DhDEt2FDTlY5SA4FN+0MawJ
 iHxkiA3GKPvQqNtGvmNvDC8QdWQTXz9pOpS+nvkP9wDUk0+Hp4GabXGCraWxgWxXru
 pLBVzQDy/bCtMkxAiJSgnZCq0b7P/8AB+Ux/tfj+rjXErb5nPYCuRVNHaJSZPM3YmR
 6x16niKPTzyCqCbzQkzCQIhOQNW2nxOdkCGcQSyq+S27IKkZXG0MXDo1MX687Cll/S
 1KOC4nljE5QKik527KcGu0sw2o9JaziyYBZvqRx+g0q+OlfjoUMb/dSvoL2nAloQBk
 RW7lwUvJWmguw==
Date: Tue, 24 Nov 2026 01:36:42 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awR26muFLJ2qF5qN@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <d97b87a346488157df940edbf89c62b71bbd0340.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d97b87a346488157df940edbf89c62b71bbd0340.1791272793.git.asj@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVXyM-000000001tW-3Xsr
Subject: Re: [f2fs-dev] [PATCH 02/21] fstests: introduce
 _create_cloned_loop_devs() helper
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 06, 2026 at 04:55:28PM +0800, Anand Jain wrote:
> Introduce _create_cloned_loop_devs() and _destroy_cloned_loop_devs to mkfs an
> image file and clone it to another image file, and attach a loop device to
> them. And its destroy part.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  common/rc | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 7868e6d311a2..f2ab4bc491af 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1534,6 +1534,72 @@ _scratch_resvblks()
>  	esac
>  }
>  
> +# Create a small loop image, run an optional tuning function ($2) on it,
> +# clone it, and attach both to loop devices, returned in ($1).
> +# Args:
> +#   $1: Nameref to return the array of allocated loop devices [base, clone].
> +#   $2: Optional callback function to tune the base filesystem before cloning.
> +_create_cloned_loop_devs()
> +{
> +	local -n _ret=$1
> +	local pre_clone_tune_func="$2"
> +	local img_file="$TEST_DIR/${seq}/orig.img"
> +	local img_file_clone="$TEST_DIR/${seq}/clone.img"
> +	local size=$(_small_fs_size_mb 128) # Smallest possible
> +	local temp_dev
> +	local loop_devs=()
> +
> +	# All current callers mount the original and the clone simultaneously.
> +	_require_clone_mount
> +
> +	# Since we copy the block device image, we keep its size small.
> +	_require_fs_space $TEST_DIR $((size * 1024 * 2))
> +
> +	_create_file_sized $((size * 1024 * 1024)) $img_file ||
> +				_fail "Failed: Create $img_file $size"
> +
> +	temp_dev=("$(_create_loop_device_like_bdev $img_file ${TEST_DEV})")
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
You defined this as an array here, but later you treat it as a regular variable.
If an array isn't needed here, just declare it as a normal variable.

> +	_mkfs_dev "${temp_dev}"
               ^^^^^^^^^^^

> +
> +	# Only execute if the function argument is not empty
> +	if [ -n "$pre_clone_tune_func" ]; then
> +		$pre_clone_tune_func "${temp_dev}"
                              ^^^^^^^^^^^

> +	fi
> +
> +	# We are about to copy the loop device's backing file
> +	# Flush loop device's buffer cache
> +	blockdev --flushbufs "${temp_dev}"
                          ^^^^^^^^^^^
> +	# Sync system's dirty pages including backing file's
> +	sync
> +	_destroy_loop_device "${temp_dev}"
                          ^^^^^^^^^^^
> +
> +	cp $img_file $img_file_clone || _fail "Failed to copy cloned image"
> +
> +	loop_devs=("$(_create_loop_device_like_bdev $img_file ${TEST_DEV})")
> +	loop_devs+=("$(_create_loop_device_like_bdev $img_file_clone ${TEST_DEV})")
> +
> +	# Help debug
> +	losetup --list "${loop_devs[0]}" >> $seqres.full
> +	losetup --list "${loop_devs[1]}" >> $seqres.full
> +
> +	_ret=("${loop_devs[@]}")
> +}
> +
> +# Teardown loop devices and delete their underlying backing image files.
> +# Accepts a list of loop device paths (e.g., /dev/loop0 /dev/loop1).
> +_destroy_cloned_loop_devs()
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

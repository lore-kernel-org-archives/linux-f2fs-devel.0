Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A69CD6E49
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2026 04:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pPo3oS+MnDzzn1b3QLOj0b5XMBwEOXE9UIUcRsdssUU=; b=MBVghsc+6JdiXkTMGTfDuSoGlE
	jAatrK8wlXawTX1ApAOE07rhQXcnienPvmnv+JM6tnehemGnUXGRGN8SD45W4uVI+lI2DObRcEVej
	mwfp1rYYAEgOWbuJwirxIinzYOJemxe06zDfsYsKXDmI6nEphPHLmTPqQWQFO4o0dZbg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSopA-0002ac-RO;
	Fri, 29 May 2026 04:27:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wSop9-0002Zd-6s
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 May 2026 04:27:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HqCYZs2wlS5Sw/AOAlKzlJPT1ANIz0S+Gw3elOFl6LI=; b=KBK6COcCy4pwiu0En9QMKMGvyz
 i4lBT6pF//MBQykVBuIzaTQ/aSjPYnvT8AAMK1Ov06BMETCa0pTDb3Kw/cqyJ6eAqWHELhk7K4rh2
 n3nldOJUhfwU+hhpcevw943OnXhxJT5NAYiswllf6LTUtsGFNa14vXAZkmlvVzwgUPJM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HqCYZs2wlS5Sw/AOAlKzlJPT1ANIz0S+Gw3elOFl6LI=; b=MasU/OstGvMlWfx/OPtf6Dd+2s
 UG4yG20DKcEhMnz56L05DDYgX3Lrx96QpIdw/YPRDBn8Zu21m29PNvFlagkrU/DdL14we+xVwkiWV
 HRDN/fbBT2Np5V9ClPxRcmpVU1d2IgIShtKZbzYi7ZKbnqdAUg553MJiwTTuvxedqHeQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSop8-0007wg-3X for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 May 2026 04:27:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 39BDD43ABC;
 Fri, 29 May 2026 04:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0E8961F00893;
 Fri, 29 May 2026 04:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780028864;
 bh=HqCYZs2wlS5Sw/AOAlKzlJPT1ANIz0S+Gw3elOFl6LI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hpjm47+eVu5hbHMHY+XeCvXRczVYs4LsOB76U93I1dwcw/PaMlZY4Phpop+dXeXmU
 En2ImAr6bjSYnMhzuO48d0H5k7xPhlsfwSqvpNVQdOFnmRtimLswlRxraUJoSQstvS
 DjU74JNVpG0pzYMpvZFf4VecbqndYsFquvwSWer4U8Sw0DIVSiwlMn/yuoV4aqhPNm
 2dgorvSUQ18YMAD2rPY/6q75bipMuD8l6HLazDQ3s4wH996JnG4Y9VUP0Md1U1ZspJ
 0T9u/AkRcRjbRUm0GWbSnNZCW5NSRCylBsAgFetO2fCkb6EH+pn3efuAV3/N5UuSEh
 T46s17M/Qk0hg==
Date: Thu, 28 May 2026 21:27:43 -0700
To: Anand Jain <asj@kernel.org>
Message-ID: <20260529042743.GB6070@frogsfrogsfrogs>
References: <cover.1779939330.git.asj@kernel.org>
 <421c7cdd5aae27b99d04dddf08c5d9df79c2f790.1779939330.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <421c7cdd5aae27b99d04dddf08c5d9df79c2f790.1779939330.git.asj@kernel.org>
X-Headers-End: 1wSop8-0007wg-3X
Subject: Re: [f2fs-dev] [PATCH v6 01/11] fstests: add
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@infradead.org, zlang@redhat.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, May 28, 2026 at 12:05:32PM +0800, Anand Jain wrote:
> Introduce _loop_image_create_clone() and _loop_image_destroy() to mkfs an
> image file and clone it to another image file, and attach a loop device to
> them. And its destroy part.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  common/rc | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 79189e7e6e94..d7e3e0bdfb1e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1520,6 +1520,69 @@ _scratch_resvblks()
>  	esac
>  }
>  
> +# Create a small loop image, run an optional tuning function ($2) on it,
> +# clone it, and attach both to loop devices, returned in ($1).
> +# Args:
> +#   $1: Nameref to return the array of allocated loop devices [base, clone].
> +#   $2: Optional callback function to tune the base filesystem before cloning.
> +_loop_image_create_clone()
> +{
> +	local -n _ret=$1

That switch   ^^ is very clever.  I always wondered how one did indirect
variables in bash.

> +	local pre_clone_tune_func="$2"
> +	local img_file=$TEST_DIR/${seq}.img
> +	local img_file_clone=$TEST_DIR/${seq}_clone.img
> +	local size=$(_small_fs_size_mb 128) # Smallest possible
> +	local loop_devs
> +
> +	# Since we copy the block device image, we keep its size small.
> +	_require_fs_space $TEST_DIR $((size * 1024))
> +
> +	_create_file_sized $((size * 1024 * 1024)) $img_file ||
> +				_fail "Failed: Create $img_file $size"
> +
> +	loop_devs=$(_create_loop_device $img_file)
> +	_ret=($loop_devs)

Should this check that a loopdev actually got created?

> +	case $FSTYP in
> +	xfs)
> +		_mkfs_dev "-s size=4096" ${loop_devs[0]}
> +		;;
> +	btrfs)
> +		_mkfs_dev ${loop_devs[0]}
> +		;;
> +	*)
> +		_mkfs_dev ${loop_devs[0]}
> +		;;
> +	esac
> +
> +	# Only execute if the function argument is not empty
> +	if [ -n "$pre_clone_tune_func" ]; then
> +		$pre_clone_tune_func ${loop_devs[0]}
> +	fi
> +
> +	sync ${loop_devs[0]}
> +	cp $img_file $img_file_clone
> +
> +	loop_devs="$loop_devs $(_create_loop_device $img_file_clone)"

	local lodev="$(_create_loop_device ...)"

	test -z "$lodev" && _fail "second loopdev not created"
	_ret+=("$lodev")

?

> +
> +	_ret=($loop_devs)
> +}
> +
> +# Teardown loop devices and delete their underlying backing image files.
> +# Accepts a list of loop device paths (e.g., /dev/loop0 /dev/loop1).
> +_loop_image_destroy()
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
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

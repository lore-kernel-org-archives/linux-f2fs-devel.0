Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE9606A32A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aY3laaKb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lzBx31Q2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=At3wJpyv;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfy3RuDS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jy4VjVbu2w/F7pbr8dKYPJxD6hU6v2ybC7LBgD11fng=; b=aY3laaKbI0zkHn21kHhVR8hasG
	t+E3ZuPbA3Z+pSLZrf7v7Wb4pNOLBZK/cwaeqzZ9fm9N0MbqtDU00ogtbgubJtcvuTy6Hw1E4kFIa
	liNID69qIy94xh2xyhSMYaaFj8SuMk+m7ALQswZbKaxJF43B7NO8ppuuF/qEayioYTGc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZPB-000000002gk-045E;
	Mon, 23 Nov 2026 19:08:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZPA-000000002ge-0FK8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 19:08:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fTN8vdK235+uC79sauRv+UP8AALuyUxzYO9E3eZKSZc=; b=lzBx31Q2aJINhmTmLOBg6iXeCC
 MmwBZ6ojP1iDKGy44PecE6wGSG5lVNxBjHcY6gKjDYbw1qNgwwF3kd9sS+UlE1QVgBPwttSeA1FxM
 OeKSaHG6jG56eV2F3LfOollmQS+Gt8LYFELRkYLkpSgcBdOruHkZLDDFWrPzRrhIPtjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fTN8vdK235+uC79sauRv+UP8AALuyUxzYO9E3eZKSZc=; b=At3wJpyvdx8/uRvSyS1JrswG+F
 5Tg9eYjbsMdIomspe91pUWmcX+Pkeo0kblDsPbtnLnPgdpSpysawoIBDiSF3uSydGNOCK7i1B3Uvs
 ZsAmql+hncO0g7qaJYumFjFnMJLugbnK1kOhcf607FWFTFCfweGz/2kLYfLAL6zqPxFM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZP8-000000004TF-2hez
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 19:08:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 41D8C42DD1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 19:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E1D1F000ED;
 Mon, 23 Nov 2026 19:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795460917;
 bh=fTN8vdK235+uC79sauRv+UP8AALuyUxzYO9E3eZKSZc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kfy3RuDSQ9EIQvEeNT3epUDAPezGpBL+AyFR3Xgqc57X2lce7oOHHb/xFaT27FTWZ
 s5zKBXkhCFQM9QwiEf5/wQo8BJ35drSvcGtePSMiEZ/XrZ538pR2CNqJ4BOzQnA5nq
 1e/pZu+s4oH2KNYMk4y4kB0xbTtCDjCQqgTwQ8SD9YmD2n0lJiObxDqIHvwJD/bN2K
 HhcgRtPSmTMUff9Az8j5KbpWljbxclib6bL5ZAKNowkNtBr3Stu2glxrjuay8bdEJK
 LCT9SNOVFlhT7hlD4li2+AG8Vlup4ncCBQNwdik6dPOVzL4+ZeloWCF7qf7/wYV/bO
 cBrXJ8q6HnyJQ==
Date: Tue, 24 Nov 2026 03:08:29 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSPHC1UWULsJCx8@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <2d0903ee55156a1a384f95b6e54ce2bacf0c9a77.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d0903ee55156a1a384f95b6e54ce2bacf0c9a77.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVZP8-000000004TF-2hez
Subject: Re: [f2fs-dev] [PATCH 20/21] fstests: generic/744: migrate to
 _create_cloned_loop_devs()
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

On Tue, Oct 06, 2026 at 04:55:46PM +0800, Anand Jain wrote:
> Switch generic/744 to use the common _create_cloned_loop_devs() helper
> to format, modify, and clone the underlying loop devices, avoiding
> open-coded clone setup and teardown logic.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/generic/744 | 70 ++++++++++++++++++-----------------------------
>  1 file changed, 27 insertions(+), 43 deletions(-)
> 
> diff --git a/tests/generic/744 b/tests/generic/744
> index 330d86ce826a..c522d6f46713 100755
> --- a/tests/generic/744
> +++ b/tests/generic/744
> @@ -10,71 +10,55 @@
>  . ./common/preamble
>  _begin_fstest auto clone volume tempfsid
>  
> -_cleanup()
> -{
> -	cd /
> -	rm -r -f $tmp.*
> -
> -	_unmount $mnt2 &> /dev/null
> -	_unmount $mnt1 &> /dev/null
> -	[ -b "$loop_dev2" ] && _destroy_loop_device $loop_dev2
> -	[ -b "$loop_dev1" ] && _destroy_loop_device $loop_dev1
> -	[ -n "$seq" ] && rm -rf $TEST_DIR/$seq
> -}
> -
>  . ./common/filter
>  . ./common/reflink
>  
> -_require_clone_mount
>  _require_test
>  _require_block_device $TEST_DEV
>  _require_test_reflink
>  _require_cp_reflink
>  _require_loop
>  
> -clone_filesystem()
> +_cleanup()
>  {
> -	local dev1=$1
> -	local dev2=$2
> -
> -	_mkfs_dev $dev1
> -
> -	_mount $dev1 $mnt1
> -	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo >> $seqres.full
> -	_unmount $mnt1
> +	cd /
> +	rm -r -f $tmp.*
>  
> -	# device dump of $dev1 to $dev2
> -	dd if=$dev1 of=$dev2 conv=fsync status=none || _fail "dd failed: $?"
> +	_unmount $mnt2 &> /dev/null
> +	_unmount $mnt1 &> /dev/null
> +	_destroy_cloned_loop_devs "${devs[@]}" 2> /dev/null
>  }
>  
> -[ -n "$seq" ] && rm -rf $TEST_DIR/$seq
> -mkdir $TEST_DIR/$seq
> +add_foo()
> +{
> +	local orig_dev="$1"
> +	local temp_mnt="$TEST_DIR/$seq/temp_mnt"
> +
> +	mkdir -p $temp_mnt
> +	_mount $(_common_dev_mount_options) $(_clone_mount_options) $orig_dev $temp_mnt
> +	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $temp_mnt/foo >> $seqres.full
> +	$XFS_IO_PROG -c 'fsync' $temp_mnt/foo
> +	_unmount $temp_mnt
> +}
>  
> +rm -rf $TEST_DIR/$seq 2>/dev/null
> +mkdir -p $TEST_DIR/$seq
> +# Setup base loop device and its clone
> +devs=()
> +_create_cloned_loop_devs devs add_foo
>  mnt1=$TEST_DIR/$seq/mnt1
>  mnt2=$TEST_DIR/$seq/mnt2
> -mkdir -p $mnt1 $mnt2
> -
> -loop_file1="$TEST_DIR/$seq/image1"
> -truncate -s 300m "$loop_file1"
> -loop_dev1=$(_create_loop_device "$loop_file1")
> -
> -loop_file2="$TEST_DIR/$seq/image2"
> -truncate -s 300m "$loop_file2"
> -loop_dev2=$(_create_loop_device "$loop_file2")
> -
> -clone_filesystem ${loop_dev1} ${loop_dev2}
> +mkdir -p $mnt1
> +mkdir -p $mnt2
>  
>  # Mounting original device
> -_mount $(_common_dev_mount_options) $(_clone_mount_options) $loop_dev1 $mnt1
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1
>  $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo | _filter_xfs_io
> -
>  # Mounting cloned device
> -_mount $(_common_dev_mount_options) $(_clone_mount_options) $loop_dev2 $mnt2 \
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 \
>  					|| _fail "mount of cloned device failed"
>  
>  # cp reflink across two different filesystems must fail
>  _cp_reflink $mnt1/foo $mnt2/bar 2>&1 | _filter_test_dir
>  
> -# success, all done
> -status=0
> -exit
> +_exit 0
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

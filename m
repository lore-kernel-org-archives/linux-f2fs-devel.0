Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97134606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RLmc7VTv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d6hVByqd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E7Y5DIBh;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N22qDFAe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xZb/xuJnGaHkmW2IaMa50lp6Ghi7JX9AuI37+jGzFaU=; b=RLmc7VTv3+4kvXjVEItcN+yRn4
	qKsxIFbFeOgYu13na3ieypDUeNdCWX70Y2mG5WZRVHTyYu0MNsURn0hWZDPAU8RCJA73FQYDYkU7Z
	kQQGI/na9TbT47jLJrEuhlMppf0Jyo6M2sGqe7Xyw+TR/3pjQE3O6+W7Qj20TPanpwOs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZEU-000000003fL-18S1;
	Mon, 23 Nov 2026 18:57:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZES-000000003fD-1gd8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:57:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H93CB7j1oNhjdUYK0ZSNjTneR70X6EfbfNI+/55q5ew=; b=d6hVByqdwAEAAPcu8u7qdd+BaI
 yEJVHFVY9Kyjhwe5qXCo+SEFHIwoZjR62HzuPYqJZJBcaCSuQ/B7alPNB/yh0ddOxy6b5PmIRVZGp
 mRGjsfKwMDRgSxXEd16rp3HpaImE/ghD8o74GNtGcBdJPgJmzo11xwf5oGZ3KBo2X9R0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H93CB7j1oNhjdUYK0ZSNjTneR70X6EfbfNI+/55q5ew=; b=E7Y5DIBhuM3lmH61BPW0swmMRK
 bkyRxRHLKfGZCRMJPlb2k1vEAO9pcqN66fQVySC0mwg7/4sWZKqfUP4mYa8jvRBkFPFbRddjOH0PI
 HCEYLeXuaX8fZ22yqsZsqwi5/RokZ8M2w3/7umQ+lWNW4FHWgGLEE/zKiZZb8Ue0Y2GA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZEQ-000000003wP-4B4e
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:57:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8492540D60
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8FC1F000C0;
 Mon, 23 Nov 2026 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795460253;
 bh=H93CB7j1oNhjdUYK0ZSNjTneR70X6EfbfNI+/55q5ew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=N22qDFAebF8d4UjhzQWu2mMTYnWBxTYas5KtcaDCQSHOknLswE/0QUdWCR/N7nm9q
 FCixJs2Lqu3BoFr+eAWHuXBPfYLhKp101i6rFpZnKgWAn649RoakvGSQMWG7AErDaG
 G1Wn7Vqfd3Nx0lbQl1P0BvX69HH22fo7EOnHZC0OgMvQ7y0kUPZGKONNPA2psackpo
 RQ4r6QgHnAjZZoTYvOt1iXG+O1ri/Y67sdmwY/kiQq6OX5cha94200fdg6pUC6JGx1
 1o5UyvLCgLaUbkhdSlXYtD/Pd+DG6kpJwr0Ri56/bq7A4wBN+fDYCcSBxfxSTp2E+o
 kR57gbbDYyloQ==
Date: Tue, 24 Nov 2026 02:57:24 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSMZ6pYfpYH20bZ@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <40f9fa47341946da9edbe10498c3d8d789ce202f.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <40f9fa47341946da9edbe10498c3d8d789ce202f.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVZEQ-000000003wP-4B4e
Subject: Re: [f2fs-dev] [PATCH 15/21] fstests: verify exportfs file handles
 on cloned filesystems
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

On Tue, Oct 06, 2026 at 04:55:41PM +0800, Anand Jain wrote:
> Ensure that exportfs can correctly decode file handles on a cloned
> filesystem across a mount cycle, by file handles generated on a
> cloned device remain valid after mount cycle.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/generic/905     | 79 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/905.out |  2 ++
>  2 files changed, 81 insertions(+)
>  create mode 100644 tests/generic/905
>  create mode 100644 tests/generic/905.out
> 
> diff --git a/tests/generic/905 b/tests/generic/905
> new file mode 100644
> index 000000000000..d69c613110db
> --- /dev/null
> +++ b/tests/generic/905
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test No. 905
> +# Verify that file handles encoded on a cloned filesystem remain valid and
> +# resolvable via open_by_handle across a mount cycle and mount order swap.
> +
> +. ./common/preamble
> +
> +_begin_fstest auto quick exportfs tempfsid
> +
> +_require_test
> +_require_exportfs
> +_require_loop
> +_require_test_program "open_by_handle"
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	_unmount $mnt1 2>/dev/null
> +	_unmount $mnt2 2>/dev/null
> +	_destroy_cloned_loop_devs "${devs[@]}" 2> /dev/null
> +}
> +
> +# Create test dir and test files, encode file handles and store to tmp file
> +create_test_files()
> +{
> +	rm -rf $testdir
> +	mkdir -p $testdir
> +	$here/src/open_by_handle -cwp -o $tmp.handles_file $testdir $NUMFILES
> +}
> +
> +# Attempt to read and decode the saved file handles on the targeted mount point.
> +test_file_handles()
> +{
> +	local opt=$1
> +	local when=$2
> +
> +	echo test_file_handles after $when
> +	$here/src/open_by_handle $opt -i $tmp.handles_file $mnt2 $NUMFILES
> +}
> +
> +rm -rf $TEST_DIR/$seq 2>/dev/null
> +mkdir -p $TEST_DIR/$seq
> +# Setup base loop device and its clone
> +devs=()
> +_create_cloned_loop_devs devs
> +mnt1=$TEST_DIR/$seq/mnt1
> +mnt2=$TEST_DIR/$seq/mnt2
> +mkdir -p $mnt1
> +mkdir -p $mnt2
> +
> +# Mount both identical UUID filesystems simultaneously
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +NUMFILES=1
> +testdir=$mnt2/testdir
> +
> +# Decode file handles of files/dir after cycle mount
> +create_test_files
> +
> +# Cycle mounts and reverse initialization sequence to check if
> +# file handle lookups are okay
> +_unmount $mnt1
> +_unmount $mnt2
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +
> +# Verify file handles can still be resolved post-mount-cycle
> +test_file_handles -rp "cycle mount"
> +
> +_exit 0
> diff --git a/tests/generic/905.out b/tests/generic/905.out
> new file mode 100644
> index 000000000000..234f5ec35863
> --- /dev/null
> +++ b/tests/generic/905.out
> @@ -0,0 +1,2 @@
> +QA output created by 905
> +test_file_handles after cycle mount
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

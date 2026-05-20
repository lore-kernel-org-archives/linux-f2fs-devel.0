Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB09ECD4F3C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 May 2026 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29N+otIVv2oj1GWDx7G/haicF7v0AL07iPlbZfevtoo=; b=F4UNz375NoEFJkWuCG40pjRlRz
	ULX0m1h004ZEzTLmKxjlXH5GbsS/ldXxrZkfSDnBp5swCIwfD1D4XgFw/cIdi7O5balzaJesMc4oQ
	FlFmk6fu0L/OTOJ7SRpgdrX01yRrprOkXF5iChjXWU4nTMzb1l+MUvR521vWAUo6cvyw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPg2Z-0001KE-D3;
	Wed, 20 May 2026 12:28:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1wPg2X-0001K7-1B
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:28:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/w3xRDdSB1Oue9DDBq9k8Rn4urhWgVsSGxIhJfb9Q7g=; b=i2FQR7LmgIN0ppKlYVydnl+w8a
 +Y1Eww9SVK/p/uRazaAGKO3V6efHQK3R83+APzI1ibSJ0GOWq+rxY4lCuuiORDW8MPhDQM8nogL4G
 VRmVUJ4YEFHOQt98ar+jsuh73BHXIkG9eG0bgNDuI6pqG8gJo2Fz4aa5TfINSTtxkAVw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/w3xRDdSB1Oue9DDBq9k8Rn4urhWgVsSGxIhJfb9Q7g=; b=WMadoN9nzPKLt9VEP9/Z3L16Q2
 uPVvGTNKPpT7Ame+cC/+a4nHwoogisaNXCofrk/ymzaWXICGiLObI1XH0k6p4W9vKsCSI3nvrnvoX
 bVVQl2zFe4oebzgb29ToyA2w19C11TvYR1yL7qiLVBQ5mYJCUC7FYTsNn/9Dab+mptlk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPg2V-0006FW-3g for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:28:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34EFF436B0;
 Wed, 20 May 2026 12:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694541F000E9;
 Wed, 20 May 2026 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779280118;
 bh=/w3xRDdSB1Oue9DDBq9k8Rn4urhWgVsSGxIhJfb9Q7g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=U7AzNmR4ufuz8RzeqbLm4M+bR3KDu12MqbzJ4QvdnaQyABBdPqIMEM2XGOUvPnyOj
 uGT8FCdzduuKSjnYv9cu8F2uN3jl0j4uyBHMW6pYUSdeia17qcbFQ6YK+WHkI/OiXk
 q/4Nn1gEwIdsEVf9vLYPK6d8PtZ/zJqsniXGCztnbUvnS4amcytafs0f0osDD4+0ho
 XwlAfgQY4t3YsBI/ipQN3ZgDUd+yFfLcd+Nb7BRzldgqH70YjZMginVD+PwG6IaYFm
 PVsGaGrdvkNeveC8LjttzVjDCjc/+xs/6HeecDUZA4XLrVwBB2ji2EG1oXC0Z4Yni5
 rgpWNOO8CmgPg==
Date: Wed, 20 May 2026 20:28:29 +0800
To: Chao Yu <chao@kernel.org>
Message-ID: <ag2Rh-4_Tp082XXx@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
 jaegeuk@kernel.org, jprusakowski@google.com, joannechien@google.com, 
 linux-f2fs-devel@lists.sourceforge.net
References: <20260518101252.445214-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260518101252.445214-1-chao@kernel.org>
X-Headers-End: 1wPg2V-0006FW-3g
Subject: Re: [f2fs-dev] [PATCH] f2fs/025: test to do sanity check section
 type correctly in f2fs GC
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
Cc: joannechien@google.com, jaegeuk@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, May 18, 2026 at 06:12:52PM +0800, Chao Yu wrote:
> Without commit 520760b9f915 ("f2fs: optimize representative type determination
> in GC"), f2fs GC will report inconsistent segment type in large section issue,
> and then it will force to shutdown filesystem.
> 
> [  768.190903] F2FS-fs (loop51): Inconsistent segment (3) type [1, 0] in SIT and SSA
> 
> The reason is f2fs kernel will assume all segment type inside large section is
> the same, during GC it loads type from one segment and compare it to other
> segments' type, however due to recovery flow, the chosen segment may has zero
> valid blocks w/ different segment type, since the segment is invalid(free) one,
> it will never be migrated, so that we should not treat such state as abnormal
> condition.
> 
> This testcase is created to simulate above condition to see whether f2fs kernel
> module can handle it correctly
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/025     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/025.out |  2 ++
>  2 files changed, 90 insertions(+)
>  create mode 100644 tests/f2fs/025
>  create mode 100644 tests/f2fs/025.out
> 
> diff --git a/tests/f2fs/025 b/tests/f2fs/025
> new file mode 100644
> index 00000000..1eba7158
> --- /dev/null
> +++ b/tests/f2fs/025
> @@ -0,0 +1,88 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Chao Yu <chao@kernel.org>
> +#
> +# FS QA Test No. f2fs/025
> +#
> +# Check whether f2fs will encounter cp_error (Inconsistent segment type)
> +# when doing sanity check on type of segments inside large section during
> +# garbage collection.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_fixed_by_kernel_commit 520760b9f915 \
> +	"f2fs: optimize representative type determination in GC"
> +
> +. ./common/filter
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +_require_scratch
> +_require_xfs_io_command "pwrite"
> +_require_xfs_io_command "truncate"
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +_require_check_dmesg
> +
> +# Format with 96MB size and 2 segments per section
> +_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
> +
> +# Mount with mode=lfs
> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
> +
> +# Create files to fill whole filesystem, then segment type will be changed to node type
> +for ((i=0;i<5120;i++)) do
> +	touch $SCRATCH_MNT/$i >> $seqres.full 2>&1

5120 * 4k = 20MB

> +done
> +sync
> +
> +# Remove all files to create free(empty) node segments
> +rm -f $SCRATCH_MNT/*
> +sync
> +
> +# Allocate free space so that we have chance to reuse free(empty) node segments
> +$XFS_IO_PROG -f -c "pwrite -b 4k 0 1928k" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +sync
> +
> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +sync
> +
> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 8M" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 32K" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1

1928k + 16M + 16M + 8M + 32K ~= 40M

> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 2M" -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1

96M - 40M - 20M = 36M

I'm not a f2fs expert, I think you hope to (almost) fill the fs before this 2M
pwrite step. If so, I'm wondering can we ensure that other metadata takes ~36 MB
of space, thereby guaranteeing that this 2 MB write triggers the reuse of that
1928 KB segment (no matter with any MKFS_OPTIONS)?

Thanks,
Zorro

> +
> +# Shutdown the filesystem without checkpoint
> +$F2FS_IO_PROG shutdown 2 $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
> +
> +# Run urgent_gc mode to trigger garbage collection
> +dev_name=$(_short_dev $SCRATCH_DEV)
> +if [ -f /sys/fs/f2fs/$dev_name/gc_urgent ]; then
> +	echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
> +fi
> +
> +# Wait background GC thread to wake up to run and potentially encounter the inconsistency
> +sleep 5
> +
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +# Check whether the dmesg has the warning indicating the bug
> +_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
> +	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
> new file mode 100644
> index 00000000..3d70951e
> --- /dev/null
> +++ b/tests/f2fs/025.out
> @@ -0,0 +1,2 @@
> +QA output created by 025
> +Silence is golden
> -- 
> 2.49.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D22C43602
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hd9oMkKqbo39UN67zYAuXVuK54u3hhjuWw/5+RbAOYg=; b=lXAPvS0Onip0jzuyfo5qCJU1gL
	/3B1RQt7Hmf4DlylBiiuXHrzgrPWoePAv4g2SqGykHn7B8aovE2MUvn07v9DqnUMeBGlzaLje0WIn
	48hjJ9xpzwuudOPAf+56SA/PY1NYjqtBmzQba9hoNS/vQwCoZW9a+wCYfn3iuBMwaSIE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weyoL-0003bh-BX;
	Wed, 01 Jul 2026 17:33:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1weyoK-0003bW-Ft
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 17:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DT72m6PijCAONOaUhwmjfXMlmjpfNBh8evoXPnX3jsk=; b=AL/gCV3J+IemJp8v/wDVH9baFR
 u0167hDQFgc0p7zOQAzNpsVssJabo86tjAFdIjOKSpS/z105PYqAcHvpdK6UVKy9j0m8YWjWZONME
 mt69qRq+plRCFjG+AA6X9WN6mRmwEjTIituc9wwGy1qjTw0rZMVLQnp3Oq0y3aBbZcR0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DT72m6PijCAONOaUhwmjfXMlmjpfNBh8evoXPnX3jsk=; b=K//JDuv2nYr475n4aVSS+1FObP
 wbLNz9ElrVrmiJB998AGA4cuS/203whjK7I7c5fYA/x6JDRYf1Agc6+x9Z6dhZw8GEzny1E7xW3lu
 v+pBtR5gho1WmXkubnhsMbpQmw6rcm4qsv9K817O9gao1pCBEo61GWSHgkR6+he+IcKs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weyoK-0001Fg-5K for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 17:33:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 2B29541147;
 Wed,  1 Jul 2026 17:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BDEFF1F000E9;
 Wed,  1 Jul 2026 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782927195;
 bh=DT72m6PijCAONOaUhwmjfXMlmjpfNBh8evoXPnX3jsk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lw9nn/qLQ4Jc7ZVwBb+skja3MPB21ut1EmQrQpaW6bQk1dBTy3VMrs4pVxIky1sXS
 ea+HTBJwXzUCdQxnTe6xsFrAtZjNyOddMQft8OC9pCK47Aqks21U+m1mmA9Lg+eodn
 t/4u6QRC23xMGO5m8fD5fCPyCGQ2BVjmVIY9wg45Pl3tnnVJHzAJ27t7RubuXZmAeJ
 9786jE8nnWG0qu4Cii2c5Y3dgK+rw4BFqKojuon7gFRh5/XL7Zmnaos8ezZrRX+dzu
 ndEFFTPoANoOO/+78f4Nioxiy/eUccv9mDuxUhab0wD8Y3i8DeX6UnQxEhGBPvyM/P
 oBnkghFi+eKBg==
Date: Wed, 1 Jul 2026 10:33:14 -0700
To: Anand Jain <asj@kernel.org>
Message-ID: <20260701173314.GH6517@frogsfrogsfrogs>
References: <cover.1781694879.git.asj@kernel.org>
 <2ac5fb22fd6b51973d11082a1ee8fe354926c63c.1781694879.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2ac5fb22fd6b51973d11082a1ee8fe354926c63c.1781694879.git.asj@kernel.org>
X-Headers-End: 1weyoK-0001Fg-5K
Subject: Re: [f2fs-dev] [PATCH v7 06/11] fstests: verify f_fsid for cloned
 filesystems
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

On Wed, Jun 17, 2026 at 07:20:33PM +0800, Anand Jain wrote:
> Verify that the cloned filesystem provides an f_fsid that is persistent
> across mount cycles, yet unique from the original filesystem's f_fsid.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  tests/generic/802     | 64 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/802.out |  4 +++
>  2 files changed, 68 insertions(+)
>  create mode 100644 tests/generic/802
>  create mode 100644 tests/generic/802.out
> 
> diff --git a/tests/generic/802 b/tests/generic/802
> new file mode 100644
> index 000000000000..910807c11584
> --- /dev/null
> +++ b/tests/generic/802
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test 802
> +# Check that the cloned filesystem provides an f_fsid that is persistent
> +# across mount cycles if the block device maj:min remains unchanged.
> +
> +. ./common/preamble
> +
> +_begin_fstest auto quick mount clone
> +
> +_require_test
> +_require_block_device $TEST_DEV
> +_require_loop
> +
> +_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
> +	"btrfs: use on-disk uuid for s_uuid in temp_fsid mounts"
> +_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
> +	"btrfs: derive f_fsid from on-disk fsuuid and dev_t"
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	umount $mnt1 $mnt2 2>/dev/null
> +	_loop_image_destroy "${devs[@]}" 2> /dev/null
> +}
> +
> +# Setup base loop device and its clone
> +devs=()
> +_loop_image_create_clone devs
> +mkdir -p $TEST_DIR/$seq
> +mnt1=$TEST_DIR/$seq/mnt1
> +mnt2=$TEST_DIR/$seq/mnt2
> +mkdir -p $mnt1
> +mkdir -p $mnt2
> +
> +# Mount both filesystems simultaneously using mandatory clone mount options
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +# Capture baseline filesystem IDs for comparison
> +fsid_scratch=$(stat -f -c "%i" $mnt1)
> +fsid_clone=$(stat -f -c "%i" $mnt2)
> +
> +# Verify that the fsids remain stable after a mount cycle, even when the
> +# mount order is reversed.
> +echo "**** fsid after mount cycle ****"
> +_unmount $mnt1
> +_unmount $mnt2
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +
> +# Compare post mount-cycle values against the baseline
> +stat -f -c "%i" $mnt1 | sed -e "s/$fsid_scratch/FSID_SCRATCH/g"
> +stat -f -c "%i" $mnt2 | sed -e "s/$fsid_clone/FSID_CLONE/g"

This is where I continue getting stuck on this patchset -- fsid is so
poorly defined that I don't think the rest of these fsid tests make
sense at all.  Nobody mandates that fsid is persistent or stable across
remounts.  Nobody even mandates that two cloned filesystems don't have
the same fsid value.

The statfs manpage says:

"Nobody knows what f_fsid is supposed to contain (but see below)"

and then:

"The general idea is that f_fsid contains some random stuff such that
the pair (f_fsid,ino) uniquely determines a file."

Based on that very weak statement, at most it might make sense to check
that two separate and simultaneously mounted filesystems don't end up
with the same fsid just in case there *are* programs foolish enough to
use (fsid,ino) as a uniqueness check.

--D

> +
> +status=0
> +exit
> diff --git a/tests/generic/802.out b/tests/generic/802.out
> new file mode 100644
> index 000000000000..0202a9a2c108
> --- /dev/null
> +++ b/tests/generic/802.out
> @@ -0,0 +1,4 @@
> +QA output created by 802
> +**** fsid after mount cycle ****
> +FSID_SCRATCH
> +FSID_CLONE
> -- 
> 2.43.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

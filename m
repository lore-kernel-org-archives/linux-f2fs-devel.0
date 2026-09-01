Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529CCC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bzt3AxiE3WkI+qHl0dqJSfj4KA09Nc6/DqT8VuHO5OY=; b=B9ovt8l5pzMGtW0B+t+MnV676h
	YHK52eRikqWXn4C5iqioSW6slRp00f7BLnQAr+rsD6dUI0h7T3VWeUSIBuMe3Q3KwwjdNHuPoFZWB
	ddN9T2xbpzqJVr/rd5yaz5W9JTJrl/DZK8svlHIkzVPAQ7+3pwMEoxOYvv2LX5KVyz0c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1Tuj-0006Rt-0M;
	Tue, 01 Sep 2026 19:12:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1Tui-0006Rl-8k
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 19:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sMIegqMJrkzX9C9fgmacw7fJ5Kh0SLb0eEV7TbF42uA=; b=bLe/UmzLkA8BRHKOsUANF78mR2
 STxtFfhcEYEtLKxQih7TIndS4r2s0wkIDLfra4CSqBA4mM6ZRiw/yW59rWNBbMVUAynrcBYMoVm1y
 0M6J32h8fMqYBlhXff7Je0rapykLvWfDB/j6f9lNvo2x8OcNxf2OBwXiMGsLn0oBz2I0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sMIegqMJrkzX9C9fgmacw7fJ5Kh0SLb0eEV7TbF42uA=; b=Crf2Vkjo3sbSP+WEE487FYqsJM
 HwomrPG3KSJnWfr9R4r9KfNp9s6OuTz7m7fFKDGZSL3nj9LxLToD4yLEfkaU5jW+/oN7rIZlHPwaE
 xlGwGSdq3aR/gcZqnrFX3rOCv+LCLNTRL8QWNtCX9PralK+P/C1ZbMs3wxjyh6C/aKpw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1Tuh-0003T9-Hc for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 19:12:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B753460232
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 19:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389AF1F000E9;
 Tue,  1 Sep 2026 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788289969;
 bh=sMIegqMJrkzX9C9fgmacw7fJ5Kh0SLb0eEV7TbF42uA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BMM26e9anTVkORjuGbVltEI+EVaF1K99InI7KFBCCOB7jLGl3KrcxFbteHZmFLiQp
 V5XX/2xoqyxZIn6XtIKpdhu/g1NWVsLXl4zGFnuxemGJuhX5gSYIS3SOq3GdY9kbNv
 uelBKQzoOkCNWTuIHBuYbp3bJRXIbe6JFjLIva2dxOI3VgtcPYljJ2w0BLIgAGox63
 oc5KtZs2qToTrwGLHPJ8RxHuGoQpDDPTmmUe58VMSJ3639w9aXgseZId1jYcUU4fS8
 Qhsh/0Gg9eSfr7Cqg/I47fyADd3gN/JxrKADuS/lKC2wTylrr5w4RzkHdKvOvFw0UZ
 UrrcMPXn/jFAw==
Date: Wed, 2 Sep 2026 03:12:43 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <apchlvgfbKJDX1rO@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <0e530686fa2bfb9a4b8ec4596484a4fec6d849e4.1784949155.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0e530686fa2bfb9a4b8ec4596484a4fec6d849e4.1784949155.git.asj@kernel.org>
X-Headers-End: 1x1Tuh-0003T9-Hc
Subject: Re: [f2fs-dev] [PATCH v8 09/13] fstests: verify libblkid resolution
 of duplicate UUIDs
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

On Sat, Jul 25, 2026 at 03:39:06PM +0800, Anand Jain wrote:
> Verify how findmnt, df (libblkid) resolve device paths when multiple

I didn't find the `df` test part in this test case.

> block devices share the same FSUUID.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  tests/generic/803     | 72 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/803.out |  6 ++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 tests/generic/803
>  create mode 100644 tests/generic/803.out
> 
> diff --git a/tests/generic/803 b/tests/generic/803
> new file mode 100644
> index 000000000000..77901592366c
> --- /dev/null
> +++ b/tests/generic/803
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test 803
> +# Check if the mountinfo based findmnt would resolve to the common uuid
> +# as per the blkid (libblkid based).
> +
> +. ./common/preamble
> +. ./common/filter
> +
> +_begin_fstest auto quick mount clone
> +
> +_require_test
> +_require_block_device $TEST_DEV
> +_require_loop
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	umount $mnt1 $mnt2 2>/dev/null
> +	_loop_image_destroy "${devs[@]}" 2> /dev/null
> +}
> +
> +# Normalize pool devices and mount points names
> +filter_pool()
> +{
> +	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
> +	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
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
> +# Get the uuid from the source device
> +fsuuid=$(blkid -s UUID -o value ${devs[0]})
> +
> +# Mount both identical UUID filesystems simultaneously
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool

findmnt -n (or --noheadings) can be used here (and below) to avoid piping to
`tail -n +2`.

> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool

Same here

> +
> +# Btrfs assigned a random uuid for the clone fs before the fix.
> +# Cycle mounts and reverse the initialization (source and clone fs) order.
> +echo "**** mount cycle ****"
> +_unmount $mnt1
> +_unmount $mnt2
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +
> +findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool

Same here

> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool

Same here

> +
> +status=0
> +exit

_exit 0

> diff --git a/tests/generic/803.out b/tests/generic/803.out
> new file mode 100644
> index 000000000000..3a130c662430
> --- /dev/null
> +++ b/tests/generic/803.out
> @@ -0,0 +1,6 @@
> +QA output created by 803
> +DEV1 MNT1 FSUUID
> +DEV2 MNT2 FSUUID
> +**** mount cycle ****
> +DEV1 MNT1 FSUUID
> +DEV2 MNT2 FSUUID
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

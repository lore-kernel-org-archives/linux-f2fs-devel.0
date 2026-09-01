Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080CEC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AdlHY05+Hl57soM09HDOfY/O/du+xolsrdfOLwnGqo8=; b=hdZH8g6Nzi+AONnPw3C9OLBQE4
	LM3/TiA4FkCBNyMrPiE8ELfP6QdmRvYandp/8jVe4ebt1cqifWOg8uMpApNjcR6oZzvKtqfqpw8ua
	B4dc/gKGGGmsKa0s0CJRPFRAGym8yp9Hkdx53FXoL5IvmzEOO4We3AJxNtR1YfQsHXN0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1VRs-00005o-HU;
	Tue, 01 Sep 2026 20:51:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1VRr-00005h-Ho
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:51:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lf99BDB39f+iJE0gbCCCR6NEsjsfCktKqPLXvOUL2No=; b=Vb5lAs+Qj4sD68qRpgUDnN+8xF
 V8QVAYSEkSOrKXP2T8tJt4xzVoSbVir+++smtYVGb71lmpJy6/l0ThrW1ZPD5l98QUUM2lmYO+oJi
 RUIb4bk0myaA/3oBXq/YCuk19WGixYhjxiiiwKC3wxvgRh7XM1Mhq4QKWrwRgA2wtD38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lf99BDB39f+iJE0gbCCCR6NEsjsfCktKqPLXvOUL2No=; b=g6FXhorCOVmMqDfIHKDrSTPQqR
 hGsuf4iLmC9UDxh8M8kQs1ZsLCI1HuoF0dE+RkDSk4uQYElsvFTiuKgTh0KqF5KAisCbZZQIisIUy
 wTSyhmJpcIOl6Fl3PrAKzKdoJofvR122ijmTTse6u7uvPxulkr6QBb2ZJpf+4f/7c3YQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1VRq-0004ZG-U7 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:51:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 413C8600D9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 20:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50DF1F000E9;
 Tue,  1 Sep 2026 20:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788295869;
 bh=lf99BDB39f+iJE0gbCCCR6NEsjsfCktKqPLXvOUL2No=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TFwRo4Cygqknk8EhEiieRS9uGZhsIJ9Z22D3dH+5lsUXHJx8QmetrmnIJX8Q3y8GS
 YNFCZPGNjfM9YRlWexJwLj6D0rRzqZOGh+Kj4m/PSpX1N/zLd+GYZ14jxjeqv2LNYZ
 U/557rsOuvQWBhcgYlIhwhOpgYL1eHYgdgPIUEsoifR4xTq/Tc491zI5v6Dej/jrvk
 xOKarRl0NXzm2bv5iCDbkuXeqbj6WG8bLGUA9VTdxh6gbDXvrTZ4IrXYcVllrQUFv4
 zTFzdEtHGsiRxCK+orp9Cwjvkd/l8UWsaWSyEQTbLkwNqbZdAb8rwuc733S5fuCVU8
 CtWFJuYZK4qZg==
Date: Wed, 2 Sep 2026 04:51:02 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <apc5PMJFYtrUyG8U@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <905a961a3bb2ec345285f056053e3016ad3bef6e.1784949155.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <905a961a3bb2ec345285f056053e3016ad3bef6e.1784949155.git.asj@kernel.org>
X-Headers-End: 1x1VRq-0004ZG-U7
Subject: Re: [f2fs-dev] [PATCH v8 13/13] fstests: test UUID consistency for
 clones with metadata_uuid
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

On Sat, Jul 25, 2026 at 03:39:10PM +0800, Anand Jain wrote:
> Btrfs and xfs uses the metadata_uuid superblock feature to change the
> on-disk UUID without rewriting every block header. This patch adds a
> sanity check to ensure UUID consistency when a filesystem with
> metadata_uuid enabled is cloned.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  tests/generic/806     | 74 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/806.out |  6 ++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 tests/generic/806
>  create mode 100644 tests/generic/806.out
> 
> diff --git a/tests/generic/806 b/tests/generic/806
> new file mode 100644
> index 000000000000..6d3166491006
> --- /dev/null
> +++ b/tests/generic/806
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test 806
> +#
> +# Verify that the cloned filesystem UUID remains consistent, even when the
> +# `metadata_uuid` feature is enabled.
> +#
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
> +filter_pool()
> +{
> +	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
> +	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
> +}
> +
> +# Create base loop device and its clone, applying the metadata_uuid tuning
> +# callback to the base filesystem before the copy occurs.
> +devs=()
> +_loop_image_create_clone devs _change_metadata_uuid

Should we have and run a _require_metadata_uuid before changing it?
As I know, btrfs can do `_require_btrfs_fs_feature metadata_uuid`.

> +mkdir -p $TEST_DIR/$seq
> +mnt1=$TEST_DIR/$seq/mnt1
> +mnt2=$TEST_DIR/$seq/mnt2
> +mkdir -p $mnt1
> +mkdir -p $mnt2
> +
> +# Get the uuid from the source device
> +fsuuid=$(blkid -s UUID -o value ${devs[0]})
> +
> +# Mount both clone and baseline
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> +
> +# Cycle mounts and reverse the initialization order to ensure UUID tracking
> +# doesn't mismatch or flip when metadata_uuid optimization is active.
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
> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> +
> +status=0
> +exit
> diff --git a/tests/generic/806.out b/tests/generic/806.out
> new file mode 100644
> index 000000000000..918f422ecddf
> --- /dev/null
> +++ b/tests/generic/806.out
> @@ -0,0 +1,6 @@
> +QA output created by 806
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

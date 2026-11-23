Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC65606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XWBmrqXv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dVWN58Hi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i49H3HOt;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJSDmHbG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dsQP1KevzjcvEc8HmZawzSZmtKCxHEz3MMoQxd+XxLc=; b=XWBmrqXvEGd/0lqH6NdxwFR024
	lVH2BE+nVAa9QRex2RR+urNIslRy7eIHlHrjP23eaY/QzDEPY4HOVD7ZHBdwfcFKkeJWBrLunrzSc
	99rRRfSVt7DFccB+hSBTTsjJkjiUPkzt41qfDIrrZYl15wHGPvZDgsgycvyaBO+svNxQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZHP-0000000046W-2VEJ;
	Mon, 23 Nov 2026 19:00:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZGx-00000000468-3PFR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 19:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=emheEOQkou06XepSqyP4hmHa7Pz+4doN2S3r24jNc0g=; b=dVWN58HiL5vX2w1dVCz5cm4WKe
 O8SU6leMdyz5UVoivWVb3tMVCfM7LKfpViBJ77xtNoEC5G4AsVdXfP9Pb2BpiYkuIbi8x2iKjnaSd
 q+r4eN/M7KhW5KygxXBtflrwRBSwrCfLkMCJRdWjlXumdfrBTN1G5oZZn4MPVg9kSYo0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=emheEOQkou06XepSqyP4hmHa7Pz+4doN2S3r24jNc0g=; b=i49H3HOtnP2AFS446eBYHrG5lj
 Up0SgBskZq+vLBhZjfvD046VWhnA2n/s3vMMiNZlnH8pseXQO3RgUkyYuIy5ycP/8W2w8SCqP036m
 6/55LnxElC1h0zFoAR/Mk+RO1oWZbwChSUDdv3GAALuQc3kU5VFxFi4R3KJ/We9/t/Cc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZGx-000000004FX-0yuN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 19:00:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3F32411A9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 19:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DD41F000C4;
 Mon, 23 Nov 2026 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795460409;
 bh=emheEOQkou06XepSqyP4hmHa7Pz+4doN2S3r24jNc0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SJSDmHbG2GG5RavcVePuZOUeTweTxW4Loxe1K3eoNchxHON7lkheWMG3wBv0NBkC0
 XGvrIQRuuTRn5/EPdLixBphkBezSw8TLAq9zeQNoAWfIOiAUemIqM4EefzHp8BUwgz
 di658A5HtzYa+yDcjqePlVIcI/9aY8X2odPXqzP7iQTGXw+F8ePdr0WGWQsbm+3xxw
 1FwXL69l/K3ocVKvLbkwvs13ij2TnIV94GldpEJmCO14xXiVC7C0TlCdaWjWaoLrg/
 8fCXMo/o8JsjDErxaCdZHS2Vg0b1lugOBRTUMTx+tgfyU0GrO/wicR7/jwGohzWXS2
 OBHWDz/hQSBiQ==
Date: Tue, 24 Nov 2026 03:00:01 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSM_yAiZm9rIFdG@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <97ba190c96d3fa545404d2c2f489d34f8f9466e9.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <97ba190c96d3fa545404d2c2f489d34f8f9466e9.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVZGx-000000004FX-0yuN
Subject: Re: [f2fs-dev] [PATCH 18/21] fstests: test UUID consistency for
 clones with metadata_uuid
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

On Tue, Oct 06, 2026 at 04:55:44PM +0800, Anand Jain wrote:
> Btrfs and xfs uses the metadata_uuid superblock feature to change the
> on-disk UUID without rewriting every block header. This patch adds a
> sanity check to ensure UUID consistency when a filesystem with
> metadata_uuid enabled is cloned.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---



>  tests/generic/906     | 74 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/906.out |  6 ++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 tests/generic/906
>  create mode 100644 tests/generic/906.out
> 
> diff --git a/tests/generic/906 b/tests/generic/906
> new file mode 100644
> index 000000000000..99516f18aa39
> --- /dev/null
> +++ b/tests/generic/906
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test No. 906
> +#
> +# Verify that the cloned filesystem UUID remains consistent, even when the
> +# `metadata_uuid` feature is enabled.
> +#
> +
> +. ./common/preamble
> +. ./common/filter
> +
> +_begin_fstest auto quick mount tempfsid
> +
> +_require_test
> +_require_loop
> +_require_metadata_uuid
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	umount $mnt1 $mnt2 2>/dev/null

  _unmount

> +	_destroy_cloned_loop_devs "${devs[@]}" 2> /dev/null
> +}
> +
> +filter_pool()
> +{
> +	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
> +	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
> +}
> +
> +rm -rf $TEST_DIR/$seq 2>/dev/null
> +mkdir -p $TEST_DIR/$seq
> +# Create base loop device and its clone, applying the metadata_uuid tuning
> +# callback to the base filesystem before the copy occurs.
> +devs=()
> +_create_cloned_loop_devs devs _change_metadata_uuid
> +mnt1=$TEST_DIR/$seq/mnt1
> +mnt2=$TEST_DIR/$seq/mnt2
> +mkdir -p $mnt1
> +mkdir -p $mnt2
> +
> +# Get the uuid from the source device
> +fsuuid=$(blkid -s UUID -o value ${devs[0]})
> +
> +# Mount both clone and baseline
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
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
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +
> +findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> +
> +_exit 0
> diff --git a/tests/generic/906.out b/tests/generic/906.out
> new file mode 100644
> index 000000000000..b484c86d8e7f
> --- /dev/null
> +++ b/tests/generic/906.out
> @@ -0,0 +1,6 @@
> +QA output created by 906
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

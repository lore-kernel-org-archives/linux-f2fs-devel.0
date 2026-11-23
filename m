Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA92C606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z78QaQRs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OOzO15/t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dtlPH7qj;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOmWzehn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=e1qURIGT0UVCeIrhZMPZl58ksVvmJTAXlmbvGRPsZbk=; b=Z78QaQRswJ2LOCI0kXTvd7uLCR
	wkJg1x2lGTXg8EufHAx5YO3F8JX0r979bL0o4ya1q0nQOhZZ1lJXsQNsEfFBArFUMt/VDIXfRcz20
	g2lTTe8CNOyqENixfGwsr4ni6kUTpHCOlS5sV0V1IM80zBdJMsa/XMl9acECKfFd9kSQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZ7S-0000000033x-2OTk;
	Mon, 23 Nov 2026 18:50:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZ7Q-0000000033p-24BI
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:50:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mf06FWxHhnhiAGhq4W+H/SgH1QQ43askODqmccvcZiQ=; b=OOzO15/t9KiE4ajJar6/EU0S1I
 BqQhROOV6LorfP5a3bXz8bMybyOwxDhXc8+0Wm4bnqkOCnatg9egTi/CzHmjW9Rzfj1q3oh5Vpo+W
 +NkWZY/GYtdQt671GHDHaz47eIlcbwTfw9KiBlCAEHKbEBCDF8guV0gmWDi4w22xNP48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mf06FWxHhnhiAGhq4W+H/SgH1QQ43askODqmccvcZiQ=; b=dtlPH7qjylhNWV/Zw9FV/qA8db
 ckZ0Y490MdqZpVsEjhzAC0++/4Ggv+1Rjl5GPKCVpHg1eLPGxI/D76MJtoS1zCwVvnYos1Ev73F+k
 lh14hA6Z5ELK3gyVNLUrOKFj/qjSmR2eefSc8kqJIn6UjWcLiFc37MlkhLdI5jl9rH3Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZ7N-0000000041u-326u
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:50:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5DFF0447D7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84A31F000D0;
 Mon, 23 Nov 2026 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795459815;
 bh=Mf06FWxHhnhiAGhq4W+H/SgH1QQ43askODqmccvcZiQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bOmWzehndH0k1dcnMDGz9vKpHEArNWA4J9L/qVTGnNw+pcoij5M3Y1Grt7yBxz91L
 wXYO67R9ZEzwXzaWRrT7K/jUOK7Jd8SFlYltyIbOllUb5Q6xriuM9fIwmkX77cBHdT
 EiARmq2a1q24rfG8V0eNkrBSo8NZAU9oDZIAX1yzDlHc85SmMq25gDmPUWFYRmdX2V
 UnOVWZmdQW2R7IU+AQTF+yp+EHPHiiYpomaFntvlFVYexJTPbaLarAGk/tjSfv9gqX
 +w2LxXSC2ZNALMnxzjDfkVJaAyjFQAvik5kesG2UhQk1J3R2gZV5v0IwakHOodmG10
 GSBDdoNhSDxtg==
Date: Tue, 24 Nov 2026 02:50:06 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSKKSvBRMrcFfcR@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <819a40991baec14ff589da95f3e68af91c33fdf1.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <819a40991baec14ff589da95f3e68af91c33fdf1.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVZ7N-0000000041u-326u
Subject: Re: [f2fs-dev] [PATCH 12/21] fstests: verify libblkid resolution of
 duplicate UUIDs
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

On Tue, Oct 06, 2026 at 04:55:38PM +0800, Anand Jain wrote:
> Verify how findmnt, df (libblkid) resolve device paths when multiple
> block devices share the same FSUUID.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  tests/generic/903     | 71 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/903.out |  6 ++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 tests/generic/903
>  create mode 100644 tests/generic/903.out
> 
> diff --git a/tests/generic/903 b/tests/generic/903
> new file mode 100644
> index 000000000000..d8aeba691fd4
> --- /dev/null
> +++ b/tests/generic/903
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test No. 903
> +# Check if the mountinfo based findmnt would resolve to the common uuid
> +# as per the blkid (libblkid based).
> +
> +. ./common/preamble
> +. ./common/filter
> +
> +_begin_fstest auto quick mount tempfsid
> +
> +_require_test
> +_require_loop
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	umount $mnt1 $mnt2 2>/dev/null
    ^^^^^^
   _unmount

> +	_destroy_cloned_loop_devs "${devs[@]}" 2> /dev/null
> +}
> +
> +# Normalize pool devices and mount points names
> +filter_pool()
> +{
> +	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
> +	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
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
> +# Get the uuid from the source device
> +fsuuid=$(blkid -s UUID -o value ${devs[0]})
> +
> +# Mount both identical UUID filesystems simultaneously
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +findmnt --noheadings -o SOURCE,TARGET,UUID "${devs[0]}" | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> +findmnt --noheadings -o SOURCE,TARGET,UUID "${devs[1]}" | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> +
> +# Btrfs assigned a random uuid for the clone fs before the fix.
> +# Cycle mounts and reverse the initialization (source and clone fs) order.
> +echo "**** mount cycle ****"
> +_unmount $mnt1
> +_unmount $mnt2
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +
> +findmnt --noheadings -o SOURCE,TARGET,UUID "${devs[0]}" | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> +findmnt --noheadings -o SOURCE,TARGET,UUID "${devs[1]}" | \
> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> +
> +_exit 0
> diff --git a/tests/generic/903.out b/tests/generic/903.out
> new file mode 100644
> index 000000000000..7683506e1c94
> --- /dev/null
> +++ b/tests/generic/903.out
> @@ -0,0 +1,6 @@
> +QA output created by 903
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

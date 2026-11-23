Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC0606A332
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K7fL6xUx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=U2PfNe3d;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VNXyoEFg;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bo4+HgPQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=otsLIzngWuHE2d/mh/MDYsBb3Cik2o+13l7iZIeT28I=; b=K7fL6xUxInXWRk4f0tft5T2WkS
	0dl9HjEIiugTxvt0Geh+IKtA3rUwC385af2oYv+M+YTjETWZjo2sOd05ql5gft3cJb9NkyXcdRuMc
	tjD4IWSvcN2C7uFBhmZmnnCU16rn3Djf+Y3DqIOYsV1olBA571aTKt+xqlZ+TJFGaKrM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZDR-000000002No-1E38;
	Mon, 23 Nov 2026 18:56:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZDP-000000002Nh-3ZxM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:56:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W843qhYFyVrdU+PtZ2yKDlnLUyTuEyPwzJ4NhBbmx9g=; b=U2PfNe3d+DRzTYLLBIinFkSC2O
 dvKlBwIjjf42mPOs1TwRHf6LL8u8eTXbLkBWw/sdD3s/TTbbzizGn4c4WJNighWd1e+T9uBd8IsEF
 mPWLXMvYk0ZRuq/H86orpfArpOTbMqgnf/CGB7Im+69y0JS+4/sAVxh6MoUiapVRZkfM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W843qhYFyVrdU+PtZ2yKDlnLUyTuEyPwzJ4NhBbmx9g=; b=VNXyoEFge3wUvIM6TC8+vFccw5
 MUzCzrVJ39+EMwTYPLRT3zJc2jtlD4uCGGShyZ9jfryUKIpUlOn+EPPuyYz51aFQpigDyYIysTlrS
 THFQ6P/6QCk+MUy9k/FROTvkntwtHqRK2twU8JexpuSCpgtaarQd8EbJRuXnvGh6+9IQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZDO-0000000049d-1pDP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:56:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D23606240F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CEA1F000CA;
 Mon, 23 Nov 2026 18:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795460188;
 bh=W843qhYFyVrdU+PtZ2yKDlnLUyTuEyPwzJ4NhBbmx9g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Bo4+HgPQ2bW4OmWwC5qp1hehI5W6L0H1BvsP+nUaw4np6xYqVpvr7ke+jJdQcvmt4
 LcmAGQ38zwZNlImDI6gRNoeKurokwIL9IN10OXq656UWcpf+XJ/XpRzWR05Zjh1yev
 GxLtclDcGg7/nXOXbJCxjOLO9qeyx9S41n5v092uoAn0ErIWbdDRVSztqcSysc8vwh
 twYJd4H9af4ECwIIk2WRgpRJuVF9sOXpiRxHo5PipNrIYt+0itDSV7Rfo84EaNY6D/
 gmHqEolg/hX4sX29l73g8qpUaj52GG/NuJchi0wy1N06oZ8YNvQAgkFi/XXEloL88B
 6bGhqAYfzMvPQ==
Date: Tue, 24 Nov 2026 02:56:19 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSK8y1srBdq2eds@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <ed4b48e156ccad10cff02f17ece3c624cc9dd749.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ed4b48e156ccad10cff02f17ece3c624cc9dd749.1791272793.git.asj@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVZDO-0000000049d-1pDP
Subject: Re: [f2fs-dev] [PATCH 14/21] fstests: verify IMA isolation on
 cloned filesystems
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

On Tue, Oct 06, 2026 at 04:55:40PM +0800, Anand Jain wrote:
> Add testcase to verify IMA measurement isolation when multiple devices
> share the same FSUUID.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Regarding this IMA test, I still have some concerns about the fact that it
modifies system settings irreversibly. If you want to get the rest of this
patchset merged faster, I suggest splitting this patch (along with the
previous patch it depends on) out of the series, and sending this test case
separately for further review once the main patchset is merged.

This will also help speed up the merging of the rest of this patchset :)

Thanks,
Zorro

>  tests/generic/904     | 113 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/904.out |  10 ++++
>  2 files changed, 123 insertions(+)
>  create mode 100644 tests/generic/904
>  create mode 100644 tests/generic/904.out
> 
> diff --git a/tests/generic/904 b/tests/generic/904
> new file mode 100644
> index 000000000000..d8412d0bc402
> --- /dev/null
> +++ b/tests/generic/904
> @@ -0,0 +1,113 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test No. 904
> +# Verify IMA isolation on cloned filesystems:
> +# . Mount two devices sharing the same FSUUID (cloned).
> +# . Apply an IMA policy to measure files based on that FSUUID.
> +# . Create unique files on each mount point to trigger measurements.
> +# . Confirm the IMA log correctly attributes events to the respective mounts.
> +
> +. ./common/preamble
> +. ./common/filter
> +
> +_begin_fstest tempfsid
> +
> +_require_test
> +_require_loop
> +_require_security_ima
> +
> +_fixed_by_fs_commit btrfs df84f6c77377 \
> +	"btrfs: use on-disk uuid for s_uuid in temp_fsid mounts"
> +_fixed_by_fs_commit btrfs c2a74ed0494c \
> +	"btrfs: derive f_fsid from on-disk fsuuid and dev_t"
> +_fixed_by_fs_commit btrfs 72de4807ba84 \
> +	"btrfs: derive f_fsid with dev_t only when temp_fsid is active"
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
> +# Normalize device names and mount points
> +filter_pool()
> +{
> +	sed -e "s|${devs[0]}|DEV1|g" -e "s|$mnt1|MNT1|g" \
> +	    -e "s|${devs[1]}|DEV2|g" -e "s|$mnt2|MNT2|g" | _filter_spaces
> +}
> +
> +# Core helper to set IMA policy and check measurement logs
> +do_ima()
> +{
> +	local ima_policy="/sys/kernel/security/ima/policy"
> +	local ima_log="/sys/kernel/security/ima/ascii_runtime_measurements"
> +	local fsuuid
> +	local mnt=$1
> +	local enable=$2
> +
> +	# Since the in-memory IMA audit log is only cleared upon reboot,
> +	# use unique random filenames to avoid log collisions.
> +	local foofile=$(mktemp --dry-run foobar_XXXXX)
> +
> +	echo $mnt $enable | filter_pool
> +
> +	fsuuid=$(blkid -s UUID -o value ${devs[0]})
> +
> +	# Load IMA policy to measure file access specifically for this
> +	# filesystem UUID.
> +	if [[ $enable -eq 1 ]]; then
> +		echo "measure func=FILE_CHECK fsuuid=$fsuuid" > "$ima_policy" || \
> +			_fail "Policy rejected"
> +	fi
> +
> +	# Create a file to trigger measurement and verify its entry in
> +	# the IMA log.
> +	echo "test_data" > $mnt/$foofile
> +
> +	# IMA log extract
> +	grep $foofile "$ima_log" | awk '{ print $5 }' | filter_pool | \
> +						sed "s/$foofile/FOOBAR_FILE/"
> +
> +	echo "dbg: $mnt $fsuuid $foofile" >> $seqres.full
> +	tail -1 "$ima_log" >> $seqres.full
> +	echo >> $seqres.full
> +}
> +
> +# Core helper to set IMA policy and check measurement logs
> +
> +rm -rf $TEST_DIR/$seq 2>/dev/null
> +mkdir -p $TEST_DIR/$seq
> +
> +# Initialize loop base and cloned instances
> +devs=()
> +_create_cloned_loop_devs devs
> +mnt1=$TEST_DIR/$seq/mnt1
> +mnt2=$TEST_DIR/$seq/mnt2
> +mkdir -p $mnt1
> +mkdir -p $mnt2
> +
> +# Concurrently mount both clones
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +#  IMA response on baseline and clone configuration
> +do_ima $mnt1 1
> +do_ima $mnt2 0
> +
> +# Cycle mount on the second device.
> +echo mount cycle
> +_unmount $mnt2
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +do_ima $mnt1 0
> +do_ima $mnt2 0
> +
> +_exit 0
> diff --git a/tests/generic/904.out b/tests/generic/904.out
> new file mode 100644
> index 000000000000..22340f236a45
> --- /dev/null
> +++ b/tests/generic/904.out
> @@ -0,0 +1,10 @@
> +QA output created by 904
> +MNT1 1
> +MNT1/FOOBAR_FILE
> +MNT2 0
> +MNT2/FOOBAR_FILE
> +mount cycle
> +MNT1 0
> +MNT1/FOOBAR_FILE
> +MNT2 0
> +MNT2/FOOBAR_FILE
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

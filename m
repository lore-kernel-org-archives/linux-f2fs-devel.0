Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE42C98332
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XNEqbsgQxQdZ5gi3PpDJU4p2/R3Psv6RKkvB+eM1HzA=; b=YTVDZujV64j9n9sT7GaYBww277
	ivV+jptwXA4B4q1BBPlUViy0rFGRfeQcT2Jwb5k5UjM2gRBZU87cAz66SmvEJlu1XPbdwovgXa9H5
	q5mZ+B7hWYG+VSWLWIXtgd0A+joFBinHvTPCTqN0gdAO5iDaXyvWJ43U5cAVF4DJit1U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xAqSQ-0000LB-9t;
	Sun, 27 Sep 2026 15:06:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1xAqSO-0000L1-W2
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Sep 2026 15:06:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hRe0FLP4Z/GQs9oxTcORN2hCNFjQ7djxlHIhDcwiwKA=; b=PyrbHwLNWQ+W7IHI3/owT/qMAy
 jxvsnxOOBaIkvxopdI66Ma9y603MaJG3PcoDwOqcPI5M5cM4ebOxNjqO7rHW0J9lEUcuPVSK9CbdX
 OYn4j8w1ezNxEM4GgonMlG/Y07nXJsGGnUdpHkFHep91oXMUHWWj1STQHR1Q7hrv8Vtw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hRe0FLP4Z/GQs9oxTcORN2hCNFjQ7djxlHIhDcwiwKA=; b=I7NK++V2/0x4zAFGulbaZSnWMb
 t9Dxca7JUjcRZQKWy8HMTe6be+fNZplvRCmpmZvRZI+UxugbKcXfKxx6UkU5MdL+zttbEESVRxFpJ
 gPx0viMKiQ2XZM1t432JfEWkxxW2KU6979c6CtIqhHxxm1oB0+AYJG5rdtvy+UbOvsLo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xAqSP-00051a-0J for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Sep 2026 15:06:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id 57A9460AAE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 15:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 01F201F000FF;
 Sun, 27 Sep 2026 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790521579;
 bh=hRe0FLP4Z/GQs9oxTcORN2hCNFjQ7djxlHIhDcwiwKA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ma1cAF5HNGtcWmhf6z1+cEN3WONC9jYnw2/c46P6f3McV5+RPy+sI7zQ0pOkco8iy
 QcUOWdKmBgcEnKBNdPjDP5k/iVEPhdPKwReKmwlx32PDdpaCM9CGVUdiF7bwhrB+uf
 +804YkhJhf9NPEkvtlPSPLk909iUPr+Jlseq/RYF7frwr/WL8uLmmqnYbaymb2B7o5
 SHL37NA71QxgIy/RSkB/sgfOso9KbEZ+JRkJRnFiVAGiTGZBO6u/39ZFalLDABtNuH
 0pII3eFMT2yx2vZ+LbKVPG0xyNHEhGGK/TYfbZfSPZehdOrBOH6SOMlwyl1LG/Capr
 fiSW1zS/+0BSw==
Date: Sun, 27 Sep 2026 08:06:18 -0700
To: Anand Suveer Jain <asj@kernel.org>
Message-ID: <20260927150618.GZ6253@frogsfrogsfrogs>
References: <cover.1784949154.git.asj@kernel.org>
 <905a961a3bb2ec345285f056053e3016ad3bef6e.1784949155.git.asj@kernel.org>
 <apc5PMJFYtrUyG8U@zlang-mailbox>
 <ea5b61d4-0cba-4afc-b5e0-8720d4717872@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea5b61d4-0cba-4afc-b5e0-8720d4717872@kernel.org>
X-Headers-End: 1xAqSP-00051a-0J
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Sep 27, 2026 at 12:41:46PM +0800, Anand Suveer Jain wrote:
> On 2/9/26 04:51, Zorro Lang wrote:
> > On Sat, Jul 25, 2026 at 03:39:10PM +0800, Anand Jain wrote:
> >> Btrfs and xfs uses the metadata_uuid superblock feature to change the
> >> on-disk UUID without rewriting every block header. This patch adds a
> >> sanity check to ensure UUID consistency when a filesystem with
> >> metadata_uuid enabled is cloned.
> >>
> >> Signed-off-by: Anand Jain <asj@kernel.org>
> >> ---
> >>  tests/generic/806     | 74 +++++++++++++++++++++++++++++++++++++++++++
> >>  tests/generic/806.out |  6 ++++
> >>  2 files changed, 80 insertions(+)
> >>  create mode 100644 tests/generic/806
> >>  create mode 100644 tests/generic/806.out
> >>
> >> diff --git a/tests/generic/806 b/tests/generic/806
> >> new file mode 100644
> >> index 000000000000..6d3166491006
> >> --- /dev/null
> >> +++ b/tests/generic/806
> >> @@ -0,0 +1,74 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> >> +#
> >> +# FS QA Test 806
> >> +#
> >> +# Verify that the cloned filesystem UUID remains consistent, even when the
> >> +# `metadata_uuid` feature is enabled.
> >> +#
> >> +
> >> +. ./common/preamble
> >> +. ./common/filter
> >> +
> >> +_begin_fstest auto quick mount clone
> >> +
> >> +_require_test
> >> +_require_block_device $TEST_DEV
> >> +_require_loop
> >> +
> >> +_cleanup()
> >> +{
> >> +	cd /
> >> +	rm -r -f $tmp.*
> >> +	umount $mnt1 $mnt2 2>/dev/null
> >> +	_loop_image_destroy "${devs[@]}" 2> /dev/null
> >> +}
> >> +
> >> +filter_pool()
> >> +{
> >> +	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
> >> +	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
> >> +}
> >> +
> 
> 
> >> +# Create base loop device and its clone, applying the metadata_uuid tuning
> >> +# callback to the base filesystem before the copy occurs.
> >> +devs=()
> >> +_loop_image_create_clone devs _change_metadata_uuid
> > 
> > Should we have and run a _require_metadata_uuid before changing it?
> > As I know, btrfs can do `_require_btrfs_fs_feature metadata_uuid`.
> > 
> 
> _require_metadata_uuid() is better than doing the same thing within
> _change_metadata_uuid(). Now _change_metadata_uuid() calls
> _require_metadata_uuid(), as shown below.
> 
> 
> _require_metdata_uuid()
> {
>         case $FSTYP in
>         xfs)
>                 _require_command "$XFS_ADMIN_PROG" "xfs_admin"

The presence of xfs_admin doesn't guarantee metauuid support on xfs;
the script predates the creation of that feature flag + cli args.

--D

>                 ;;
>         btrfs)
>                 _require_btrfs_fs_feature "metadata_uuid"
>                 _require_command "$BTRFS_TUNE_PROG" "btrfstune"
>                 ;;
>         *)
>                 _notrun "Require filesystem with metadata_uuid feature"
>                 ;;
>         esac
> }
> 
> 
> _change_metadata_uuid()
> {
>         local dev=$1
> 
>         _require_metdata_uuid
> 
>         case $FSTYP in
>         xfs)
>                 $XFS_ADMIN_PROG -U generate $dev >> $seqres.full
>                 ;;
>         btrfs)
>                 $BTRFS_TUNE_PROG -m $dev
>                 ;;
>         esac
> }
> 
> 
> 
> >> +mkdir -p $TEST_DIR/$seq
> >> +mnt1=$TEST_DIR/$seq/mnt1
> >> +mnt2=$TEST_DIR/$seq/mnt2
> >> +mkdir -p $mnt1
> >> +mkdir -p $mnt2
> >> +
> >> +# Get the uuid from the source device
> >> +fsuuid=$(blkid -s UUID -o value ${devs[0]})
> >> +
> >> +# Mount both clone and baseline
> >> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
> >> +						_fail "Failed to mount dev1"
> >> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> >> +						_fail "Failed to mount dev2"
> >> +
> >> +findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
> >> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> >> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
> >> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> >> +
> >> +# Cycle mounts and reverse the initialization order to ensure UUID tracking
> >> +# doesn't mismatch or flip when metadata_uuid optimization is active.
> >> +echo "**** mount cycle ****"
> >> +_unmount $mnt1
> >> +_unmount $mnt2
> >> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> >> +						_fail "Failed to mount dev2"
> >> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
> >> +						_fail "Failed to mount dev1"
> >> +
> >> +findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
> >> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> >> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
> >> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> >> +
> >> +status=0
> >> +exit
> >> diff --git a/tests/generic/806.out b/tests/generic/806.out
> >> new file mode 100644
> >> index 000000000000..918f422ecddf
> >> --- /dev/null
> >> +++ b/tests/generic/806.out
> >> @@ -0,0 +1,6 @@
> >> +QA output created by 806
> >> +DEV1 MNT1 FSUUID
> >> +DEV2 MNT2 FSUUID
> >> +**** mount cycle ****
> >> +DEV1 MNT1 FSUUID
> >> +DEV2 MNT2 FSUUID
> >> -- 
> >> 2.43.0
> >>
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53A3C624D0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+h9aCIspQfEGQdcthO39+MwvlH0/bZ7AfRuYEUpw/GU=; b=K4Hip0WiqABvwGxK2DV5mcef6e
	Hedp9OikkLFlbDETYY33UDJ4klQNBJtifqneyFcXndV0VOD66DWNzm6KYTSsASqIbxnHkC+OtL3vA
	PrGXMheyeTfN5beIbUbyTvH7CWlfPUO3rv2BeqVAohhIHqMrvfoBp3LVpSQZT/e+xad4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1T8l-00088Q-BU;
	Tue, 01 Sep 2026 18:23:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1T8j-00088J-9L
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 18:23:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YWNLINKhjPJWLv/lBwmEZnXi8vQ2jRvujbGQ2x962u4=; b=GNKTaZhkwIoGNyLe+KZeemTfrQ
 2C9Ar/LyUFrUysYwiB8SWw0645jdp9H71Br7sWaTs/QUYye93utbCimdg0fO8cxkVl8cwEHUvE5Sr
 s/m/N8ccKLPt5LhgYRg7Gy33KA0x5Xx6BW/A9600TwgHZ4M79MUgb1UAAY23a8fHUuIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YWNLINKhjPJWLv/lBwmEZnXi8vQ2jRvujbGQ2x962u4=; b=NQ3MUItLY/WS0vpoIUBQxgfH4D
 VW4bM4cdUmV0p66Gm4Xj5qY2k4IIMh8BNQUQ8ODMVPaYBQ4fjLRxz+g/y7DaxzTL1YeFa1/kM6bTC
 kWtvr9pmIewFxcSsFVdEo6AwWbI82hrH5JQgNK/eXazmi7tKIOojkJBsoh2XcuUl4RRA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1T8d-00014n-UP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 18:23:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5131C600D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 18:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A872E1F000E9;
 Tue,  1 Sep 2026 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788286990;
 bh=YWNLINKhjPJWLv/lBwmEZnXi8vQ2jRvujbGQ2x962u4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cgo/r/NGsnwevb1/ngCmGeIDbqZ0YPPCNiMWyLr20nCNrP3mJFV3QxwrZRLGjAamH
 zK6teivQpmEjthIjm2OoS8PsIYuxdKOpubNOxHsW/AGOZTvCOA0397t/yFnP/MVGRa
 VtPgmF3BLuNpt+/JpcZejp4njVgJvS6GdIEhCp7BxHzrbcI9ZfRY09Ki+H49XmWlgX
 L97PLNs31ZYzj3xa413tQ9TbfqQ+TrgCaBIBf+BF2r8SY8QScZrFScL4dyUzY1IEjG
 KlFMFB0kFnRdtbyP8Cdo+eke/7/ccYDBuR9cbN3PtYJXAFgMMgvPTwqZ/FlNtXkOs7
 4Fgp4qXvIBJlA==
Date: Wed, 2 Sep 2026 02:23:03 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <apb8S8g3Zqf1XpZ9@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <96599abcd6e3264a088ea2f34947de6496f33359.1784949155.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96599abcd6e3264a088ea2f34947de6496f33359.1784949155.git.asj@kernel.org>
X-Headers-End: 1x1T8d-00014n-UP
Subject: Re: [f2fs-dev] [PATCH v8 07/13] fstests: verify fanotify isolation
 on cloned filesystems
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

On Sat, Jul 25, 2026 at 03:39:04PM +0800, Anand Jain wrote:
> Verify that fanotify events are correctly routed to the appropriate
> watcher when cloned filesystems are mounted.
> Helps verify kernel's event notification distinguishes between devices
> sharing the same FSID/UUID.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  tests/generic/801     | 143 ++++++++++++++++++++++++++++++++++++++++++

`g/801` is already taken. To avoid merge conflicts, you can use a higher
temporary number, and I'll assign the proper number when merging.

>  tests/generic/801.out |   7 +++
>  2 files changed, 150 insertions(+)
>  create mode 100644 tests/generic/801
>  create mode 100644 tests/generic/801.out
> 
> diff --git a/tests/generic/801 b/tests/generic/801
> new file mode 100644
> index 000000000000..904ba9440b3d
> --- /dev/null
> +++ b/tests/generic/801
> @@ -0,0 +1,143 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test 801
> +# Verify fanotify FID functionality on cloned filesystems by setting up
> +# watchers and making sure notifications are in the correct logs files.
> +
> +. ./common/preamble
> +
> +_begin_fstest auto quick mount clone
> +
> +_require_test
> +_require_block_device $TEST_DEV

Which test condition requires `TEST_DEV` to be a block device?

> +_require_loop
> +_require_command "$SEMANAGE_PROG" semanage
> +_require_command "$FSNOTIFYWAIT_PROG" fsnotifywait
> +_require_fanotify_function
> +_require_unique_f_fsid
> +
> +_cleanup()
> +{
> +	cd /
> +	[[ -n $pid1 ]] && { kill -TERM "$pid1" 2> /dev/null; wait $pid1; }
> +	[[ -n $pid2 ]] && { kill -TERM "$pid2" 2> /dev/null; wait $pid2; }
> +
> +	if [ "$semanage_added" = "yes" ]; then
> +		semanage permissive -d unconfined_t >/dev/null 2>&1 || true
> +	fi
> +
> +	umount $mnt1 $mnt2 >/dev/null 2>&1
> +	_loop_image_destroy "${devs[@]}" 2> /dev/null
> +	rm -r -f $tmp.*
> +}
> +
> +# Run fsnotifywait in unbuffered mode to watch filesystem-wide create events
> +monitor_fanotify()
> +{
> +	local mmnt=$1
> +	exec stdbuf -oL $FSNOTIFYWAIT_PROG -m -F -S -e create "$mmnt" 2>&1
> +}
> +
> +# Transform f_fsid into the hi.lo format used in fanotify FID logs
> +fsid_to_fid_parts()
> +{
> +	local fsid=$1
> +	# Pad to 16 hex chars (64-bit), then split into two 32-bit halves
> +	local padded=$(printf '%016x' "0x${fsid}")
> +	local hi=$(printf '%x' "0x${padded:0:8}")   # strips leading zeros
> +	local lo=$(printf '%x' "0x${padded:8:8}")   # strips leading zeros
> +	echo "${hi}.${lo}"
> +}
> +
> +# Create base loop device and its clone
> +devs=()
> +_loop_image_create_clone devs
> +mkdir -p $TEST_DIR/$seq
> +mnt1=$TEST_DIR/$seq/mnt1
> +mnt2=$TEST_DIR/$seq/mnt2
> +mkdir -p $mnt1
> +mkdir -p $mnt2
> +
> +# Mount both base and clone filesystems using required clone mount options
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
> +						_fail "Failed to mount dev1"
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +# Fetch filesystem IDs to verify the kernel can differentiate between them
> +fsid1=$(stat -f -c "%i" $mnt1)
> +fsid2=$(stat -f -c "%i" $mnt2)
> +
> +log1=$tmp.fanotify1
> +log2=$tmp.fanotify2
> +
> +pid1=""
> +pid2=""
> +echo "Setup FID fanotify watchers on both mnt1 and mnt2"
> +
> +# Permit unconfined_t domains when SELinux is enforcing to prevent fanotify
> +# blockages
> +semanage_added="no"
> +if [ "$(getenforce 2>/dev/null)" = "Enforcing" ]; then
> +    if ! semanage permissive -l | grep -q "unconfined_t"; then
> +        semanage permissive -a unconfined_t >/dev/null 2>&1 && semanage_added="yes"
> +    fi
> +fi

Looks like semanage/SELinux isn't a necessary requirement of this test case,
if so that `_require_command "$SEMANAGE_PROG" semanage` also can be:

  if [ "$(getenforce 2>/dev/null)" = "Enforcing" ]; then
      _require_command "$SEMANAGE_PROG" semanage
  fi

right? And please replace semanage with $SEMANAGE_PROG.

> +
> +# Start asynchronous fanotify monitors
> +( monitor_fanotify "$mnt1" > "$log1" ) &
> +pid1=$!
> +( monitor_fanotify "$mnt2" > "$log2" ) &
> +pid2=$!
> +sleep 2

Are you using `sleep 2` to ensure `fsnotifywait` is fully set up?
I'm not sure if `sleep 2` is 100% reliable here. Since the subsequent tests
strictly depend on `fsnotifywait` starting up properly, is there a more
robust approach than `sleep 2`? For example, could we check the output
in `$log1` and `$log2` to make sure that? Or any other better idea?

> +
> +if ! kill -0 "$pid1" 2>/dev/null || ! kill -0 "$pid2" 2>/dev/null; then

`kill 0` only can make sure the process is running, can't make sure it's
fully set up, right?

> +	cat "$log1"
> +	cat "$log2"
> +	_fail "$FSNOTIFYWAIT_PROG setup failed"
> +fi
> +
> +echo "Trigger file creation on mnt1"
> +touch $mnt1/file_on_mnt1
> +sync
> +sleep 1
> +
> +echo "Trigger file creation on mnt2"
> +touch $mnt2/file_on_mnt2
> +sync
> +sleep 1
> +
> +echo "Verify fsid in the fanotify"
> +kill $pid1 $pid2
> +wait $pid1 $pid2 2>/dev/null
> +pid1=""

unset pid1

> +pid2=""

unset pid2

> +
> +e_fsid1=$(fsid_to_fid_parts "$fsid1")
> +e_fsid2=$(fsid_to_fid_parts "$fsid2")
> +
> +# Dump debug details to the full log
> +echo $fsid1 $e_fsid1 $fsid2 $e_fsid2 >> $seqres.full
> +cat $log1 >> $seqres.full
> +cat $log2 >> $seqres.full
> +
> +# Ensure monitor 1 only captured events belonging to mnt 1 and fsid 1
> +if grep -qF "$e_fsid1" "$log1" && ! grep -qF "$e_fsid2" "$log1"; then
> +	echo "SUCCESS: mnt1 events found"
> +else
> +	[ ! -s "$log1" ] && echo "  - mnt1 received no events."
> +	grep -qF "$e_fsid2" "$log1" && echo "  - mnt1 received event from mnt2."
> +fi
> +
> +# Ensure monitor 2 only captured events belonging to mnt 2 and fsid 2
> +if grep -qF "$e_fsid2" "$log2" && ! grep -qF "$e_fsid1" "$log2"; then
> +	echo "SUCCESS: mnt2 events found"
> +else
> +	[ ! -s "$log2" ] && echo "  - mnt2 received no events."
> +	grep -qF "$e_fsid1" "$log2" && echo "  - mnt2 received event from mnt1."
> +fi
> +
> +status=0
> +exit

_exit 0

Thanks,
Zorro

> diff --git a/tests/generic/801.out b/tests/generic/801.out
> new file mode 100644
> index 000000000000..d7b318d9f27c
> --- /dev/null
> +++ b/tests/generic/801.out
> @@ -0,0 +1,7 @@
> +QA output created by 801
> +Setup FID fanotify watchers on both mnt1 and mnt2
> +Trigger file creation on mnt1
> +Trigger file creation on mnt2
> +Verify fsid in the fanotify
> +SUCCESS: mnt1 events found
> +SUCCESS: mnt2 events found
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

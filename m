Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33605C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/oqnExCQMPxCVyxdHNcjQrg3D94A20JOwXydKIkHTI=; b=afEOjmNjhtIaf/qDIDBiSwlXtQ
	AbhzwPfnjQvlVqsNB75T3MO2tZqTH11IHls6GGwwQJDJiMRtBT74X4BzYvxBvMljXDL6HnekquouW
	ILzbSt2ZPaTgjBnHDd95UjDQIbAED1qf2F51heKKBi2SwnhjgTFYWPh7EaTkD1lL48d0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2NCY-0004LG-UJ;
	Fri, 04 Sep 2026 06:15:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1x2NCX-0004LA-Ii
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 06:14:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bTsu2G89SJRy90MXm2vb5283BxfcwUlExbIyEQ3jmSY=; b=H3h8wjuJ5pyCtHTEXXUU5ex4jX
 Glq/3L67Q6XjuAvgVpfz9eXYMFd2wT9vDXFaywAyBlORH0dvSgju4xD+X8GSsJBPNOzGMt+KNhb0r
 t7/RKLalGlPe40XEXS9d8fAyWve66/psjdjXg0mdibedI+iYueKkH7k4/RvER+/Qi2ts=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bTsu2G89SJRy90MXm2vb5283BxfcwUlExbIyEQ3jmSY=; b=FN6bOpfgCQPfX58j5SgM3Gb+7/
 G33TGC7Dzlej+4RNaQ8X/BG/gUlT72ZT0wTzI1kSRh1FMsxz0t8ilPsZQM1M+ErL1Vo9etZN2JkO9
 itELh2z3VFe4chOfCVUKXiIGLD9H0ZqujzpJ43Bvcpbw/IanaSArzP394A+NDKUV96+w=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2NCU-0003Y9-8T for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 06:14:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9ABCB60A81
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  4 Sep 2026 06:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A001F00A3E;
 Fri,  4 Sep 2026 06:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788502492;
 bh=bTsu2G89SJRy90MXm2vb5283BxfcwUlExbIyEQ3jmSY=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=iHRJ79TyoZxlkp7nwSUOLxwhbS90hnxS0b5CeEe1PqEX/vuIH/bXcZi5qBX5B6Uw1
 yMoKiIMSuLBtRcvkY9F8W4vwGGqgsKa9Y53EmGTQ7io4tiB4ZiRCBdhjwtq63a55OE
 h14hJbXsZ8SstPXhv5IkSy4aTpIBzdDptLREJJYg6spnarjqHd1u0KpLy+U9EocpQp
 APbFMPo4vVbvZPj01MhRlN6Yp0KMzRWf7mKdWuaMI1ID+QPsRq77fEjmUXgejS8U+6
 dBuRjMPUVe0kYilq1jQchst3KFjn5qz/IKeWtJtpXokHFDTfghmH4LEeMgWZd9TQKX
 qx8coXyOyz1HQ==
Message-ID: <d6efde18-0e87-4db0-8560-cbb2acc7b5a5@kernel.org>
Date: Fri, 4 Sep 2026 14:14:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
 <96599abcd6e3264a088ea2f34947de6496f33359.1784949155.git.asj@kernel.org>
 <apb8S8g3Zqf1XpZ9@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <apb8S8g3Zqf1XpZ9@zlang-mailbox>
X-Headers-End: 1x2NCU-0003Y9-8T
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
From: Anand Suveer Jain via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Suveer Jain <asj@kernel.org>
Cc: djwong@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 2/9/26 02:23, Zorro Lang wrote:
> On Sat, Jul 25, 2026 at 03:39:04PM +0800, Anand Jain wrote:
>> Verify that fanotify events are correctly routed to the appropriate
>> watcher when cloned filesystems are mounted.
>> Helps verify kernel's event notification distinguishes between devices
>> sharing the same FSID/UUID.
>>
>> Signed-off-by: Anand Jain <asj@kernel.org>
>> ---
>>  tests/generic/801     | 143 ++++++++++++++++++++++++++++++++++++++++++
> 
> `g/801` is already taken. To avoid merge conflicts, you can use a higher
> temporary number, and I'll assign the proper number when merging.
> 

Let me bump-it up to 90x.

>>  tests/generic/801.out |   7 +++
>>  2 files changed, 150 insertions(+)
>>  create mode 100644 tests/generic/801
>>  create mode 100644 tests/generic/801.out
>>
>> diff --git a/tests/generic/801 b/tests/generic/801
>> new file mode 100644
>> index 000000000000..904ba9440b3d
>> --- /dev/null
>> +++ b/tests/generic/801
>> @@ -0,0 +1,143 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
>> +#
>> +# FS QA Test 801
>> +# Verify fanotify FID functionality on cloned filesystems by setting up
>> +# watchers and making sure notifications are in the correct logs files.
>> +
>> +. ./common/preamble
>> +
>> +_begin_fstest auto quick mount clone
>> +
>> +_require_test
>> +_require_block_device $TEST_DEV
> 
> Which test condition requires `TEST_DEV` to be a block device?

You're right, I think this is a leftover from earlier prototyping
with scsi_device. The test only needs loop devices backed by
$TEST_DIR. I'll remove it in the following ver.

> 
>> +_require_loop
>> +_require_command "$SEMANAGE_PROG" semanage
>> +_require_command "$FSNOTIFYWAIT_PROG" fsnotifywait
>> +_require_fanotify_function
>> +_require_unique_f_fsid
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	[[ -n $pid1 ]] && { kill -TERM "$pid1" 2> /dev/null; wait $pid1; }
>> +	[[ -n $pid2 ]] && { kill -TERM "$pid2" 2> /dev/null; wait $pid2; }
>> +
>> +	if [ "$semanage_added" = "yes" ]; then
>> +		semanage permissive -d unconfined_t >/dev/null 2>&1 || true
>> +	fi
>> +
>> +	umount $mnt1 $mnt2 >/dev/null 2>&1
>> +	_loop_image_destroy "${devs[@]}" 2> /dev/null
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +# Run fsnotifywait in unbuffered mode to watch filesystem-wide create events
>> +monitor_fanotify()
>> +{
>> +	local mmnt=$1
>> +	exec stdbuf -oL $FSNOTIFYWAIT_PROG -m -F -S -e create "$mmnt" 2>&1
>> +}
>> +
>> +# Transform f_fsid into the hi.lo format used in fanotify FID logs
>> +fsid_to_fid_parts()
>> +{
>> +	local fsid=$1
>> +	# Pad to 16 hex chars (64-bit), then split into two 32-bit halves
>> +	local padded=$(printf '%016x' "0x${fsid}")
>> +	local hi=$(printf '%x' "0x${padded:0:8}")   # strips leading zeros
>> +	local lo=$(printf '%x' "0x${padded:8:8}")   # strips leading zeros
>> +	echo "${hi}.${lo}"
>> +}
>> +
>> +# Create base loop device and its clone
>> +devs=()
>> +_loop_image_create_clone devs
>> +mkdir -p $TEST_DIR/$seq
>> +mnt1=$TEST_DIR/$seq/mnt1
>> +mnt2=$TEST_DIR/$seq/mnt2
>> +mkdir -p $mnt1
>> +mkdir -p $mnt2
>> +
>> +# Mount both base and clone filesystems using required clone mount options
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
>> +						_fail "Failed to mount dev1"
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
>> +						_fail "Failed to mount dev2"
>> +
>> +# Fetch filesystem IDs to verify the kernel can differentiate between them
>> +fsid1=$(stat -f -c "%i" $mnt1)
>> +fsid2=$(stat -f -c "%i" $mnt2)
>> +
>> +log1=$tmp.fanotify1
>> +log2=$tmp.fanotify2
>> +
>> +pid1=""
>> +pid2=""
>> +echo "Setup FID fanotify watchers on both mnt1 and mnt2"
>> +
>> +# Permit unconfined_t domains when SELinux is enforcing to prevent fanotify
>> +# blockages
>> +semanage_added="no"
>> +if [ "$(getenforce 2>/dev/null)" = "Enforcing" ]; then
>> +    if ! semanage permissive -l | grep -q "unconfined_t"; then
>> +        semanage permissive -a unconfined_t >/dev/null 2>&1 && semanage_added="yes"
>> +    fi
>> +fi
> 
> Looks like semanage/SELinux isn't a necessary requirement of this test case,
> if so that `_require_command "$SEMANAGE_PROG" semanage` also can be:
> 
>   if [ "$(getenforce 2>/dev/null)" = "Enforcing" ]; then
>       _require_command "$SEMANAGE_PROG" semanage
>   fi
> 
> right? And please replace semanage with $SEMANAGE_PROG.
> 

Absolutely, that is the right way. I'll update it. Thanks!. More below.

>> +
>> +# Start asynchronous fanotify monitors
>> +( monitor_fanotify "$mnt1" > "$log1" ) &
>> +pid1=$!
>> +( monitor_fanotify "$mnt2" > "$log2" ) &
>> +pid2=$!
>> +sleep 2
> 
> Are you using `sleep 2` to ensure `fsnotifywait` is fully set up?
> I'm not sure if `sleep 2` is 100% reliable here. Since the subsequent tests
> strictly depend on `fsnotifywait` starting up properly, is there a more
> robust approach than `sleep 2`? For example, could we check the output
> in `$log1` and `$log2` to make sure that? Or any other better idea?
> 
>> +
>> +if ! kill -0 "$pid1" 2>/dev/null || ! kill -0 "$pid2" 2>/dev/null; then
> 
> `kill 0` only can make sure the process is running, can't make sure it's
> fully set up, right?
> 

I rely on checking whether the userspace process is still
running after a 2 second delay.

Matching specific stdout strings a common pattern in fstests
tends to be fragile across different versions of userspace
utilities. For instance, the "Watches established" string
in fsnotifywait isn't guaranteed across versions:

$ fsnotifywait -m -F -S -e create /btrfs
Setting up filesystem watches.
Watches established.
^C


>> +	cat "$log1"
>> +	cat "$log2"
>> +	_fail "$FSNOTIFYWAIT_PROG setup failed"
>> +fi
>> +
>> +echo "Trigger file creation on mnt1"
>> +touch $mnt1/file_on_mnt1
>> +sync
>> +sleep 1
>> +
>> +echo "Trigger file creation on mnt2"
>> +touch $mnt2/file_on_mnt2
>> +sync
>> +sleep 1
>> +
>> +echo "Verify fsid in the fanotify"
>> +kill $pid1 $pid2
>> +wait $pid1 $pid2 2>/dev/null
>> +pid1=""
> 
> unset pid1
> 
>> +pid2=""
> 
> unset pid2
> 

Added.

>> +
>> +e_fsid1=$(fsid_to_fid_parts "$fsid1")
>> +e_fsid2=$(fsid_to_fid_parts "$fsid2")
>> +
>> +# Dump debug details to the full log
>> +echo $fsid1 $e_fsid1 $fsid2 $e_fsid2 >> $seqres.full
>> +cat $log1 >> $seqres.full
>> +cat $log2 >> $seqres.full
>> +
>> +# Ensure monitor 1 only captured events belonging to mnt 1 and fsid 1
>> +if grep -qF "$e_fsid1" "$log1" && ! grep -qF "$e_fsid2" "$log1"; then
>> +	echo "SUCCESS: mnt1 events found"
>> +else
>> +	[ ! -s "$log1" ] && echo "  - mnt1 received no events."
>> +	grep -qF "$e_fsid2" "$log1" && echo "  - mnt1 received event from mnt2."
>> +fi
>> +
>> +# Ensure monitor 2 only captured events belonging to mnt 2 and fsid 2
>> +if grep -qF "$e_fsid2" "$log2" && ! grep -qF "$e_fsid1" "$log2"; then
>> +	echo "SUCCESS: mnt2 events found"
>> +else
>> +	[ ! -s "$log2" ] && echo "  - mnt2 received no events."
>> +	grep -qF "$e_fsid1" "$log2" && echo "  - mnt2 received event from mnt1."
>> +fi
>> +
>> +status=0
>> +exit
> 
> _exit 0
> 

Added.

Thanks.
Anand

> Thanks,
> Zorro
> 
>> diff --git a/tests/generic/801.out b/tests/generic/801.out
>> new file mode 100644
>> index 000000000000..d7b318d9f27c
>> --- /dev/null
>> +++ b/tests/generic/801.out
>> @@ -0,0 +1,7 @@
>> +QA output created by 801
>> +Setup FID fanotify watchers on both mnt1 and mnt2
>> +Trigger file creation on mnt1
>> +Trigger file creation on mnt2
>> +Verify fsid in the fanotify
>> +SUCCESS: mnt1 events found
>> +SUCCESS: mnt2 events found
>> -- 
>> 2.43.0
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7090C982D8
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 20 Sep 2026 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hs0WKai71vph24P5NcjtD1+oLCtR4a0XUiFtAo5KHLA=; b=LU0DBL7P0NPG1PWw56psVgYBHl
	wT6h+8iXXSUhHGLy8A66IIYyBNjbkYBnMLxctqLFzDMsd/umv4tewnWdxQHSOkMgxQ91V1uEOnB9u
	G/ai+pg5AQBHVTJqfWlIa/PQpZLTRv6nRNEl9HrhHngBscKNCBin1RrwUVUr4X7Ddrqs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8IFq-00081h-HL;
	Sun, 20 Sep 2026 14:10:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1x8IFp-00081a-Ce
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 20 Sep 2026 14:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L9U8x29FUMYYuun6BO6TXnYXUZdKJvqLoY6TjdR/gGg=; b=AMYG5P4fm/dRTRP7BoaC4Re8oD
 vvBq7Pia1q8oOXAB2wEyxR6iqgr9ps9NWQyj4GX0Utw7fpPTiiOHNsbhNHL0mPQeWrbI+AhepeilY
 qGKFWrjnyzWu0LLOQ/zDe7E2b0CXkRVFWVsvBeABC6Ra00RbOYAHaPJ6i3kko2WWX7ho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L9U8x29FUMYYuun6BO6TXnYXUZdKJvqLoY6TjdR/gGg=; b=diVhaHSwDVVqKp6A3X+8uhbcbZ
 n9BEcFrYNyaF17bXsAta+SAIpiIcVTYxHoqM2zqS28GnCHPdxPqqjSdZyJFFPO2tLproIdkoITZEg
 HcNUKT+4R8ewaEORq7V5PswO5UxmiHVpsP/AGvVAtT2mjSjWf3DGlSBaalerQiDzSIwY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8IFm-00055C-9w for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 20 Sep 2026 14:10:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED51843B1B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 20 Sep 2026 14:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158EC1F000FF;
 Sun, 20 Sep 2026 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789913444;
 bh=L9U8x29FUMYYuun6BO6TXnYXUZdKJvqLoY6TjdR/gGg=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=OY14vxyofU4iSX/+urwWgT4p8rLI95Hj5FWX4subo5GURa0SrjeP7fS6DWA7YBOQz
 i1O2qFs410fkP5MFiDlObENnIjMrVl98e0lHlIPRev+rKcXQBfV5B+gnonpsb4DZGr
 BYDt5ZPzD1LHOs3bf9QFN3T/mcIrCPFH74okdOKSQ+1FNUcu1s+GV6QI/0MrCvFfXS
 O5/t6Hj6w6rdkHMAsKCBRTq1PmglCWdlqDn6QjDQM8vEcXXKadYRLwkWaPyB8PCINq
 H3fn8qdPEDV4NMRpBcQHh2+PbbI6TBgazZI0VILZPRxEeiMIovMn+ITMsw4I1mCrX+
 II09xWKQycbhg==
Message-ID: <e58634ab-9b04-4ae9-bc36-88f60724e8b1@kernel.org>
Date: Sun, 20 Sep 2026 22:10:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <f68b3bd9fcee878289f8ddd7c85a6913c89772cd.1784949155.git.asj@kernel.org>
 <apcdo8K-Lfi5imbg@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <apcdo8K-Lfi5imbg@zlang-mailbox>
X-Headers-End: 1x8IFm-00055C-9w
Subject: Re: [f2fs-dev] [PATCH v8 08/13] fstests: verify f_fsid for cloned
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
From: Anand Suveer Jain via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Suveer Jain <asj@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/9/26 02:51, Zorro Lang wrote:
> On Sat, Jul 25, 2026 at 03:39:05PM +0800, Anand Jain wrote:
>> Verify that the cloned filesystem provides an f_fsid that is persistent
>> across mount cycles, yet unique from the original filesystem's f_fsid.
>>
>> Signed-off-by: Anand Jain <asj@kernel.org>
>> ---
>>  tests/generic/802     | 64 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/802.out |  4 +++
>>  2 files changed, 68 insertions(+)
>>  create mode 100644 tests/generic/802
>>  create mode 100644 tests/generic/802.out
>>
>> diff --git a/tests/generic/802 b/tests/generic/802
>> new file mode 100644
>> index 000000000000..910807c11584
>> --- /dev/null
>> +++ b/tests/generic/802
>> @@ -0,0 +1,64 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
>> +#
>> +# FS QA Test 802
>> +# Check that the cloned filesystem provides an f_fsid that is persistent
>> +# across mount cycles if the block device maj:min remains unchanged.
>> +
>> +. ./common/preamble
>> +
>> +_begin_fstest auto quick mount clone
>> +
>> +_require_test
>> +_require_block_device $TEST_DEV
>> +_require_loop
>> +
>> +_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
>> +	"btrfs: use on-disk uuid for s_uuid in temp_fsid mounts"
>> +_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
>> +	"btrfs: derive f_fsid from on-disk fsuuid and dev_t"
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f $tmp.*
>> +	umount $mnt1 $mnt2 2>/dev/null
>> +	_loop_image_destroy "${devs[@]}" 2> /dev/null
>> +}
>> +
>> +# Setup base loop device and its clone
>> +devs=()
>> +_loop_image_create_clone devs
>> +mkdir -p $TEST_DIR/$seq
> 
> Better to `rm -rf $TEST_DIR/$seq` before creating a new one.
> 

Applied.

>> +mnt1=$TEST_DIR/$seq/mnt1
>> +mnt2=$TEST_DIR/$seq/mnt2
>> +mkdir -p $mnt1
>> +mkdir -p $mnt2
>> +
>> +# Mount both filesystems simultaneously using mandatory clone mount options
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
>> +						_fail "Failed to mount dev1"
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
>> +						_fail "Failed to mount dev2"
>> +
>> +# Capture baseline filesystem IDs for comparison
>> +fsid_scratch=$(stat -f -c "%i" $mnt1)
>> +fsid_clone=$(stat -f -c "%i" $mnt2)
>> +
>> +# Verify that the fsids remain stable after a mount cycle, even when the
>> +# mount order is reversed.
>> +echo "**** fsid after mount cycle ****"
>> +_unmount $mnt1
>> +_unmount $mnt2
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
>> +						_fail "Failed to mount dev2"
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
>> +						_fail "Failed to mount dev1"
>> +
>> +# Compare post mount-cycle values against the baseline
>> +stat -f -c "%i" $mnt1 | sed -e "s/$fsid_scratch/FSID_SCRATCH/g"
>> +stat -f -c "%i" $mnt2 | sed -e "s/$fsid_clone/FSID_CLONE/g"
> 

> Hmm... what if "$fsid_scratch" is same with "$fsid_clone"?
> 

That falls into the same category as ext4 (and likely Btrfs as well,
pending a regression report fix that is delaying this fstests patch as
well), where both the original and cloned filesystems share the same
`f_fsid`. However, since the objective of this test case is to verify
consistency within the filesystem across reboots, this behavior is fine.

>> +
>> +status=0
>> +exit
> 
> _exit 0

Applied.

> 
>> diff --git a/tests/generic/802.out b/tests/generic/802.out
>> new file mode 100644
>> index 000000000000..0202a9a2c108
>> --- /dev/null
>> +++ b/tests/generic/802.out
>> @@ -0,0 +1,4 @@
>> +QA output created by 802
>> +**** fsid after mount cycle ****
>> +FSID_SCRATCH
>> +FSID_CLONE
>> -- 
>> 2.43.0
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

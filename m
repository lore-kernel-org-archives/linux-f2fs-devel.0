Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAFACD4F54
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VuA8V+dg1BPQyDZErnAUMU9CtIuxHooRauE3jfsFzQE=; b=k7VqldT2pUwQC/mwWk4zAunEdu
	abzp9QLU+6k0WP10BEumUle77pN7hiH1AcaSpZsJZQQ4kVLCxJ+6oJX1neeNoub+GMxaYiWNnM21y
	i6whVK/5rSYukay3rIFVychX7SEnS/hO/tiDV2jvDSFUa6iTX890nQJHesdRI5cP/WqE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPrF1-0000Yu-SP;
	Thu, 21 May 2026 00:26:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wPrF0-0000Ym-5B
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 00:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qk6vc+HDG6D8dvUIDmq4mkBfCVo0cShiIRU/MQzSCrc=; b=OUlhK3evGV8BPwX9UVIcQyskPR
 n/yimf0FX185xdFMmiVTOXa1qdpdACrDGkHxoCmbRTm5BMjq3mGrZ7g03fjwTgDJcBChoIA5J0sCw
 pFy/ZFWIUGZOIDQso81/AYsB1ZWKmS99KCW4/HLe6ImnwXHIMnSOggNCFbWSFg8juHGk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qk6vc+HDG6D8dvUIDmq4mkBfCVo0cShiIRU/MQzSCrc=; b=Qac27aK/+OPySvrYK1QMjhToik
 BUSCnoVE/L3W5XKABJs+RsRMRjkanObPofWoSefBphDp/b4KmT6TD6kE0N5NEh5mwyZ8tLN5hUBYv
 uKzg4AmZqTwk7j1yoZ6rirZQkzX2XVqFolXRSpflXCRY+umHJweCeu9cdKd8OSiTkDP4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPrEy-0002Y1-5D for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 00:26:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47ACA40883;
 Thu, 21 May 2026 00:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4983E1F000E9;
 Thu, 21 May 2026 00:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779323175;
 bh=Qk6vc+HDG6D8dvUIDmq4mkBfCVo0cShiIRU/MQzSCrc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=LWe+Q7av5x1o10cQEi4hpGQ+gzoWR68jq+IUsintOO0XBr/i2DvDqMU1U2+awfKUl
 OBzhOWBv7k65hdFKZ8GIrzjkqWf52P7228BA2XKYrmR8/w6aWDqPboWnvOKwkIFgEh
 ik0KM6+NJlRo4enHdOHg+O1WdKDLBt1SqETf7USdR1wIrqq/uSOCXU4yUKm6PrY8uw
 KDwF06CQ5tkbW0gYB44oKv9pfe5YtS5uI6t/DvrcfiZDJyqBytBm6xev3NNl6py9GK
 VOaQLIfAdnICE+gbjnyugF77Y9HstimEiZGhr6xSMVqyjEoI33hpqR3a1ki8fQsXII
 l8LnIRRllNf1g==
Message-ID: <76060445-9b71-486b-bfac-9cc8b439d166@kernel.org>
Date: Thu, 21 May 2026 00:26:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: fstests@vger.kernel.org, jaegeuk@kernel.org, jprusakowski@google.com,
 joannechien@google.com, linux-f2fs-devel@lists.sourceforge.net
References: <20260518101252.445214-1-chao@kernel.org>
 <ag2Rh-4_Tp082XXx@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <ag2Rh-4_Tp082XXx@zlang-mailbox>
X-Headers-End: 1wPrEy-0002Y1-5D
Subject: Re: [f2fs-dev] [PATCH] f2fs/025: test to do sanity check section
 type correctly in f2fs GC
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/20/26 12:28, Zorro Lang wrote:
> On Mon, May 18, 2026 at 06:12:52PM +0800, Chao Yu wrote:
>> Without commit 520760b9f915 ("f2fs: optimize representative type determination
>> in GC"), f2fs GC will report inconsistent segment type in large section issue,
>> and then it will force to shutdown filesystem.
>>
>> [  768.190903] F2FS-fs (loop51): Inconsistent segment (3) type [1, 0] in SIT and SSA
>>
>> The reason is f2fs kernel will assume all segment type inside large section is
>> the same, during GC it loads type from one segment and compare it to other
>> segments' type, however due to recovery flow, the chosen segment may has zero
>> valid blocks w/ different segment type, since the segment is invalid(free) one,
>> it will never be migrated, so that we should not treat such state as abnormal
>> condition.
>>
>> This testcase is created to simulate above condition to see whether f2fs kernel
>> module can handle it correctly
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   tests/f2fs/025     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/025.out |  2 ++
>>   2 files changed, 90 insertions(+)
>>   create mode 100644 tests/f2fs/025
>>   create mode 100644 tests/f2fs/025.out
>>
>> diff --git a/tests/f2fs/025 b/tests/f2fs/025
>> new file mode 100644
>> index 00000000..1eba7158
>> --- /dev/null
>> +++ b/tests/f2fs/025
>> @@ -0,0 +1,88 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2026 Chao Yu <chao@kernel.org>
>> +#
>> +# FS QA Test No. f2fs/025
>> +#
>> +# Check whether f2fs will encounter cp_error (Inconsistent segment type)
>> +# when doing sanity check on type of segments inside large section during
>> +# garbage collection.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_fixed_by_kernel_commit 520760b9f915 \
>> +	"f2fs: optimize representative type determination in GC"
>> +
>> +. ./common/filter
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +_require_scratch
>> +_require_xfs_io_command "pwrite"
>> +_require_xfs_io_command "truncate"
>> +_require_command "$F2FS_IO_PROG" f2fs_io
>> +_require_check_dmesg
>> +
>> +# Format with 96MB size and 2 segments per section
>> +_scratch_mkfs_sized $((96 * 1024 * 1024)) "" "-s 2" >> $seqres.full 2>&1
>> +
>> +# Mount with mode=lfs
>> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
>> +
>> +# Create files to fill whole filesystem, then segment type will be changed to node type
>> +for ((i=0;i<5120;i++)) do
>> +	touch $SCRATCH_MNT/$i >> $seqres.full 2>&1
> 
> 5120 * 4k = 20MB
> 
>> +done
>> +sync
>> +
>> +# Remove all files to create free(empty) node segments
>> +rm -f $SCRATCH_MNT/*
>> +sync
>> +
>> +# Allocate free space so that we have chance to reuse free(empty) node segments
>> +$XFS_IO_PROG -f -c "pwrite -b 4k 0 1928k" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +sync
>> +
>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 16M" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +sync
>> +
>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 8M" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 32K" $SCRATCH_MNT/file >> $seqres.full 2>&1
>> +$XFS_IO_PROG -c "truncate 0" $SCRATCH_MNT/file >> $seqres.full 2>&1
> 
> 1928k + 16M + 16M + 8M + 32K ~= 40M
> 
>> +$XFS_IO_PROG -d -c "pwrite -b 4k 0 2M" -c "fsync" $SCRATCH_MNT/file >> $seqres.full 2>&1
> 
> 96M - 40M - 20M = 36M
> 
> I'm not a f2fs expert, I think you hope to (almost) fill the fs before this 2M
> pwrite step. If so, I'm wondering can we ensure that other metadata takes ~36 MB

Zorro, thanks for the review.

Actually, we don't need to write metadata to other ~36 MB space, because node log
and data log are start from different area of block addresses, more details as below:

warm_node type log starts from beginning of block addresses
https://git.kernel.org/pub/scm/linux/kernel/git/chao/f2fs-tools.git/tree/mkfs/f2fs_format.c#n662

warm_data type log starts from middle of block addresses
https://git.kernel.org/pub/scm/linux/kernel/git/chao/f2fs-tools.git/tree/mkfs/f2fs_format.c#n668

With lfs mode, warm_data log can allocate forward until to the end of block addresses,
and then start from beginning of block addresss, then we can expect it reuse the
area which were used by node log.

> of space, thereby guaranteeing that this 2 MB write triggers the reuse of that
> 1928 KB segment (no matter with any MKFS_OPTIONS)?

Oh, I may miss to consider MKFS_OPTIONS and MOUNT_OPTIONS, what do you think of
clearing both MKFS_OPTIONS and MOUNT_OPTIONS before the test?

Thanks,

> 
> Thanks,
> Zorro
> 
>> +
>> +# Shutdown the filesystem without checkpoint
>> +$F2FS_IO_PROG shutdown 2 $SCRATCH_MNT >> $seqres.full 2>&1
>> +
>> +_scratch_unmount >> $seqres.full 2>&1
>> +
>> +_scratch_mount -o mode=lfs >> $seqres.full 2>&1
>> +
>> +# Run urgent_gc mode to trigger garbage collection
>> +dev_name=$(_short_dev $SCRATCH_DEV)
>> +if [ -f /sys/fs/f2fs/$dev_name/gc_urgent ]; then
>> +	echo 1 > /sys/fs/f2fs/$dev_name/gc_urgent
>> +fi
>> +
>> +# Wait background GC thread to wake up to run and potentially encounter the inconsistency
>> +sleep 5
>> +
>> +_scratch_unmount >> $seqres.full 2>&1
>> +
>> +# Check whether the dmesg has the warning indicating the bug
>> +_check_dmesg_for "F2FS-fs \($dev_name\): Inconsistent segment" && \
>> +	_fail "F2FS-fs ($dev_name): Inconsistent segment type detected in dmesg!"
>> +
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/025.out b/tests/f2fs/025.out
>> new file mode 100644
>> index 00000000..3d70951e
>> --- /dev/null
>> +++ b/tests/f2fs/025.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 025
>> +Silence is golden
>> -- 
>> 2.49.0
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

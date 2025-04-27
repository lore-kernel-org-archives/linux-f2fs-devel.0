Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF19BC369D5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 27 Apr 2025 08:21:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u8xGM-0007nZ-E6;
	Sun, 27 Apr 2025 08:21:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1u8xGL-0007mv-19
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Apr 2025 08:21:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K6Rsj15S+RPr9Nl1yC/FFMRmUcjeZPR8Nww9smN2I3M=; b=kwZTL1BPFShTLv94XP4L8ESpWY
 HiIiFi5pgbTqEQu9NDYQCIkiV/D9q6iYqhtEFo0A/KxLktGmWYYT8EtSo9bLLUndhx/73Gcs/JPRw
 BAxErh/psakQax+i8ZjHOyArBWHaaHfdz73DZG789NIbVLb6SFgZPWTA17ozT9rpWM48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K6Rsj15S+RPr9Nl1yC/FFMRmUcjeZPR8Nww9smN2I3M=; b=e0AdWiTxsMCQ3uvQmYvacGftE3
 ptLq0nMQo8/ImrtMXlnrt701SLkLicgmiml4E5qrmG23KJr+QfEDi21Cs+7wLFNDfYZd1T0xejDn1
 976pFoQRR3krNlMwVgMELqsSBebuALXZ86C5PSHo7pykUdEmCBLeMzVEpzGzRyuIo134=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u8xG5-0007O4-KB for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Apr 2025 08:21:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F7DC61157;
 Sun, 27 Apr 2025 08:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DACC4CEE3;
 Sun, 27 Apr 2025 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745742054;
 bh=fyOAcxErM964eVJSIxAeMZVFc+VzMfbujPvLX1vy89c=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=Uduejj0USms0iyuxE2gNsfO3zmU6gOmFoYqAwIBH4EMndLiWtPp7G5gi4k8a02UIL
 H7oB3Uz5huu6LXRPyVrPN8yxj5aKkOC+FUEhowZVwh5iZSb29G9YVcaJiCMAcrmXdt
 l+DryPVvs6D1+NDaGKeAoZH4gOPIyaNpKc0CaO4H0R7m6a+Y1jJBSXdnSW2FDZ+oUC
 dIioKwicoKHM4gd22ZgP3aGP7T55mWI8umImVDf3kEwVyTWJi5fYt3WO7FcadEiKyU
 PhXGTcQcK97+3LpSDtKUkgUt2jx3CGw5+JoZ9u8VID18XlZACjrEUVBYevenGsxXfI
 nuzQ4FUSEG8eg==
Message-ID: <90d349b5-5866-4486-8d93-a73f11ae2f9e@kernel.org>
Date: Sun, 27 Apr 2025 16:20:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@redhat.com>
References: <20250327055051.3827735-1-chao@kernel.org>
 <20250425141311.kgwsazvt6r65yfod@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
In-Reply-To: <20250425141311.kgwsazvt6r65yfod@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Headers-End: 1u8xG5-0007O4-KB
Subject: Re: [f2fs-dev] [PATCH v2] f2fs/011: test to check out-of-space issue
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/25/25 22:13, Zorro Lang wrote:
> On Thu, Mar 27, 2025 at 01:50:51PM +0800, Chao Yu wrote:
>> This is a regression testcase to check whether we will handle
>> out-of-space case correctly during fallocate() on pinned file
>> once we disable checkpoint.
>>
>> Testcase:
>> 1. mount f2fs w/ checkpoint=disable option
>> 2. create fragmented file data
>> 3. set flag w/ pinned flag
>> 4. fallocate space for pinned file, expects panic due to running
>> out of space.
>>
>> We should apply both commit ("f2fs: fix to avoid panic once
>> fallocation fails for pinfile") and commit ("f2fs: fix to avoid
>> running out of free segments") to avoid system panic.
>> Note that w/ these two commit, we fixed such issue in both
>> convential and zoned block device.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - clean up codes suggested by Zorro
>> - change output to expect ENOSPC error if we have applied fixes
> 
> Sorry I missed this V2, this version looks good to me. As there's not
> more review points from f2fs list, so I'd like to merge it:

Thank you, Zorro.

Could you please take a look at this new testcase?

https://lore.kernel.org/fstests/20250415093822.1100476-1-chao@kernel.org

Thanks,

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
>>  tests/f2fs/011     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/011.out |  2 ++
>>  2 files changed, 55 insertions(+)
>>  create mode 100755 tests/f2fs/011
>>  create mode 100644 tests/f2fs/011.out
>>
>> diff --git a/tests/f2fs/011 b/tests/f2fs/011
>> new file mode 100755
>> index 00000000..ec3d39ec
>> --- /dev/null
>> +++ b/tests/f2fs/011
>> @@ -0,0 +1,53 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/011
>> +#
>> +# This is a regression testcase to check whether we will handle
>> +# out-of-space case correctly during fallocate() on pinned file
>> +# once we disable checkpoint.
>> +# 1. mount f2fs w/ checkpoint=disable option
>> +# 2. create fragmented file data
>> +# 3. set flag w/ pinned flag
>> +# 4. fallocate space for pinned file, expects panic due to running
>> +# out of space
>> +# We should apply both commit ("f2fs: fix to avoid panic once
>> +# fallocation fails for pinfile") and commit ("f2fs: fix to avoid
>> +# running out of free segments") to avoid system panic.
>> +# Note that w/ these two commit, we fixed such issue in both
>> +# convential and zoned block device.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_fixed_by_kernel_commit 48ea8b200414 \
>> +	"f2fs: fix to avoid panic once fallocation fails for pinfile"
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"f2fs: fix to avoid running out of free segments"
>> +
>> +_require_scratch
>> +_require_command "$F2FS_IO_PROG" f2fs_io
>> +
>> +_scratch_mkfs_sized $((1*1024*1024*1024)) >> $seqres.full
>> +_scratch_mount -o checkpoint=disable:10%
>> +
>> +pinfile=$SCRATCH_MNT/file
>> +
>> +# simulate fragment status in f2fs
>> +for ((i=0;i<256;i++)) do
>> +	$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full
>> +done
>> +sync
>> +
>> +for ((i=0;i<256;i+=2)) do
>> +	rm -f $SCRATCH_MNT/$i
>> +done
>> +sync
>> +
>> +touch $pinfile
>> +$F2FS_IO_PROG pinfile set $pinfile >> $seqres.full
>> +$XFS_IO_PROG -c "falloc 0 $((3*256*1024*1024))" $pinfile
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/011.out b/tests/f2fs/011.out
>> new file mode 100644
>> index 00000000..559c3fdf
>> --- /dev/null
>> +++ b/tests/f2fs/011.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 011
>> +fallocate: No space left on device
>> -- 
>> 2.49.0
>>
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

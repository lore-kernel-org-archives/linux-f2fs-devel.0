Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10854CCD184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Oct 2025 02:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nK9WkyTjmcUE11RFgOHNQXZ08OhwSlXBhMW7WIFSlAE=; b=Z1HqDmpbByRJi2B3iZbp9QAMm6
	Ui6/f/RbJSMDH5qL/qxd6n5rPMGzU/urBTeqdhNBqLdGnw5Cg49P60MmyKUi+BajjrSUbjHOEsRI1
	M95BgBf3fqVaTTEg2emh7Y3bP3YCgm5FzLWC7a00wChtD+S7Z+59Pftk4boWUkDRINEc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vAg6E-0001BW-Tx;
	Mon, 20 Oct 2025 02:58:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vAg6D-0001BG-9Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Oct 2025 02:58:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BEltI1S3tmY6YZY5JOMucSAS6S9aEFuoYCFENjIVNu0=; b=J36C38+tkQjk6xSc51sxkdYF3O
 +XDFIF+miLx1DczQk/poX0VB0/WeILMCUNBvvztG4gNYs2IbvzKApNBait4OkKipK9gcVFXULpieR
 ynP1OqUmD7IJO3cxjQHLhXO0mfXM1ctjWcDVvBwmDGjFFqvx7+CRZ1KWTpoTCdyMPagU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BEltI1S3tmY6YZY5JOMucSAS6S9aEFuoYCFENjIVNu0=; b=E0kdjLePz06FLxHgKtf6YzriiI
 1jqQBPRy5szxQXo5/STnvMzZO+9v3nA0HN3KKTI55t7SHJU9SAbn6cZYwqL3Htci0RKKdynPNvvIn
 UUXkCHdXn+AOaT3qIKhcvChuhlWDWtTUQL1JILcglC3qegocWgXKhSf7MkLdHNMKqnbQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vAg6D-0007qC-Je for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Oct 2025 02:58:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D9925612CD;
 Mon, 20 Oct 2025 02:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99427C4CEF1;
 Mon, 20 Oct 2025 02:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760929086;
 bh=cI3/ias/+4HcFAyVUAilSQLc+xhAr0wOuznULvflJg8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m3GC42CGW3UVJ/ZsGW2Gfbrqgm8gdw9RJ1cLY+1tkcDki4A0Z9FeRSn9ZP1Rj/3yA
 KH8HU5hbJED3CgyBXtseRmC5UXy+OB9cG+ZbTs8sWNhFPf3p6Djsp1opKR/P6RY35k
 QgwRb+RuoB6bagMg37FkGXRmROs/08f87PK2dqSGCCbKlLVN36hbmXtFpbV/FEV8V6
 Yd9j39XewgGuO1bN15syMD2DGMW00n6MVi344VF7vZcFa7GHHYbyC+I5SwSf9G0pVu
 wNcMIFCliiChZLs0Gl6PbwWsYKaQHYcdMfhqm/2AtLOen/g4fluZFyxpOOs0309FSY
 YY5eZwEAdne4A==
Message-ID: <9e724171-eaec-4156-8a3c-210f292ad84d@kernel.org>
Date: Mon, 20 Oct 2025 02:57:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@redhat.com>
References: <20251011084715.608562-1-chao@kernel.org>
 <20251017193013.ykrwjftkvhaug76z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
In-Reply-To: <20251017193013.ykrwjftkvhaug76z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Headers-End: 1vAg6D-0007qC-Je
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs/021: test quota mount option
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/17/25 19:30, Zorro Lang wrote:
> On Sat, Oct 11, 2025 at 04:47:14PM +0800, Chao Yu wrote:
>> This testcase tries to check whether f2fs can handle "usrjquota="
>> during remount correctly, it expects kernel will encounter NULL
>> pointer dereference bug w/o the fix ("f2fs: fix to avoid NULL pointer
>> dereference in f2fs_check_quota_consistency()").
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Reviewed-by: Zorro Lang <zlang@redhat.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
> 
> Hi Chao,
> 
> This patchset has been merged, you can send a seperated patch to update the
> commit id of _fixed_by_kernel_commit :)

Hi Zorro,

I have sent a seperated patch to update commit id, please take a look, thanks. :)

Thanks,

> 
> Thanks,
> Zorro
> 
>> v3:
>> - update commit id in _fixed_by_kernel_commit line
>>   tests/f2fs/021     | 30 ++++++++++++++++++++++++++++++
>>   tests/f2fs/021.out |  2 ++
>>   2 files changed, 32 insertions(+)
>>   create mode 100755 tests/f2fs/021
>>   create mode 100644 tests/f2fs/021.out
>>
>> diff --git a/tests/f2fs/021 b/tests/f2fs/021
>> new file mode 100755
>> index 00000000..0cacb138
>> --- /dev/null
>> +++ b/tests/f2fs/021
>> @@ -0,0 +1,30 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/021
>> +#
>> +# This testcase tries to check whether f2fs can handle "usrjquota="
>> +# during remount correctly
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick mount quota remount
>> +
>> +_fixed_by_kernel_commit 930a9a6ee8e7 \
>> +	"f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()"
>> +
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount "-o usrquota"
>> +quotacheck -uc $SCRATCH_MNT
>> +_scratch_unmount
>> +
>> +_scratch_mount "-o usrjquota=aquota.user,jqfmt=vfsold"
>> +_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
>> +_scratch_unmount
>> +
>> +echo "Silence is golden"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/021.out b/tests/f2fs/021.out
>> new file mode 100644
>> index 00000000..09f4062d
>> --- /dev/null
>> +++ b/tests/f2fs/021.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 021
>> +Silence is golden
>> -- 
>> 2.49.0
>>
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

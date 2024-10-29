Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0E9D3E2D0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Oct 2024 07:47:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t5gxK-0003JM-3T;
	Tue, 29 Oct 2024 07:47:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t5gxJ-0003JG-9Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Oct 2024 07:47:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tsD2mOtQNnOZAirt+O5ea/lskFJ149ikyIrc7xWbOmA=; b=d0exp99qYGOH5tTESI8dzicQwP
 +uybKmFdupE4a5/k6tRgbe2Zlg3z4IYeqOh0TkORQwcAEKTxiO5v93RW0iFSyXMNUR4pyKkqGgXR5
 RkI+eCp1LSgDrnODUgCzOEQMiB9CmkPNm7wkAPFwyJ0dwcFHdw9LPH1AGrmi/MDRIqes=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tsD2mOtQNnOZAirt+O5ea/lskFJ149ikyIrc7xWbOmA=; b=mRo5ps9VNY4upb/5qKDuxxEgNL
 Ia1IGXmI6IyjHl1Zw/k01qdVxbEg4qrvdTRuHrmxZjPMj18v+6OjaGqKIblxZ8EZKZlPxukA1Sekg
 ijdo2vlmf+SpO3BtsFEs489x6MqiY6PVLorA7g8SLYy5cAF0MVQSlIiDOuQbNzCMQrkk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t5gxJ-0000kw-57 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Oct 2024 07:47:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BFCD45C4ADF;
 Tue, 29 Oct 2024 07:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AD1C4CECD;
 Tue, 29 Oct 2024 07:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730188066;
 bh=5p3svHAkNxkSh97zKZkxSvBXYWMJQfLj/K6ZploJeb4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=VCfbXKXXzVjDh7FSmljN/6/MYphw7JOnKZ7T1+1senSfyt/OUGx5Jj5v51YldrAXf
 VrPpW48VT6sZkzvK3Tv6xTK6LIx3sJ9bNxGOJz4voGxL/kqbnjU3vK52es0+T0RtgU
 NgHJYRtiavF9hMO5L61Tv5vt4DpA3K1Jm14qQbnBc373JeYsbaURwKRISXFgWfktRL
 MJ0iL9UxEl/u6YALcjWdtjs3OZwRfBN4SmkxBdxa3NxcU51ER8LZu5fD8Et0xZ8okG
 RGkuOqrw0nH/E5btf6nGN3N5T3Apfg+GKD741QdzcJney7u6tU4iDzigv4a//nY8Mw
 mbGpD7+bECiSw==
Message-ID: <8244a092-4775-47a4-8754-1bb1d1ea3c56@kernel.org>
Date: Tue, 29 Oct 2024 15:47:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@redhat.com>
References: <20241028141800.1788356-1-chao@kernel.org>
 <20241028141800.1788356-2-chao@kernel.org>
 <20241029062104.pepwqv4w4scvgiy4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
In-Reply-To: <20241029062104.pepwqv4w4scvgiy4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Headers-End: 1t5gxJ-0000kw-57
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs/007: add testcase to check
 consistency of compressed inode metadata
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Qi Han <hanqi@vivo.com>,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/29 14:21, Zorro Lang wrote:
> On Mon, Oct 28, 2024 at 10:18:00PM +0800, Chao Yu wrote:
>> metadata of compressed inode should always be consistent after file
>> compression, reservation, releasement and decompression, let's add
>> a testcase to check it.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Qi Han <hanqi@vivo.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v3:
>> - move _require_scratch before use of $SCRATCH_MNT
>> - output message before _check_scratch_fs
>>   tests/f2fs/007     | 108 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/f2fs/007.out |  16 +++++++
>>   2 files changed, 124 insertions(+)
>>   create mode 100755 tests/f2fs/007
>>   create mode 100644 tests/f2fs/007.out
>>
>> diff --git a/tests/f2fs/007 b/tests/f2fs/007
>> new file mode 100755
>> index 00000000..805d88fa
>> --- /dev/null
>> +++ b/tests/f2fs/007
>> @@ -0,0 +1,108 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/007
>> +#
>> +# This is a regression test to check whether compressed metadata
>> +# can become inconsistent after file compression, reservation
>> +# releasement, and decompression.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick rw compress
>> +
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +        "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
>> +
>> +_require_scratch
>> +testfile_prefix=$SCRATCH_MNT/testfile
>> +fio_config=$tmp.fio
>> +
>> +cat >$fio_config <<EOF
>> +[write_compressed_data_30]
>> +name=mytest
>> +ioengine=psync
>> +rw=write
>> +direct=0
>> +bs=1M
>> +filesize=1M
>> +numjobs=1
>> +filename=${testfile_prefix}30
>> +buffer_compress_percentage=30
>> +
>> +[write_compressed_data_60]
>> +name=mytest
>> +ioengine=psync
>> +rw=write
>> +direct=0
>> +bs=1M
>> +filesize=1M
>> +numjobs=1
>> +filename=${testfile_prefix}60
>> +buffer_compress_percentage=60
>> +
>> +[write_compressed_data_90]
>> +name=mytest
>> +ioengine=psync
>> +rw=write
>> +direct=0
>> +bs=1M
>> +filesize=1M
>> +numjobs=1
>> +filename=${testfile_prefix}90
>> +buffer_compress_percentage=90
>> +EOF
>> +
>> +_require_fio $fio_config
>> +_scratch_mkfs "-f -O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
>> +_scratch_mount "-o compress_mode=user,compress_extension=*" >> $seqres.full
>> +
>> +echo -e "Run fio to initialize file w/ specified compress ratio" >> $seqres.full
>> +cat $fio_config >> $seqres.full
>> +$FIO_PROG $fio_config >> $seqres.full
>> +_scratch_unmount
>> +
>> +# force to repaire if filesystem is corrupted
> 
>                repair
> 
>> +export FSCK_OPTIONS="-f $FSCK_OPTIONS"
> 
> JFYI, if f2f2 always hope to force to repair, you can think about changing the _fsck_opts()
> in common/config.

Got it, thanks for your reminder.

> 
> Others look good to me, I'll help to fix above typo when I merge it. Thanks for you patch.

Thank you!

Thanks,

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
>> +
>> +for i in 30 60 90; do
>> +	testfile=$testfile_prefix$i
>> +
>> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
>> +	$F2FS_IO_PROG compress $testfile >> $seqres.full
>> +	cblocks=`$F2FS_IO_PROG get_cblocks $testfile`
>> +	echo "compression ratio is: "$cblocks" / 256"
>> +
>> +	_scratch_unmount
>> +
>> +	# 1. check after compression
>> +	echo "check fs after compress"
>> +	_check_scratch_fs
>> +
>> +	_scratch_mount >> $seqres.full
>> +	$F2FS_IO_PROG release_cblocks $testfile >> $seqres.full
>> +	_scratch_unmount
>> +
>> +	# 2. check after releasement
>> +	echo "check fs after release_cblocks"
>> +	_check_scratch_fs
>> +
>> +	_scratch_mount >> $seqres.full
>> +	$F2FS_IO_PROG reserve_cblocks $testfile >> $seqres.full
>> +	_scratch_unmount
>> +
>> +	# 3. check after rservation
>> +	echo "check fs after reserve_cblocks"
>> +	_check_scratch_fs
>> +
>> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
>> +	$F2FS_IO_PROG decompress $testfile >> $seqres.full
>> +	_scratch_unmount
>> +
>> +	# 4. check after decompression
>> +	echo "check fs after decompress"
>> +	_check_scratch_fs
>> +done
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/007.out b/tests/f2fs/007.out
>> new file mode 100644
>> index 00000000..a4b76300
>> --- /dev/null
>> +++ b/tests/f2fs/007.out
>> @@ -0,0 +1,16 @@
>> +QA output created by 007
>> +compression ratio is: 64 / 256
>> +check fs after compress
>> +check fs after release_cblocks
>> +check fs after reserve_cblocks
>> +check fs after decompress
>> +compression ratio is: 128 / 256
>> +check fs after compress
>> +check fs after release_cblocks
>> +check fs after reserve_cblocks
>> +check fs after decompress
>> +compression ratio is: 192 / 256
>> +check fs after compress
>> +check fs after release_cblocks
>> +check fs after reserve_cblocks
>> +check fs after decompress
>> -- 
>> 2.40.1
>>
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

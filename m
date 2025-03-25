Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBEBC35FFC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:59:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1twyG3-0003Pk-LA;
	Tue, 25 Mar 2025 06:59:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1twyG1-0003Pb-4z
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 06:59:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4y8jRtWJBuoVJGUCA5oaB/D2bGAzk3GQWHeQzBUC7Yw=; b=dIpx15LaMas79hx2nIR9SoOT7G
 hAQDLUAjzJ8SbCXaGtIU3Iq+RixQZFgNPQsU6WRLj5eoDDlGfVSqO4BuVb785w15TAFCD4AcXN0Za
 d9Cci6WC6EtsfkZyEYhQU+wda7zXLDpaUFDAC1i8Bp+oQLPl1s49k7xw0NZgnX8tYP6A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4y8jRtWJBuoVJGUCA5oaB/D2bGAzk3GQWHeQzBUC7Yw=; b=Xup7uoamZbEgPUqokzsCWGpsVb
 ZwWq+7XEN1zZIjL+7YHW5x3bGevTUYRr/ttTzgwj1sfcY7XiI26fJUcQRRGBFXwpZ+vRD8vPVSOOK
 6g3Lf11+mGj7F5V5itiUxwMQ8qQ7O2YUkcb/f9SH4TvTmXWOJjzT5ILXwW2Ce8Jk90bs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1twyFu-0004ut-OA for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 06:59:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 659DE5C43CE;
 Tue, 25 Mar 2025 06:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EF3C4CEEA;
 Tue, 25 Mar 2025 06:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742885957;
 bh=KJTdAsEL/0ZMZpo4gzToh+crD41MLDFt9Xm+PUAS5NM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=TeZQE5SGPooAGf6hqSybwvn7rDyWC0y16xToaKGZSKVzc6pe85JrlAPbWIDHXvQHz
 iqSNHlXlhOCZhYPO+KRJvK5V1/Osm42AsJgcH8l5M+YgA2u/cj/827MQ1CtLt/cZ2I
 7bk4dnqAqQPhLNHqgEF6o+UVbNS1lTe+YStNhPC3nmzyq1B6RZFi9xkRei0YRWPj7l
 nJIT1oWluPI4RPA42ntT+LpvwE74K//g/0fVzRmb3C90pB9NsyBE02Z/niiYNfxsVM
 RrIjoS1aQ88oH7NZXh9O2uJ5/PfEWzRbQsX01Pzyl0PCK0wu2H/Nbt/m4y3hapoBQ/
 42P+cKgX9Qv/w==
Message-ID: <e439117b-9f91-43c0-9203-1786a7372c95@kernel.org>
Date: Tue, 25 Mar 2025 14:59:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@redhat.com>
References: <20250324123836.3098377-1-chao@kernel.org>
 <20250325011854.svncwerxilkimg5j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
In-Reply-To: <20250325011854.svncwerxilkimg5j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Headers-End: 1twyFu-0004ut-OA
Subject: Re: [f2fs-dev] [PATCH] f2fs/010: test dirty status handling on
 database file
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
Cc: Daeho Jeong <daehojeong@google.com>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 Zorro Lang <zlang@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/25/25 09:18, Zorro Lang wrote:
> On Mon, Mar 24, 2025 at 08:38:36PM +0800, Chao Yu wrote:
>> This is a regression testcase to check whether we will handle database
>> inode dirty status correctly:
>> 1. create a regular file, and write data into the file
>> 2. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
>> 3. write transaction data to the file
>> 4. rename the file
>> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
>> 6. drop caches in order to call f2fs_evict_inode()
>> It expects kernel panic will gone after we apply commit 03511e936916
>> ("f2fs: fix inconsistent dirty state of atomic file").
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Daeho Jeong <daehojeong@google.com>
>> Cc: Jianan Huang <huangjianan@xiaomi.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  tests/f2fs/010     | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/010.out |  2 ++
>>  2 files changed, 70 insertions(+)
>>  create mode 100755 tests/f2fs/010
>>  create mode 100644 tests/f2fs/010.out
>>
>> diff --git a/tests/f2fs/010 b/tests/f2fs/010
>> new file mode 100755
>> index 00000000..360c09b9
>> --- /dev/null
>> +++ b/tests/f2fs/010
>> @@ -0,0 +1,68 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/010
>> +#
>> +# This is a regression testcase to check whether we will handle database
>> +# inode dirty status correctly:
>> +# 1. create a regular file, and write data into the file
>> +# 2. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
>> +# 3. write transaction data to the file
>> +# 4. rename the file
>> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
>> +# 6. drop caches in order to call f2fs_evict_inode()
>> +# It expects kernel panic will gone after we apply commit 03511e936916
>> +# ("f2fs: fix inconsistent dirty state of atomic file").
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_cleanup()
>> +{
>> +	kill -9 $atomic_write_pid > /dev/null 2>&1
> 
> [ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid
> 
>> +	wait
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +_fixed_by_kernel_commit 03511e936916 \
>> +	"f2fs: fix inconsistent dirty state of atomic file"
>> +
>> +_require_scratch
>> +_require_command "$F2FS_IO_PROG" f2fs_io
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount >> $seqres.full
>> +
>> +src_db=$SCRATCH_MNT/src.db
>> +dst_db=$SCRATCH_MNT/dst.db
>> +
>> +# initialize database file
>> +$XFS_IO_PROG -c "pwrite 0 4k" -c "fsync" -f $src_db >> $seqres.full
>> +
>> +# sync filesystem to clear dirty inode
>> +sync
>> +
>> +# start atomic_write on src.db database file and commit transaction after 3000ms
>> +$F2FS_IO_PROG write 1 0 0 zero atomic_commit $src_db 3000 >> $seqres.full &
>> +atomic_write_pid=$!
>> +
>> +# wait a moment to let atomic write starts
>> +sleep 1
>> +
>> +# it will dirty inode when updating i_pino
>> +mv $src_db $dst_db
>> +
>> +# wait for atomic_write commit completion
>> +sleep 4
>> +
>> +# drop caches in order to call f2fs_evict_inode()
>> +echo 3 > /proc/sys/vm/drop_caches
>> +
>> +wait $atomic_write_pid
> 
> So after this line, the $atomic_write_pid has been released. If so, how about:
> 
> unset atomic_write_pid
> 
> And then in _cleanup function .... (see above)
> 
> Others look good to me,

Oh, correct, will fix this. Thank you!

Thanks,

> 
> Thanks,
> Zorro
> 
>> +
>> +echo "Silence is golden"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/f2fs/010.out b/tests/f2fs/010.out
>> new file mode 100644
>> index 00000000..1d83a8d6
>> --- /dev/null
>> +++ b/tests/f2fs/010.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 010
>> +Silence is golden
>> -- 
>> 2.48.1
>>
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

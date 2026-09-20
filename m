Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA78C982D8
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ddbxMr91MnMfEp0RmMVZldduGAlpnDCJG332C+eNYh4=; b=eglUckArNASN92mS9qk7u2lDbW
	U3bcWu6NjvUoI2LKVbkQ1qle4Mb8lK8nZv/snRcTqlEWJ3e/SwCUDWyxsnN7ZrdmnRKSIes3a6KXB
	eaT6MwUNCDGKtJhjpJwgjGm1DfD8O/cc0d6+Q3esOJe3EGwPB4TrA2LAghXzxeGWgJ/8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8JVX-00072z-6Y;
	Sun, 20 Sep 2026 15:31:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1x8JVW-00072o-9C
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 20 Sep 2026 15:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q4nLN7EfIVyldgJNtOOhMXXxfy+CJZvXFpy9/BJDnjs=; b=K668eeXs+45ufhKkun7x6X5FMf
 buEmrLKY286dFqqChhdY/WULDCLQWlWdz0MzJZD+iHHBRSPp7T8+FU9gOyRMniMONK0dFBG0fKelG
 sVWpopM3T4QfrzVLfafKxeStwohrjM4A163Ob5G25SqAjY2sR2LHokfvXdELPaD7r46E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q4nLN7EfIVyldgJNtOOhMXXxfy+CJZvXFpy9/BJDnjs=; b=Tyqy8vSbHZEXhXOEnjur1hfUSx
 F4yVIX3VXBtr5+u0RjAb8WXUja4JtJvLXTUCtFpCfp824pUZP/ngSb9cgiXlxcNIEUprMxKON1FMy
 avBb4k45lf0BMpdvrNA4hFURWfmJdxc13ZnMLWWwyJeWmnHLLMp3SN8TxoS9OGGgrkDQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8JVU-0006Z7-5s for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 20 Sep 2026 15:31:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D2BE601DB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 20 Sep 2026 15:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59351F000FF;
 Sun, 20 Sep 2026 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789918262;
 bh=q4nLN7EfIVyldgJNtOOhMXXxfy+CJZvXFpy9/BJDnjs=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=oJ4FvcVw5KcvdlIC5PJ/sdTtUmsJ3JsUzKon0f0tW2e3+cNqp4P4sgnT+OU+lQdQw
 zzvzkaXSIYe+7YR48kZPXkZuLtxwfYQ+PbrUBZT+7XNSnYJp2ilQND4sTmcvJ4/tvX
 5SsdvNlVI3NrmTBX88WJbQoIwpdTeA86Y0a5Dn9agNKWPcDi/7JQkcj2sNvBTegMYR
 GuuxOgf8pkOVb+1ZwWIHNytVZTqRvDJqkM1nryYZ04IBG9v/0Up3nl/Nz2jAkmtirU
 Q97iUCbplZOeIK9/vK52XlBk1uYgU2/AhbFBhkl6F6kKpZlRCokmPoWAwb4/EBHt1E
 vVrhvWQJ+UpiQ==
Message-ID: <c83b7f14-fb4e-4a33-b56b-08b353f111de@kernel.org>
Date: Sun, 20 Sep 2026 23:30:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <7afe9c82cce1540ea0f8cc1f3d1306c24b6cc84d.1784949155.git.asj@kernel.org>
 <apc1uPbA2hKofHA6@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <apc1uPbA2hKofHA6@zlang-mailbox>
X-Headers-End: 1x8JVU-0006Z7-5s
Subject: Re: [f2fs-dev] [PATCH v8 11/13] fstests: verify exportfs file
 handles on cloned filesystems
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

On 2/9/26 04:30, Zorro Lang wrote:
> On Sat, Jul 25, 2026 at 03:39:08PM +0800, Anand Jain wrote:
>> Ensure that exportfs can correctly decode file handles on a cloned
>> filesystem across a mount cycle, by file handles generated on a
>> cloned device remain valid after mount cycle.
>>
>> Signed-off-by: Anand Jain <asj@kernel.org>
>> ---
>>  tests/generic/805     | 80 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/805.out |  2 ++
>>  2 files changed, 82 insertions(+)
>>  create mode 100644 tests/generic/805
>>  create mode 100644 tests/generic/805.out
>>
>> diff --git a/tests/generic/805 b/tests/generic/805
>> new file mode 100644
>> index 000000000000..5827eee039df
>> --- /dev/null
>> +++ b/tests/generic/805
>> @@ -0,0 +1,80 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
>> +#
>> +# FS QA Test No. 805
>> +# Verify that file handles encoded on a cloned filesystem remain valid and
>> +# resolvable via open_by_handle across a mount cycle and mount order swap.
>> +
>> +. ./common/preamble
>> +
>> +_begin_fstest auto quick exportfs clone
>> +
>> +_require_test
>> +_require_block_device $TEST_DEV
>> +_require_exportfs
>> +_require_loop
>> +_require_test_program "open_by_handle"
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f $tmp.*
>> +	_unmount $mnt1 2>/dev/null
>> +	_unmount $mnt2 2>/dev/null
>> +	_loop_image_destroy "${devs[@]}" 2> /dev/null
>> +}
>> +
>> +# Create test dir and test files, encode file handles and store to tmp file
>> +create_test_files()
>> +{
>> +	rm -rf $testdir
>> +	mkdir -p $testdir
>> +	$here/src/open_by_handle -cwp -o $tmp.handles_file $testdir $NUMFILES
>> +}
>> +
>> +# Attempt to read and decode the saved file handles on the targeted mount point.
>> +test_file_handles()
>> +{
>> +	local opt=$1
>> +	local when=$2
>> +
>> +	echo test_file_handles after $when
>> +	$here/src/open_by_handle $opt -i $tmp.handles_file $mnt2 $NUMFILES
>> +}
>> +
>> +# Setup base loop device and its clone
>> +devs=()
>> +_loop_image_create_clone devs
>> +mkdir -p $TEST_DIR/$seq
>> +mnt1=$TEST_DIR/$seq/mnt1
>> +mnt2=$TEST_DIR/$seq/mnt2
>> +mkdir -p $mnt1
>> +mkdir -p $mnt2
>> +
>> +# Mount both identical UUID filesystems simultaneously
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
>> +						_fail "Failed to mount dev1"
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
>> +						_fail "Failed to mount dev2"
>> +

>> +NUMFILES=1
> 
> NUMFILES=${LOAD_FACTOR} ?

Added.


> 
>> +testdir=$mnt2/testdir
>> +
>> +# Decode file handles of files/dir after cycle mount
>> +create_test_files
>> +
>> +# Cycle mounts and reverse initialization sequence to check if
>> +# file handle lookups are okay
>> +_unmount $mnt1
>> +_unmount $mnt2
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
>> +						_fail "Failed to mount dev2"
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
>> +						_fail "Failed to mount dev1"
>> +
>> +# Verify file handles can still be resolved post-mount-cycle
>> +test_file_handles -rp "cycle mount"
>> +


>> +status=0
>> +exit

Also this fixed to

_exit 0

Thanks.
Anand


>> diff --git a/tests/generic/805.out b/tests/generic/805.out
>> new file mode 100644
>> index 000000000000..29b11ec77ffb
>> --- /dev/null
>> +++ b/tests/generic/805.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 805
>> +test_file_handles after cycle mount
>> -- 
>> 2.43.0
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

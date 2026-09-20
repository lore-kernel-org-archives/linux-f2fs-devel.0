Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FF3C982D8
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 20 Sep 2026 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6lvAXQ6MIOmYvI/1QsjZbDe64335NbKYkrPoR14ICA=; b=O9DM8fyRksMbgCjsITYMhavlRr
	dcMH9uR/EfSTnVwR2xhl6bwvCDjtUDcUHVjAhoaiQ/bcdzU96zPerO2ir+T0dpEweK0T6HGC5WTOk
	exepTOAIZEoBmis2zJWZhVp3lvwVavDzQFUatK3fT0RDMDqe5ewSnzqgE/Fbyw2cIQw4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8IG0-0000p7-SE;
	Sun, 20 Sep 2026 14:11:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1x8IG0-0000oy-63
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 20 Sep 2026 14:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Y5xmyAmPfzgG3Q+Ybd8EMMKAncWD+ziq1NmXrhXuIE=; b=AIT8c8O67KKgR/7RV4XoJ1Q31g
 Cqxk5bG5PNHWbgBA6Vzl3hZ6soNDBAf/247gbbS+yZ0F9IxjHw90USy1w8t83uQsy23+FjheZL/Ad
 Al7y/QZnHSEi5u8S9VuZyEym6RM4m7I1ABKSqtjdmHBt/c2a02SnPX5vrWzOeW+akFpU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4Y5xmyAmPfzgG3Q+Ybd8EMMKAncWD+ziq1NmXrhXuIE=; b=EPhllWpmRZmyum8w5xRVGWSod5
 N0iIxsRGhd1ufhYYtqA6BoHpLCGvu7836qB5a/bvpy453J17IsKC4HiZBYGm3SZXgrSSX8Z/RRjUz
 Sv0QxRFvOL54XBztxdzOu8VTIcRnkJpm1oSV83OtvfjNgEul14e3ObTrHVm/KZFN2eNk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8IG0-0007gK-BP for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 20 Sep 2026 14:11:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1288443446
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 20 Sep 2026 14:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E3B1F000FF;
 Sun, 20 Sep 2026 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789913459;
 bh=4Y5xmyAmPfzgG3Q+Ybd8EMMKAncWD+ziq1NmXrhXuIE=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=Zpzlivn5YHXzw2m3lhoNF3WlqPj+Ww6xGHCjAVYPJn7Lrz1QeSs4sIZLUrUD9TCQA
 uetAm9hKTnngSemAups5ZMm3zeoWML4zKpy67oXZMNx/Gx1KB8oe3Qg+dniEycHniA
 3EJ0EX7hvPt0o9V7mIzrSRSPAS0umRLYVL6xx6AArfR7p/iHB1PLLW0O/1lpQsDZpb
 SMVSlzgeX2XISabvlaCx/JmE701XmRqaL3BZlD0EelevDmKk91x1UZLxgRrjGKEqWY
 jF+P+PM+nPsfmUP9Y/IDbLJF3zg2e/C0VGRzinXT8+PGDfiJv7qn2ktwSOem7eTToH
 Nenjy96o8K5Ig==
Message-ID: <e3aef511-a5fd-47ce-acf2-365cc58ba999@kernel.org>
Date: Sun, 20 Sep 2026 22:10:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <0e530686fa2bfb9a4b8ec4596484a4fec6d849e4.1784949155.git.asj@kernel.org>
 <apchlvgfbKJDX1rO@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <apchlvgfbKJDX1rO@zlang-mailbox>
X-Headers-End: 1x8IG0-0007gK-BP
Subject: Re: [f2fs-dev] [PATCH v8 09/13] fstests: verify libblkid resolution
 of duplicate UUIDs
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

On 2/9/26 03:12, Zorro Lang wrote:
> On Sat, Jul 25, 2026 at 03:39:06PM +0800, Anand Jain wrote:
>> Verify how findmnt, df (libblkid) resolve device paths when multiple
> 
> I didn't find the `df` test part in this test case.
> 

Hm, I think `df` was too basic and didn't add any real value, so I've
removed it. I'll update the changelog accordingly.


>> block devices share the same FSUUID.
>>
>> Signed-off-by: Anand Jain <asj@kernel.org>
>> ---
>>  tests/generic/803     | 72 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/803.out |  6 ++++
>>  2 files changed, 78 insertions(+)
>>  create mode 100644 tests/generic/803
>>  create mode 100644 tests/generic/803.out
>>
>> diff --git a/tests/generic/803 b/tests/generic/803
>> new file mode 100644
>> index 000000000000..77901592366c
>> --- /dev/null
>> +++ b/tests/generic/803
>> @@ -0,0 +1,72 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
>> +#
>> +# FS QA Test 803
>> +# Check if the mountinfo based findmnt would resolve to the common uuid
>> +# as per the blkid (libblkid based).
>> +
>> +. ./common/preamble
>> +. ./common/filter
>> +
>> +_begin_fstest auto quick mount clone
>> +
>> +_require_test
>> +_require_block_device $TEST_DEV
>> +_require_loop
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f $tmp.*
>> +	umount $mnt1 $mnt2 2>/dev/null
>> +	_loop_image_destroy "${devs[@]}" 2> /dev/null
>> +}
>> +
>> +# Normalize pool devices and mount points names
>> +filter_pool()
>> +{
>> +	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
>> +	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
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
>> +# Get the uuid from the source device
>> +fsuuid=$(blkid -s UUID -o value ${devs[0]})
>> +
>> +# Mount both identical UUID filesystems simultaneously
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
>> +						_fail "Failed to mount dev1"
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
>> +						_fail "Failed to mount dev2"
>> +
>> +findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
>> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> 

> findmnt -n (or --noheadings) can be used here (and below) to avoid piping to
> `tail -n +2`.

applied.

> 
>> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
>> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> 
> Same here

applied

> 
>> +
>> +# Btrfs assigned a random uuid for the clone fs before the fix.
>> +# Cycle mounts and reverse the initialization (source and clone fs) order.
>> +echo "**** mount cycle ****"
>> +_unmount $mnt1
>> +_unmount $mnt2
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
>> +						_fail "Failed to mount dev2"
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
>> +						_fail "Failed to mount dev1"
>> +
>> +findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
>> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> 
> Same here
applied

> 
>> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
>> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
> 
> Same here
applied

> 
>> +	
>> +status=0
>> +exit
> 
> _exit 0
applied


Thanks.>
>> diff --git a/tests/generic/803.out b/tests/generic/803.out
>> new file mode 100644
>> index 000000000000..3a130c662430
>> --- /dev/null
>> +++ b/tests/generic/803.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 803
>> +DEV1 MNT1 FSUUID
>> +DEV2 MNT2 FSUUID
>> +**** mount cycle ****
>> +DEV1 MNT1 FSUUID
>> +DEV2 MNT2 FSUUID
>> -- 
>> 2.43.0
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

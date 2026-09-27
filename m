Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC145C98324
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 27 Sep 2026 04:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eg9sqHki0+G8n7ouiOjU146Cp3oAKHhkmebF1wJ8aeA=; b=d/zXfxolOIX4OZ6hfQIUcIqnwo
	otFJj/aovf9A8yI38FC1LyGx2/3JngdyUCQpLi0GfeYdpFc6jXE0O4OpxOwCWbnsXT13dAr6KZ5fu
	ts1YBthzx0alhYAldG8k3WU6ZFIuDZxEQwMiu7VH/D7XcDc1Ub5VJebzqwjXHok1Sxoc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xAgiW-0002n4-Vb;
	Sun, 27 Sep 2026 04:42:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xAgi4-0002lE-08
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Sep 2026 04:41:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CwYGQ6//XvmoC9XXOlg9N3vwNJXULVBDjUKZ/NR5Jik=; b=Gwqv/MArolHbnk8Gn7mhMRSyNo
 Wnx4khIGmBSQ3COvGDdgBaIdpEkcnvJhQU3LTWANvrUX20JDJ9/djIE2nq3O19YXSnmdG27YdWUa7
 k07yWeoV7tiu2d7IzXFO/DAVCFWowkbA5sGn60a3+py2A0/wisiopOfPSTf9DQCZSUL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CwYGQ6//XvmoC9XXOlg9N3vwNJXULVBDjUKZ/NR5Jik=; b=WnJeKRj2oS0F5QF2Uh7vwcx4pK
 5LV1/o3Su5upUTUXfMxKfNHOLXaOfnrGAj8ho1WyGsDoWf+kG4lSuaE9D6qvCsirs2YKMxSSyJb2/
 Srnf97XXVbDmEL/I07PLpOFcFudKY0WWS78dgKTKW0GreDK8KrmJBTaslvZOj4x2H/MU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xAgi4-0003n2-5l for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Sep 2026 04:41:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA780413C0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 04:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BAE1F000FF;
 Sun, 27 Sep 2026 04:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790484110;
 bh=CwYGQ6//XvmoC9XXOlg9N3vwNJXULVBDjUKZ/NR5Jik=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=FmEWgzZu2iIqHudbnY7s4EIyHISO/RClDFhQxQNZXtJ4pl/jt2aDYBEGk4FK9GM3L
 ErcYKpXKJIIFSVE/7kLMOlXNhU2TRD+39u2uZ1qWtTzRyYgxOhQFIUcTVm8rKDlu4/
 mNpkOz/jakDzEH+WbC782JF0UrZzFPy42s472izsL9WAqBGbvuBt/JKC9+MlrziDCR
 jkpzzrofJI2seTLjHBZ0rJtKvQiDAzAZ8BZuEuk9KT0jq3fYM+0bSv47u1KHh08XsS
 M+PJx2hviLaPjYf8e7CTnrPIPi7zDEOiRFuuqbRnBTDfW9zkfOclwASFFtE+II8Rwj
 QME1smLnzWHAg==
Message-ID: <ea5b61d4-0cba-4afc-b5e0-8720d4717872@kernel.org>
Date: Sun, 27 Sep 2026 12:41:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
 <905a961a3bb2ec345285f056053e3016ad3bef6e.1784949155.git.asj@kernel.org>
 <apc5PMJFYtrUyG8U@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <apc5PMJFYtrUyG8U@zlang-mailbox>
X-Headers-End: 1xAgi4-0003n2-5l
Subject: Re: [f2fs-dev] [PATCH v8 13/13] fstests: test UUID consistency for
 clones with metadata_uuid
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

On 2/9/26 04:51, Zorro Lang wrote:
> On Sat, Jul 25, 2026 at 03:39:10PM +0800, Anand Jain wrote:
>> Btrfs and xfs uses the metadata_uuid superblock feature to change the
>> on-disk UUID without rewriting every block header. This patch adds a
>> sanity check to ensure UUID consistency when a filesystem with
>> metadata_uuid enabled is cloned.
>>
>> Signed-off-by: Anand Jain <asj@kernel.org>
>> ---
>>  tests/generic/806     | 74 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/806.out |  6 ++++
>>  2 files changed, 80 insertions(+)
>>  create mode 100644 tests/generic/806
>>  create mode 100644 tests/generic/806.out
>>
>> diff --git a/tests/generic/806 b/tests/generic/806
>> new file mode 100644
>> index 000000000000..6d3166491006
>> --- /dev/null
>> +++ b/tests/generic/806
>> @@ -0,0 +1,74 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
>> +#
>> +# FS QA Test 806
>> +#
>> +# Verify that the cloned filesystem UUID remains consistent, even when the
>> +# `metadata_uuid` feature is enabled.
>> +#
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
>> +filter_pool()
>> +{
>> +	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
>> +	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
>> +}
>> +


>> +# Create base loop device and its clone, applying the metadata_uuid tuning
>> +# callback to the base filesystem before the copy occurs.
>> +devs=()
>> +_loop_image_create_clone devs _change_metadata_uuid
> 
> Should we have and run a _require_metadata_uuid before changing it?
> As I know, btrfs can do `_require_btrfs_fs_feature metadata_uuid`.
> 

_require_metadata_uuid() is better than doing the same thing within
_change_metadata_uuid(). Now _change_metadata_uuid() calls
_require_metadata_uuid(), as shown below.


_require_metdata_uuid()
{
        case $FSTYP in
        xfs)
                _require_command "$XFS_ADMIN_PROG" "xfs_admin"
                ;;
        btrfs)
                _require_btrfs_fs_feature "metadata_uuid"
                _require_command "$BTRFS_TUNE_PROG" "btrfstune"
                ;;
        *)
                _notrun "Require filesystem with metadata_uuid feature"
                ;;
        esac
}


_change_metadata_uuid()
{
        local dev=$1

        _require_metdata_uuid

        case $FSTYP in
        xfs)
                $XFS_ADMIN_PROG -U generate $dev >> $seqres.full
                ;;
        btrfs)
                $BTRFS_TUNE_PROG -m $dev
                ;;
        esac
}



>> +mkdir -p $TEST_DIR/$seq
>> +mnt1=$TEST_DIR/$seq/mnt1
>> +mnt2=$TEST_DIR/$seq/mnt2
>> +mkdir -p $mnt1
>> +mkdir -p $mnt2
>> +
>> +# Get the uuid from the source device
>> +fsuuid=$(blkid -s UUID -o value ${devs[0]})
>> +
>> +# Mount both clone and baseline
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
>> +						_fail "Failed to mount dev1"
>> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
>> +						_fail "Failed to mount dev2"
>> +
>> +findmnt -o SOURCE,TARGET,UUID "${devs[0]}" | tail -n +2 | \
>> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
>> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
>> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
>> +
>> +# Cycle mounts and reverse the initialization order to ensure UUID tracking
>> +# doesn't mismatch or flip when metadata_uuid optimization is active.
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
>> +findmnt -o SOURCE,TARGET,UUID "${devs[1]}" | tail -n +2 | \
>> +				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
>> +
>> +status=0
>> +exit
>> diff --git a/tests/generic/806.out b/tests/generic/806.out
>> new file mode 100644
>> index 000000000000..918f422ecddf
>> --- /dev/null
>> +++ b/tests/generic/806.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 806
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

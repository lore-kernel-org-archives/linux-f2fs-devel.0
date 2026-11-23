Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CB606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QdfQEBDR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OFRdoqfx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DREVx9Vq;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObsSb+Cv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=A8plPJ3OJb8q1/JEpscTf6PWUXe37J23FZxrcfOgVn4=; b=QdfQEBDR+cIhL4
	J5HAXVhjTss2resp6dIDxXA5eZ2c+H+6PAORiG6IPMwkispCjBm9bGotYNszOlf8A2a9eU+ANie7x
	yW9ruJCiwul+RTILQL0pScvupywUqTNnEBmoFpV6XeLpLwpO5yHLXYjkpMHgjqTqnP0sf3NbzlmAt
	u5E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVJN8-000000003qn-2Zz5;
	Mon, 23 Nov 2026 02:01:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <asj@kernel.org>) id 1xVJMq-000000003pv-0Kkp
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 02:01:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m+gc+znZc0DYq0MzYS52FeXlxJDAFGgMkyRwnibnHlM=; b=OFRdoqfxaDCGUn6NAIEj+aIWSW
 eC8I6NVidU4miQq6uknyUvoW+wH1wWHvIf9wmj7gcYA+EJFFPSYZ+IxjCKDRFGsSec90ORPAhQTZo
 fkktVofdiwftZX1P10724ow+IAbBMq0VLgzhQNZvDb2TwHyk6/h7ccwcxWBkFHTeam9s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m+gc+znZc0DYq0MzYS52FeXlxJDAFGgMkyRwnibnHlM=; b=DREVx9Vq34OIv25LuhP6K4kPBg
 ikOvkM3FQoq71CTkMVlclFrZiM1mLv8vH15rAaEjar1fAcEZxWjBg4z4qaCJiywtGdKmzj4GTGLsn
 7fp+Oisz5IWfK/xwLe79+Sj3yz6nWIgJVyuGIAQarZx0shaOY9xZibiDJr//9NI4Oppc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVJMn-000000005Pk-1MEs
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 02:01:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA5C96122D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 02:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E04E1F000C6;
 Mon, 23 Nov 2026 02:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795399267;
 bh=m+gc+znZc0DYq0MzYS52FeXlxJDAFGgMkyRwnibnHlM=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=ObsSb+CvUC53o2tazBghu01uT+J9yR3VLwZ7GmvcOhHzyytJOMGBcUGOrB4OFcZJq
 ZkgqXr8f0jqSOAjLJpLZpjT1YBe8iRJNCelplysa/Ms4+s5NuN8yUUr5ZcASBPhHwU
 oTOtousKWDJg2UuxResC1TSNneVFiF3TYcdTSxGiNnjVkbw2JplywdCMfXCGaPyWIn
 CUegc3EfUoCaMnrKD4ctPfONutriIHzcBO9IvQK38Ri+qEFFvZfXuSdQ29EbeT5xSc
 DMM9ST3EpwWicTrN20MgfifP9+e6B0g88x04Jv/aq1uT7UUDCJbocSM5mOXPhGIXlF
 xoTGENrztTEOw==
Message-ID: <768152d1-4215-4f27-a3ca-50252c5b5d9a@kernel.org>
Date: Mon, 23 Nov 2026 10:01:03 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zlang@kernel.org
References: <cover.1791272793.git.asj@kernel.org>
Content-Language: en-US
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVJMn-000000005Pk-1MEs
Subject: Re: [f2fs-dev] [PATCH 0/21] fstests: tests for cloned filesystem
 validation and f_fsid
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Zorro,

 Could we merge the patches in stages? What's your plan?

Regards, Anand


On 6/10/26 16:55, Anand Jain wrote:
> This series continues the work from the earlier "test coverage for cloned
> filesystem ids" series (last posted as v8 [1]) and has been tested against
> the major filesystems: Btrfs, XFS, ext4, and f2fs.
> 
> Although this version incorporates the review feedback received on v8, it
> expands substantially with additional infrastructure helpers, an extra test
> case to cover the recent regression report, and migration/cleanup of
> existing generic/744. Because the patch count grew from 13 to 21 patches,
> disrupting the previous patch numbering and scope, I have reset the
> versioning and updated the subject line to better reflect the broader
> validation coverage.
> 
> The core motivation remains identical: testing that mounting a block-level
> cloned filesystem concurrently with the original filesystem behaves
> correctly across filesystems and VFS subsystems (fanotify, statfs/f_fsid,
> libblkid resolution, IMA measurement, exportfs file handles, and
> metadata_uuid handling).
> 
> Summary of major changes since v8:
> - Added 1 new regression test case to verify statfs f_fsid derivation against FS UUID.
> - Dropped the test case verifying f_fsid persistence across mount cycles on
>   cloned filesystems, as this assumption is no longer valid following the Btrfs kernel
>   regression fix [2].
> - Introduced common helpers:
>   . _require_security_ima() and _require_metadata_uuid().
>   . _scratch_mkfs_uuid() and helpers for f_fsid verification.
> - Migrated generic/744 to utilize the new common clone helpers.
> - Worked on the review comments.
> 
> Details of changes:
> - _create_cloned_loop_devs():
>   . Renamed from _loop_image_create_clone() to _create_cloned_loop_devs().
>   . Relocated backing image files from "$TEST_DIR/${seq}.*" to a dedicated
>     directory "$TEST_DIR/${seq}/*".
>   . Added internal call to _require_clone_mount().
>   . Switched from _create_loop_device() to _create_loop_device_like_bdev()
>     to guarantee identical logical/physical sector sizes (512 vs 4096)
>     between the original and cloned loop devices.
>   . Used an intermediate local setup step to ensure consistent Direct I/O
>     attributes across both loop devices (preventing the first device from
>     enabling DIO while the cloned device fell back to buffered mode).
>   . Added device geometry and DIO attribute dump to $seqres.full for debugging.
>   . Renamed teardown helper _loop_image_destroy() to _destroy_cloned_loop_devs().
> - _clone_mount_options():
>   . Renamed from _clone_mount_option() to _clone_mount_options().
> - _require_metadata_uuid():
>   . Factored out prerequisite checks from _change_metadata_uuid() into a new
>     dedicated helper _require_metadata_uuid() and invoked it accordingly.
> - _require_clone_mount():
>   . Introduced new helper to check kernel support for concurrent clone mounts.
>   . Removed obsolete _require_duplicate_fsid() in favor of _require_clone_mount().
> - _require_security_ima():
>   . Introduced new helper to check securityfs and IMA policy availability.
> - _create_loop_device_like_bdev():
>   . Removed unused local variable 'dev'.
> 
> - Test Cases common update:
>   - Adjusted test groups: replaced 'clone' with 'tempfsid'.
>   - Standardized test exits: replaced open-coded "status=0; exit" with "_exit 0".
>   - Dropped stale "_require_block_device $TEST_DEV" checks left over from before
>     migrating tests to loop devices.
>   - Percolated helper renames across all tests:
>     . _loop_image_create_clone -> _create_cloned_loop_devs
>     . _loop_image_destroy      -> _destroy_cloned_loop_devs
>     . _clone_mount_option      -> _clone_mount_options
>   - Added cleanup of "$TEST_DIR/$seq" in test exit/cleanup handlers.
> 
> - Test Cases Individual Updates:
>   - generic/744:
>     . Replaced _require_duplicate_fsid with _require_clone_mount().
>     . Migrated to common _create_cloned_loop_devs() and _clone_mount_options().
>   - generic/902:
>     . New regression test case added to verify statfs f_fsid derivation against filesystem UUID.
>   - generic/903:
>     . Added --noheadings flag to findmnt queries for cleaner output parsing.
>   - generic/904:
>     . Dropped 'auto' and 'quick' from test groups due to runtime and policy requirements.
>     . Updated referenced kernel commit IDs.
> 
> [1] https://lore.kernel.org/fstests/cover.1784949154.git.asj@kernel.org
> [2] 72de4807ba84 ("btrfs: derive f_fsid with dev_t only when temp_fsid is active")
> 
> Anand Jain (21):
>   fstests: introduce _require_clone_mount() helper
>   fstests: introduce _create_cloned_loop_devs() helper
>   fstests: add _clone_mount_options() helper
>   fstests: add FSNOTIFYWAIT_PROG
>   fstests: add _require_fanotify_function
>   fstests: add _require_unique_f_fsid() helper
>   fstests: add SEMANAGE_PROG
>   fstests: verify fanotify isolation on cloned filesystems
>   fstests: introduce helper _scratch_mkfs_uuid()
>   fstests: add helpers to verify the expected f_fsid
>   fstests: verify statfs f_fsid is derived from the filesystem UUID
>   fstests: verify libblkid resolution of duplicate UUIDs
>   fstests: introduce _require_security_ima() helper
>   fstests: verify IMA isolation on cloned filesystems
>   fstests: verify exportfs file handles on cloned filesystems
>   fstests: introduce _require_metadata_uuid() helper
>   fstests: add _change_metadata_uuid helper
>   fstests: test UUID consistency for clones with metadata_uuid
>   fstests: generic/744: use new helper _require_clone_mount()
>   fstests: generic/744: migrate to _create_cloned_loop_devs()
>   fstests: _create_loop_device_like_bdev() remove unused variable
> 
>  common/config         |   2 +
>  common/rc             | 262 +++++++++++++++++++++++++++++++++++++++---
>  tests/generic/744     |  72 +++++-------
>  tests/generic/901     | 142 +++++++++++++++++++++++
>  tests/generic/901.out |   7 ++
>  tests/generic/902     |  38 ++++++
>  tests/generic/902.out |   2 +
>  tests/generic/903     |  71 ++++++++++++
>  tests/generic/903.out |   6 +
>  tests/generic/904     | 113 ++++++++++++++++++
>  tests/generic/904.out |  10 ++
>  tests/generic/905     |  79 +++++++++++++
>  tests/generic/905.out |   2 +
>  tests/generic/906     |  74 ++++++++++++
>  tests/generic/906.out |   6 +
>  15 files changed, 827 insertions(+), 59 deletions(-)
>  create mode 100644 tests/generic/901
>  create mode 100644 tests/generic/901.out
>  create mode 100644 tests/generic/902
>  create mode 100644 tests/generic/902.out
>  create mode 100644 tests/generic/903
>  create mode 100644 tests/generic/903.out
>  create mode 100644 tests/generic/904
>  create mode 100644 tests/generic/904.out
>  create mode 100644 tests/generic/905
>  create mode 100644 tests/generic/905.out
>  create mode 100644 tests/generic/906
>  create mode 100644 tests/generic/906.out
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

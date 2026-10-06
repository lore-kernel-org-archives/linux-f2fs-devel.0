Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FC8CA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7vomE2x82PGNBeZLZWvmqbZJJlq70xcNrkWH3UUQX1E=; b=V+zp5IeZ32LkPRh0aqfce9APpy
	AnUT+2MCOUPkLLAYxVBeJ6g4YfoD9iM6MbHtifkbxMThRWb8k8/9D5LDHf3tEx4GgzZosxY5LsuOr
	wAqkmOU2ejXFxPuDWARor/uEO9ZtU6PAijtUN2IfZFny4CoOy7QXw5lEH8lTWrUosp6Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yC-0007cB-DV;
	Tue, 06 Oct 2026 08:56:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yB-0007c5-FK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=887Qidn2IRSbVRJeH3AxCvsj1VaDhX8Vn5amfqTDK7Q=; b=JsstcPZEfZZ2DCDBS90Noq7A08
 EQM2Jc9I3d59sOiZijGbXu9MvHamY5DA8rw8cLBpOT9H24xHgb9zF4uWNUhdZOwcv5U34sSxUEK5L
 NTXViEjXmJWKoNd1SkdSxNFgO3hnj7dgsU199e7QB0iluRfu5OWivhdD2zGKtLrYTVZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=887Qidn2IRSbVRJeH3AxCvsj1VaDhX8Vn5amfqTDK7Q=; b=Y
 LYVAq3Gc+bP98kRLz5g5uAyN4U5ausp65bamAphnehwjAqAVYHGo0iCGNRUKKJaCHQWrHI+KIAXiv
 wDzekS4uD6gtyDbCasb/fHDDwGNDtt3bsOE0Vje3/uNm1/nLxq5JoEzjzDFgN5oyn332b2uddgCUX
 Bjmmp5syEqOHPKnY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yB-00024G-E5 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 185BF413BF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEB81F00893;
 Tue,  6 Oct 2026 08:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276974;
 bh=887Qidn2IRSbVRJeH3AxCvsj1VaDhX8Vn5amfqTDK7Q=;
 h=From:To:Cc:Subject:Date;
 b=LUmk/2Zee1xt1ArSwUTbOuXhvYztZbP0+ykOMresbfu7ihWnjGspvwQQg2Ks9dN2I
 BJUlumreKETHpypw8uGQre65AkoBrNfPf4FuOrK0RCA2XdS7oeb39QIoxvbykEpjQk
 x1fq3bXJ1P0LGlcPNyJ4HaY3BwdBkekA2r3UgWdgCFr1DJqCwlDALH6WBmgwFlNTT1
 hlGSugz/GnTJzF0K3dk1I9dwXZYkzMfZ6x6ksoRwLRrH7S1Vlo91i0S1dm9HIZoJog
 gZS09tJHTSROJ80rJPwFoLD5r5pzD428LXO5pV6YJvDTZtSrtYspZPie+8NXV91wx4
 bc0bxfSbvQP/g==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:26 +0800
Message-ID: <cover.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xE0yB-00024G-E5
Subject: [f2fs-dev] [PATCH 0/21] fstests: tests for cloned filesystem
 validation and f_fsid
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
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, zlang@kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series continues the work from the earlier "test coverage for cloned
filesystem ids" series (last posted as v8 [1]) and has been tested against
the major filesystems: Btrfs, XFS, ext4, and f2fs.

Although this version incorporates the review feedback received on v8, it
expands substantially with additional infrastructure helpers, an extra test
case to cover the recent regression report, and migration/cleanup of
existing generic/744. Because the patch count grew from 13 to 21 patches,
disrupting the previous patch numbering and scope, I have reset the
versioning and updated the subject line to better reflect the broader
validation coverage.

The core motivation remains identical: testing that mounting a block-level
cloned filesystem concurrently with the original filesystem behaves
correctly across filesystems and VFS subsystems (fanotify, statfs/f_fsid,
libblkid resolution, IMA measurement, exportfs file handles, and
metadata_uuid handling).

Summary of major changes since v8:
- Added 1 new regression test case to verify statfs f_fsid derivation against FS UUID.
- Dropped the test case verifying f_fsid persistence across mount cycles on
  cloned filesystems, as this assumption is no longer valid following the Btrfs kernel
  regression fix [2].
- Introduced common helpers:
  . _require_security_ima() and _require_metadata_uuid().
  . _scratch_mkfs_uuid() and helpers for f_fsid verification.
- Migrated generic/744 to utilize the new common clone helpers.
- Worked on the review comments.

Details of changes:
- _create_cloned_loop_devs():
  . Renamed from _loop_image_create_clone() to _create_cloned_loop_devs().
  . Relocated backing image files from "$TEST_DIR/${seq}.*" to a dedicated
    directory "$TEST_DIR/${seq}/*".
  . Added internal call to _require_clone_mount().
  . Switched from _create_loop_device() to _create_loop_device_like_bdev()
    to guarantee identical logical/physical sector sizes (512 vs 4096)
    between the original and cloned loop devices.
  . Used an intermediate local setup step to ensure consistent Direct I/O
    attributes across both loop devices (preventing the first device from
    enabling DIO while the cloned device fell back to buffered mode).
  . Added device geometry and DIO attribute dump to $seqres.full for debugging.
  . Renamed teardown helper _loop_image_destroy() to _destroy_cloned_loop_devs().
- _clone_mount_options():
  . Renamed from _clone_mount_option() to _clone_mount_options().
- _require_metadata_uuid():
  . Factored out prerequisite checks from _change_metadata_uuid() into a new
    dedicated helper _require_metadata_uuid() and invoked it accordingly.
- _require_clone_mount():
  . Introduced new helper to check kernel support for concurrent clone mounts.
  . Removed obsolete _require_duplicate_fsid() in favor of _require_clone_mount().
- _require_security_ima():
  . Introduced new helper to check securityfs and IMA policy availability.
- _create_loop_device_like_bdev():
  . Removed unused local variable 'dev'.

- Test Cases common update:
  - Adjusted test groups: replaced 'clone' with 'tempfsid'.
  - Standardized test exits: replaced open-coded "status=0; exit" with "_exit 0".
  - Dropped stale "_require_block_device $TEST_DEV" checks left over from before
    migrating tests to loop devices.
  - Percolated helper renames across all tests:
    . _loop_image_create_clone -> _create_cloned_loop_devs
    . _loop_image_destroy      -> _destroy_cloned_loop_devs
    . _clone_mount_option      -> _clone_mount_options
  - Added cleanup of "$TEST_DIR/$seq" in test exit/cleanup handlers.

- Test Cases Individual Updates:
  - generic/744:
    . Replaced _require_duplicate_fsid with _require_clone_mount().
    . Migrated to common _create_cloned_loop_devs() and _clone_mount_options().
  - generic/902:
    . New regression test case added to verify statfs f_fsid derivation against filesystem UUID.
  - generic/903:
    . Added --noheadings flag to findmnt queries for cleaner output parsing.
  - generic/904:
    . Dropped 'auto' and 'quick' from test groups due to runtime and policy requirements.
    . Updated referenced kernel commit IDs.

[1] https://lore.kernel.org/fstests/cover.1784949154.git.asj@kernel.org
[2] 72de4807ba84 ("btrfs: derive f_fsid with dev_t only when temp_fsid is active")

Anand Jain (21):
  fstests: introduce _require_clone_mount() helper
  fstests: introduce _create_cloned_loop_devs() helper
  fstests: add _clone_mount_options() helper
  fstests: add FSNOTIFYWAIT_PROG
  fstests: add _require_fanotify_function
  fstests: add _require_unique_f_fsid() helper
  fstests: add SEMANAGE_PROG
  fstests: verify fanotify isolation on cloned filesystems
  fstests: introduce helper _scratch_mkfs_uuid()
  fstests: add helpers to verify the expected f_fsid
  fstests: verify statfs f_fsid is derived from the filesystem UUID
  fstests: verify libblkid resolution of duplicate UUIDs
  fstests: introduce _require_security_ima() helper
  fstests: verify IMA isolation on cloned filesystems
  fstests: verify exportfs file handles on cloned filesystems
  fstests: introduce _require_metadata_uuid() helper
  fstests: add _change_metadata_uuid helper
  fstests: test UUID consistency for clones with metadata_uuid
  fstests: generic/744: use new helper _require_clone_mount()
  fstests: generic/744: migrate to _create_cloned_loop_devs()
  fstests: _create_loop_device_like_bdev() remove unused variable

 common/config         |   2 +
 common/rc             | 262 +++++++++++++++++++++++++++++++++++++++---
 tests/generic/744     |  72 +++++-------
 tests/generic/901     | 142 +++++++++++++++++++++++
 tests/generic/901.out |   7 ++
 tests/generic/902     |  38 ++++++
 tests/generic/902.out |   2 +
 tests/generic/903     |  71 ++++++++++++
 tests/generic/903.out |   6 +
 tests/generic/904     | 113 ++++++++++++++++++
 tests/generic/904.out |  10 ++
 tests/generic/905     |  79 +++++++++++++
 tests/generic/905.out |   2 +
 tests/generic/906     |  74 ++++++++++++
 tests/generic/906.out |   6 +
 15 files changed, 827 insertions(+), 59 deletions(-)
 create mode 100644 tests/generic/901
 create mode 100644 tests/generic/901.out
 create mode 100644 tests/generic/902
 create mode 100644 tests/generic/902.out
 create mode 100644 tests/generic/903
 create mode 100644 tests/generic/903.out
 create mode 100644 tests/generic/904
 create mode 100644 tests/generic/904.out
 create mode 100644 tests/generic/905
 create mode 100644 tests/generic/905.out
 create mode 100644 tests/generic/906
 create mode 100644 tests/generic/906.out

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

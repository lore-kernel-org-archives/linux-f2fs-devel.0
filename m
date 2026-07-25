Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A307AC531F9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yVOw2yxUgZG16JV3LlI75/bu6WKYgJAYDK9+x266Fpo=; b=azFsKAtIH4FL+v7vfMynU559Iz
	rQ/6S5Qwy4FaA3zPasJ2QcbLpc0HFKRMaqstVJBW262SiodfW8zCB8ESCVh77ynIzpkZX/79bC4KH
	65bZHhaO6n6ZOmKvLlaorYKi+P0OYWPyercYelXFYPZSficBs194nGoRukd4cahWdBoM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnWzF-0001Dv-D6;
	Sat, 25 Jul 2026 07:39:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wnWyr-0001DV-Tt
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pj4RwUtaZyoGJA47a1bTHKUI+emrjLDYeojFHrfftF4=; b=BVWGP9MKx+RYl75CeWCWz5Q+m2
 Oka9l+/zqBDzT8SIgaC4cThMb17AoPftkOD9zq1N31mybqerOtrCf1h0dbM5n/XlKS29AOyfIr8kL
 0t9RO35ED8I6ETDr4Jz/8Jt1v87PRpJotL4KQlmsqmhxaPzzWxwyg+RuifgA1LtH9vlY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pj4RwUtaZyoGJA47a1bTHKUI+emrjLDYeojFHrfftF4=; b=O
 GnUi4KdPmTWXoslO33mU5Uc5xyE5WEhBeylRAaTZdg8LJ3EqclGjO0vNqzjjkdsPAy+k3dgWbQdT/
 g6RAXy/mcyUSMsdKLbRqz9pvq32akoj//x5Kmroac2Y3N6/7SFN1qxRTloNnKeTclPokV3TcnnzJ6
 x1VdFUzcyxjdH2Es=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnWyo-0001bo-Ng for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 199ED600FF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 07:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C83A1F000E9;
 Sat, 25 Jul 2026 07:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784965164;
 bh=pj4RwUtaZyoGJA47a1bTHKUI+emrjLDYeojFHrfftF4=;
 h=From:To:Cc:Subject:Date;
 b=oa1KqavFff3v/BrMasPTc1neKvEvW28DoJj+4CJSHZpc12JSrLcckfFtJKzfkTwT6
 tlXsw2yN4XROkcVYzGg+mzJKuDFn3YdYB6iL0vqM8C4Mg0HoCwfZdTYZPGp2/O1R47
 uUJPwnI+RdW26Ms5NSuOVVd5EwogP0MCyuq0ayKODYw9UyznkWrmVdWjNrwh12wAtI
 ZIO00cDK5iU9FRKHlFFtCVyrw7NkQTKH+aGarQ2I6F7yu6eMM0AysPuVPOLLFcCTUQ
 MKQgtohhkjdFc66pU0b5g343LjCtvuYrFlKLMXuziuNDupD8y58gTkhtv3Oo50N58j
 pmrpVZvw5UyNA==
To: fstests@vger.kernel.org
Date: Sat, 25 Jul 2026 15:38:57 +0800
Message-ID: <cover.1784949154.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wnWyo-0001bo-Ng
Subject: [f2fs-dev] [PATCH v8 0/13] fstests: add test coverage for cloned
 filesystem ids
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
Cc: zlang@kernel.org, djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

v8:
- _require_fs_space: double the required space (x2) to account for both source and clone
- Use proper quoting/unquoting for _mkfs_dev (Thanks Darrick)
- Call _fail() if cp fails
- _require_fanotify_function: check for kernel fsnotify support
- _require_unique_f_fsid: reorganize comments and replace 'if' with 'case' statement (Thanks Darrick)
- Add SEMANAGE_PROG variable (Thanks Darrick)
- fanotify verification: add checks for SEMANAGE_PROG and _require_fanotify_function
- Verify that the monitoring process is actually created

v7:
  https://lore.kernel.org/fstests/cover.1781694879.git.asj@kernel.org

v6:
  https://lore.kernel.org/fstests/cover.1779939330.git.asj@kernel.org

v5:
  https://lore.kernel.org/fstests/cover.1779367627.git.asj@kernel.org

v4:
  https://lore.kernel.org/fstests/cover.1777357320.git.asj@kernel.org

v3:
  https://lore.kernel.org/fstests/cover.1777281778.git.asj@kernel.org

v2:
  https://lore.kernel.org/fstests/cover.1774090817.git.asj@kernel.org

v1:
  https://lore.kernel.org/fstests/cover.1772095513.git.asj@kernel.org

This series adds fstests infrastructure and test cases to verify correct
filesystem identity when a filesystem is cloned (block-level copy).
Test covers inotify, fanotify, f_fsid, libblkid, IMA, exportfs file handles
and libblkid tools verify with metadata_uuid.
  New helpers:
   _loop_image_create_clone() and _loop_image_destroy() to help create fs and clone
   _clone_mount_option() helper to apply per-filesystem clone mount options
   _require_fanotify_function check if kernel supports fs notification
   _require_unique_f_fsid() helper to handle fs difference in fsid implementation

  New tests:
  - fanotify events are isolated between cloned filesystems
  - f_fsid is unique across cloned filesystem instances
  - libblkid correctly resolves duplicate UUIDs to distinct devices
    with and without metadata_uuid
  - IMA distinct identity for each cloned filesystem
  - exportfs file handles resolve correctly on cloned filesystems

Kernel Patches:
  Requires Btrfs kernel patches for all tests to pass.
   [1] https://lore.kernel.org/linux-btrfs/cover.1777281686.git.asj@kernel.org


Anand Jain (13):
  fstests: add _loop_image_create_clone() helper
  fstests: add _clone_mount_option() helper
  fstests: add FSNOTIFYWAIT_PROG
  fstests: add _require_fanotify_function
  fstests: add _require_unique_f_fsid() helper
  fstests: add SEMANAGE_PROG
  fstests: verify fanotify isolation on cloned filesystems
  fstests: verify f_fsid for cloned filesystems
  fstests: verify libblkid resolution of duplicate UUIDs
  fstests: verify IMA isolation on cloned filesystems
  fstests: verify exportfs file handles on cloned filesystems
  fstests: add _change_metadata_uuid helper
  fstests: test UUID consistency for clones with metadata_uuid

 common/config         |   2 +
 common/rc             | 135 +++++++++++++++++++++++++++++++++++++++
 tests/generic/801     | 143 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/801.out |   7 +++
 tests/generic/802     |  64 +++++++++++++++++++
 tests/generic/802.out |   4 ++
 tests/generic/803     |  72 +++++++++++++++++++++
 tests/generic/803.out |   6 ++
 tests/generic/804     | 108 +++++++++++++++++++++++++++++++
 tests/generic/804.out |  10 +++
 tests/generic/805     |  80 +++++++++++++++++++++++
 tests/generic/805.out |   2 +
 tests/generic/806     |  74 ++++++++++++++++++++++
 tests/generic/806.out |   6 ++
 14 files changed, 713 insertions(+)
 create mode 100644 tests/generic/801
 create mode 100644 tests/generic/801.out
 create mode 100644 tests/generic/802
 create mode 100644 tests/generic/802.out
 create mode 100644 tests/generic/803
 create mode 100644 tests/generic/803.out
 create mode 100644 tests/generic/804
 create mode 100644 tests/generic/804.out
 create mode 100644 tests/generic/805
 create mode 100644 tests/generic/805.out
 create mode 100644 tests/generic/806
 create mode 100644 tests/generic/806.out

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

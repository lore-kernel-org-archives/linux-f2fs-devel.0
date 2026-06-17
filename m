Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBA1CD98F1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3y5LNmkRTg9Htvbu4xx1DddThdk+njnVyYZB5F+w4nE=; b=b6COMNpgrPjFoIQ3aYMVitBoOm
	g2FzVijlVB/ao0uRzm+sF7scBxz6isXpnHDtENxR/O3ApPrrcgYNpvx4BwwSxIYP0H28jip31btYM
	m2dCTyYhfg/1NQL1Ch4oEJ3yhn2HkB7V+yaKu2zFgXXv32J7RwfSqxCm7B0fY7TDZl7E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZoKP-0004eB-2z;
	Wed, 17 Jun 2026 11:21:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wZoKO-0004e5-5b
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Zb3aYz8lZNlAUYkdsGBkMuML/PvX4Qn94h9tk/ibUs=; b=K3J+zUEbynBe4CWZ6aQijVFSfx
 QcgzP0KI5Al7Hy6exwHyyNY/hMevPqzBi484BGctoA+sFKtLvQh9pKoQ3clIvdBC0Zt5kDFEDrI34
 MJXI1xcFhGp9oiVHXvYcEE0yPNjRLKfSiMJ5QtYVhsfPl9C4XYWDVvPwi6swZn+6SeAY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7Zb3aYz8lZNlAUYkdsGBkMuML/PvX4Qn94h9tk/ibUs=; b=b
 AQjUyvyLHXfB+1YriZzmMQFoOgWIaTc7KgpwjKCZFVbj03uu7trFJga9y1M1UhR+Zha9mGGRhirdb
 YCklLQG6LIa6wo/K4Yl3OPAH6z/Oez0GYGJpVv/TUrFSk9VefHjVA5XYp4xY4y7hE2DdpZWkqv4+E
 xc3AmCREI2f9g2HA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZoKJ-0002ND-MS for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 792D360103;
 Wed, 17 Jun 2026 11:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3237B1F000E9;
 Wed, 17 Jun 2026 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781695249;
 bh=7Zb3aYz8lZNlAUYkdsGBkMuML/PvX4Qn94h9tk/ibUs=;
 h=From:To:Cc:Subject:Date;
 b=TUel3iRgpz+g6/pSUIKEmsCkC1dorn7sHn/tFQuj8/LbJULYUa/982I3kp3ptdhgY
 /JXJ3ky35/7RNB85s8VcbF7h+sdybpOfW5FfHWJGMhKrk/15KnQ0ioaN5m6t4Kc4P+
 kPavcJu4lJYoth+zzDDuMXbgZeYw2LglQnuB4rJL9V0QN3YibzPbiOzH6wGaryNZpl
 yvJnhcVIScWAAh0blg7YWToySUvBdc9H3Si0o1lt0y7QgF83743MuTO4VLA8fOW4V8
 8djm9FRw6KDFpwC+WabcPpkvT439Ppy3pD2CN2Mm/OhdMPApfgG5oLMKip+CZ4LYTg
 HjR7LpfIXWmAg==
To: fstests@vger.kernel.org
Date: Wed, 17 Jun 2026 19:20:27 +0800
Message-ID: <cover.1781694879.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wZoKJ-0002ND-MS
Subject: [f2fs-dev] [PATCH v7 0/11] fstests: add test coverage for cloned
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
Cc: hch@infradead.org, djwong@kernel.org, zlang@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

v7:
. 803, 806: Trimmed down the UUID checks to only what is required, mountinfo
   and libblkid.
. 802: Dropped the unnecessary echo statements previously used for logical
   flow in the golden output. On second thought, it looks fine without them.
. Swapped _fixed_by_kernel_commit for _fixed_by_fs_commit.
. _clone_mount_option(): Now echoes directly from the case block itself.
. _require_unique_f_fsid(): add the link to the ref. discussions.

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
   _change_metadata_uuid() changes the UUID before the clone

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

Anand Jain (11):
  fstests: add _loop_image_create_clone() helper
  fstests: add _clone_mount_option() helper
  fstests: add FSNOTIFYWAIT_PROG
  fstests: add _require_unique_f_fsid() helper
  fstests: verify fanotify isolation on cloned filesystems
  fstests: verify f_fsid for cloned filesystems
  fstests: verify libblkid resolution of duplicate UUIDs
  fstests: verify IMA isolation on cloned filesystems
  fstests: verify exportfs file handles on cloned filesystems
  fstests: add _change_metadata_uuid helper
  fstests: test UUID consistency for clones with metadata_uuid

 common/config         |   1 +
 common/rc             | 120 +++++++++++++++++++++++++++++++++++++
 tests/generic/801     | 135 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/801.out |   7 +++
 tests/generic/802     |  64 ++++++++++++++++++++
 tests/generic/802.out |   4 ++
 tests/generic/803     |  72 ++++++++++++++++++++++
 tests/generic/803.out |   6 ++
 tests/generic/804     | 108 +++++++++++++++++++++++++++++++++
 tests/generic/804.out |  10 ++++
 tests/generic/805     |  80 +++++++++++++++++++++++++
 tests/generic/805.out |   2 +
 tests/generic/806     |  74 +++++++++++++++++++++++
 tests/generic/806.out |   6 ++
 14 files changed, 689 insertions(+)
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

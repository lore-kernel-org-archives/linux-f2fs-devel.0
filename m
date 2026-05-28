Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4242CD6E45
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 May 2026 04:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PjklcypNvWjOy6dvRqzb+Y0Wd5DaT6TxEPU2jxK15UY=; b=SnP39XY6yV/aNd4t8fd/JMIkcH
	65B7MCYDUpLC3BdwjSZKPIdIs3CEgMBD/nZFZki7h9D5hcEr1t507mgZwHCFpSzsC3/eygE8wm/ah
	uaDD+nny/2sd2TTBS7+3xeQIU/54v4svnP5PdMRUgTwV4Il9SAso3uyP5z8ovZfyH/eI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSS0j-00025R-8Q;
	Thu, 28 May 2026 04:06:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wSS0i-00025L-Al
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 04:06:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CLUkiSIdhVjbGrdOUK5E/DEBmrwO/TzftuAwtmRq+Yk=; b=Lwbv5wMUyjwPZJ7ZTvkY5AlMIn
 WHdHr05DYeU2RBMAl52zuaR2nnkJm0OyzmJiaYctx+jsWnizoT1WWiPnw3VC/zla6M3EjUm+zrNmt
 wJrcdxbIZKED23ShvL/4maCuj6Fasj1ca0mWbk7BsFg5aEYmGmvalvDSTCNhDUjTpe+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CLUkiSIdhVjbGrdOUK5E/DEBmrwO/TzftuAwtmRq+Yk=; b=V
 rg3kfpZ75duEZy96Q1MvVxxh1p3ONPo2Yri+nr6Ob1SbGi5CvAM2JTYczq+gKnLJi8zMHtkFZD0zN
 4+rtqYvZJOJUQWjuwrkiDZ1uxqDka8sSQi/SDulHEnjfd5VbpB6rEKTL0mETYk3ud3sGkrkbzwZyR
 pExFz1s0/uPatq+s=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSS0d-00020w-Ne for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 04:06:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D7F8E4385B;
 Thu, 28 May 2026 04:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013811F000E9;
 Thu, 28 May 2026 04:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779941170;
 bh=CLUkiSIdhVjbGrdOUK5E/DEBmrwO/TzftuAwtmRq+Yk=;
 h=From:To:Cc:Subject:Date;
 b=ia9YxbI7iMZjO5I5NO8FW6Lsli1Unc6TEnlzXazf2uvMqs+5p1shgniqqT0eRkRik
 4TErZyek9i+fQUsZJB7PSttB2rNHF6+j86YSp/U6yu6rL1LT9m5MAZzwtqubGl2kkH
 L/CqVfQvpyR1LW7dmxK4CEad/ES1s0Syg7AwFmmpuUcgGQtKGNYlJX4U6SlfJLncFH
 Eow44MPvrNbVEJSMFuaLm7jDXJEIamwiwgv/KWzSlpf3/mjrqACYZ81bezdT3zRgbs
 0l19cnlwnf/qRC/4XKJXG05qW63gLMDN8mQq7dIIcd228CDGigcdAk8fEBVFmP+NGA
 Cfw7v/wpgJypw==
To: fstests@vger.kernel.org
Date: Thu, 28 May 2026 12:05:31 +0800
Message-ID: <cover.1779939330.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wSS0d-00020w-Ne
Subject: [f2fs-dev] [PATCH v6 0/11] fstests: add test coverage for cloned
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
Cc: hch@infradead.org, zlang@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

v6:
. Renamed `pre_clone_tune_uuid()` to `_change_metadata_uuid()`.
. Created the `_require_unique_f_fsid()` helper instead of handling it inside the test case (patch 5/11).
. Separated `FSNOTIFYWAIT_PROG` into its own patch.
. Dropped the `inotify` test case in favor of `fsnotify`.
. Added comments throughout, especially for helper functions.

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
 common/rc             | 124 ++++++++++++++++++++++++++++++++++++++
 tests/generic/801     | 135 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/801.out |   7 +++
 tests/generic/802     |  67 +++++++++++++++++++++
 tests/generic/802.out |   7 +++
 tests/generic/803     |  84 ++++++++++++++++++++++++++
 tests/generic/803.out |  19 ++++++
 tests/generic/804     | 108 +++++++++++++++++++++++++++++++++
 tests/generic/804.out |  10 ++++
 tests/generic/805     |  80 +++++++++++++++++++++++++
 tests/generic/805.out |   2 +
 tests/generic/806     |  84 ++++++++++++++++++++++++++
 tests/generic/806.out |  19 ++++++
 14 files changed, 747 insertions(+)
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

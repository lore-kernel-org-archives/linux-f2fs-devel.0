Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CADC53219
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=glGpM4kpQevjgvu+GXHbQZaFUPUgJAuFVa5Xe2oi50E=; b=I67f2B77WmHpcDBPKgcdYdNSPw
	r6Di6VZAFYsifspliG61LWSGoNuuEcwNUjC+zM5fJxkhIZnKJLDAEAMfUwbecgDZoE5Ua/7zYxFDx
	v+z5QPvfrpg9nfu7Ps2QYb6v+8xuGlRV+Qn/ud0KiaemXhN3TW9UdXfYbPrJrVqubpDw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnWzG-00033i-Px;
	Sat, 25 Jul 2026 07:39:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wnWz7-00032r-OY
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mRZi9Vfr+5T/gOdThVCpmuf5WVpFWTSa3j7CdZPm880=; b=JeRx6o/Ws8TfaLsZnhSINtrsWN
 T+QrySCIQGf1PhG0Rj8TmUir4uQ0M7pG3eAcE8oo9cBsud+86epSd50FJ0SmQB/2F8pKKllZz0vGB
 W6JJdikmxLy1O63q+JQsqYTF0uMyUSRxtxd8rkNLaF0btyJb6QXWxUlyNZsLJVRIQbGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mRZi9Vfr+5T/gOdThVCpmuf5WVpFWTSa3j7CdZPm880=; b=FD/f4q4cVDxOrYdh69yeZnAGRn
 M8JhcTd6QDK0zJQ4Qx97z5z01AnjqXyBRcPiNTxq6hxStENstbeusJSHCYnDIOtUkUSAiC+iIC9Zf
 wiFVEDiqt+FOqBlW4tj8HayAIWOHDK383eiA/kzwNlZ1X1EcKoTO3ils+8O0tP//oGh8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnWz7-0001cD-Vf for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AED1740E3D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 07:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34711F00A3A;
 Sat, 25 Jul 2026 07:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784965184;
 bh=mRZi9Vfr+5T/gOdThVCpmuf5WVpFWTSa3j7CdZPm880=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IEpQWLi63DihQWPfdLmhMmIcrNPoZswCEvxSc+yrUi3JzpbCG6/RTm7n0GgvVmbaZ
 ZDIvo3asJ+B1jIYoMdrTTKLF5t1+gBlqsv8v7ilbpCy4wTuX/5bTJqD/p+CS5Je+3N
 TVhfEbyyNV8l8p4tMzr0XsQZmh/sDZgbxk1U8gt9xr1KlYGh4w8Jrk5AFBuDfcPhHZ
 9k2HWUNP19cBNRl/76IibVuDYPFDxyBS0/YOiJyNHr8nuxzxpIdKzEO+gY17qMgBqe
 BxmcyP99COCE6YW6r7QA5GLpYw1K9EZA0P8MsVG7e2Ix+z9uNr4CDYIXGNEPfkjqlW
 mVPHkEyYirNNw==
To: fstests@vger.kernel.org
Date: Sat, 25 Jul 2026 15:39:02 +0800
Message-ID: <878a21ea507cb955ed414072c82ab5e5493b8ae0.1784949155.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784949154.git.asj@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wnWz7-0001cD-Vf
Subject: [f2fs-dev] [PATCH v8 05/13] fstests: add _require_unique_f_fsid()
 helper
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

Add a helper to check if the target filesystem supports unique f_fsid
tracking across cloned or snapshot instances.

Certain filesystems like XFS, Btrfs, and F2FS ensure unique f_fsid
identifiers per filesystem instance. However, Ext4 derives its f_fsid
directly from its superblock UUID, which leads to identical f_fsid
values on cloned images until the UUID is manually modified by userspace.

Introduce _require_unique_f_fsid() to allow test cases requiring strict
f_fsid uniqueness to skip gracefully on unsupported filesystems.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/common/rc b/common/rc
index 21b516accdf7..f73251365a60 100644
--- a/common/rc
+++ b/common/rc
@@ -6356,6 +6356,33 @@ _require_fanotify_ioerrors()
 	_notrun "$FSTYP does not support fanotify ioerrors"
 }
 
+# Skip the test if the filesystem does not enforce unique f_fsids
+# natively. Checking this dynamically requires recreating a clone
+# layout, so we use a static lookup based on FSTYP.
+#
+# Across all filesystems, a UUID collision causes libblkid tools to return
+# non-deterministic device mappings. It is ultimately the responsibility
+# of the userspace utility or use-case to enforce uniqueness when a clone
+# diverges. For details, see mailing list thread discussions:
+#   Link: https://lore.kernel.org/linux-ext4/20260409131238.GC18443@macsyma-wired.lan/
+_require_unique_f_fsid()
+{
+	case "$FSTYP" in
+	ext*)
+		# Ext4 derives f_fsid from the superblock UUID, meaning
+		# clones share the same f_fsid until their UUIDs
+		# diverge.
+		_notrun "Target filesystem ($FSTYP) does not guarantee unique f_fsid on clones."
+		;;
+	*)
+		# Conversely, XFS, Btrfs, and F2FS ensure f_fsid remains
+		# unique per filesystem instance (often by deriving it
+		# from the UUID and underlying block device.)
+		;;
+	esac
+}
+
+
 # Computes a percentage of the available space in a filesystem and
 # returns that quantity in MB. The percentage must not contain a percent
 # sign ("%").
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

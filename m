Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91FCCA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J6vJq9cpRny2wSgnKZwqR39Q0N/KuUu339pnjWcgmyU=; b=AFbfcgbWAQC1Wbg1oXb/8VsJAj
	vqeH+W7qKB5nV+eKNVI2sfhfQcfNkl5Wo1CPKCXllylvzD4W1f43gugmBYkhsDjTiK84lspS9Qe+A
	qPG4PMztOrkzxBDeFCfF/6e5PFxCczZyMFuwkJIOSsa9LLigu64LZxjqRQf346K6TLHo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yS-0006lO-PL;
	Tue, 06 Oct 2026 08:56:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yR-0006lB-E7
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WjebKDy45J5TQr0OIERHkGZV6V7teaZQJbQI7nWpxe0=; b=Y6YoDMfr5R9wMCRrs1CaiDVfWo
 4Gi1K2MZVsuf7fuzmSfiq4Lw3O506rVb9NQYcuCFBpddarfAoH6vXm7OOVxjZKgBvNM5aDDqqgTit
 0r0jz4fmZ2bl6n7QB0d28stufY8ExOZ7gPk/Xgvy2Vk8K/TOm8aTmHBFQ1iRIObvDSDI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WjebKDy45J5TQr0OIERHkGZV6V7teaZQJbQI7nWpxe0=; b=gdthDXsFn76TLQJCS7sE7rf7rL
 0diiBwoTdkoSxC/JC8pbqVlktb9XmogFAaKhiUjlBI1/UngaPoj85Nk3ckNeJdiPOdMbJSz5YT7bT
 q0ZFVMpTsImMooCpZ9TE6uZph2azS60SfedaFOgUI1146NiV5aoOiILI682wO+XTFzBM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yN-00024k-KZ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5626043590
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61601F000FF;
 Tue,  6 Oct 2026 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276986;
 bh=WjebKDy45J5TQr0OIERHkGZV6V7teaZQJbQI7nWpxe0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fkgIkopWJaxkWXL1RvpkMVH3L7JIPGgrMUhqgcmN66ujYc3wgeVHN9QxC8krQ868z
 koqMTc71K7KWNJQR5yzZ8ddGPHYYrtQGMYUkgObEPVGvONtnfIg2Bjt8heXwPJj3/o
 xomO6fvsR1N29uuZfauu3srLy4yM2JU71J+QMCm2ei1xaFYgGf2XszFICAByfXFE2t
 GAPiwWl+yAGH5mWKpNGM3GjOxd0iruDL3DFzTq03I2mTmBkk2021UvcAOQor7anfCG
 TDwo+ZMGNZHwZl/HrKfhisI18Jg/zW6sn14E5Y9a4rADYPQUYs6KznKoyzwmf3S2Mu
 SeGw7KFrtW5+g==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:32 +0800
Message-ID: <523304ad35666548443b910955ae7d3a1669ae5a.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yN-00024k-KZ
Subject: [f2fs-dev] [PATCH 06/21] fstests: add _require_unique_f_fsid()
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, zlang@kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
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
index 0fcc1a614ad1..37b32b498c80 100644
--- a/common/rc
+++ b/common/rc
@@ -6417,6 +6417,33 @@ _require_fanotify_ioerrors()
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

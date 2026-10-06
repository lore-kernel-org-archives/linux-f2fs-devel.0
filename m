Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29799CA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iZxRupfBU2DV0Hck7DjYVVFLAFDP/WK6mrszNGL7J70=; b=MDbKuy8aH0v4qyVBSFxnmx5afa
	PBvJhUcV4uG8lPy7b7c307kc5iLPVkBqmxxwNrYfZ/tMohNPtX3/k597E09xs0QkMoiPzSBm3qZTm
	c9+CO4rvzrL0IBJ368k9T4njraf2s16xp7jN7WA1q9tmd9NOLkid8d+P8RE+4Iqwn4Lk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0ya-0006n5-Ec;
	Tue, 06 Oct 2026 08:56:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yZ-0006mp-Un
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BD6FjAil+klUl/B92wFX4626qlQPjWtPvce521aRaFc=; b=QvKrstOD5xFJS8rLwRrO3PUJ2W
 PuqQrQLO7YzUkzKb3tRq9MB0V2eXxaizmC5yf2RpF7EM/68cytXCMW6Cwv2RC1JV5LRrvz6OrkzzP
 lUa65yjwIgt+/avJhxaEecbVfaheVxIsURgemd8pCIfXzF9DpizmhwYzsB5AnCXTEShM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BD6FjAil+klUl/B92wFX4626qlQPjWtPvce521aRaFc=; b=bGel4Mu2X2IDd5Gsf8dNq4cTGe
 FmY7x5Mx8jY97bTk25Kc6AlSpTmgriDEEeBdS/WAkX41fFsem4Q+doKdx2+pb7+mHJfbC3Km2MR7k
 Hz/0Nev8wzu/ZE6dEsVitrPTv5N1Q6cojEvtBGgzaKjEwHomkiFCMqPF40Lhejh4nrLo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yV-0000Lp-OC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71C8843D96
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70C11F000FF;
 Tue,  6 Oct 2026 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276994;
 bh=BD6FjAil+klUl/B92wFX4626qlQPjWtPvce521aRaFc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GppjjWuCx65jeD0IRgXCGIUHvEC6MoPtu4ymvdD1mqTDYG59a9/gIYodZCLlKi9IX
 5sKNMKi7SlU7GZQ9P1I8ojiWactOOrmnkh/LaYg+0+TiKsdT7vxhd4rIg+1I46vHKi
 dCRmnDnNMNT6mcc2qYQ0Yj3rD7dCfxsOcH1kdCzhc0MFNmrOedSY8PcNUJb1FDvb7Y
 /XLMrEBNNkPC6ewlxZ5IIg3RcyWF72Fy3bZeVRUpYajfz2o6ttk+5vdTlyp5X314nw
 diyLP7NyEbGmUcRz+bvgldKPzJ1k3cXaRsMlsOxCnpIFNgl368CwQGOUr2ptqljD9N
 T4/f8RP2veYgQ==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:36 +0800
Message-ID: <d33f55ca2c1b13426dd27c1c9921b2a60c3afbf2.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yV-0000Lp-OC
Subject: [f2fs-dev] [PATCH 10/21] fstests: add helpers to verify the
 expected f_fsid
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

Add two helpers to common/rc:

_require_uuid_based_fsid() skips the test unless the filesystem derives
statfs f_fsid from the UUID alone (currently btrfs and ext4).

_scratch_expected_fsid() prints the f_fsid expected for a filesystem
created with the fixed test UUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/common/rc b/common/rc
index 37df780f64ef..a11235ec03b8 100644
--- a/common/rc
+++ b/common/rc
@@ -6065,6 +6065,37 @@ hexdump()
 	_fail "Use _hexdump(), please!"
 }
 
+# Require a filesystem whose statfs f_fsid is derived from the filesystem
+# UUID only, so that it is stable across devices and mounts.
+_require_uuid_based_fsid()
+{
+	case $FSTYP in
+	btrfs|ext4)
+		;;
+	*)
+		_notrun "Require a filesystem that derives f_fsid from the UUID only"
+		;;
+	esac
+}
+
+# Print the statfs f_fsid expected for a filesystem created with the test
+# UUID 12345678-1234-1234-1234-123456789abc.
+# Must be guarded by _require_uuid_based_fsid.
+_scratch_expected_fsid()
+{
+	case $FSTYP in
+	ext4)
+		echo "4c44000088884c44"
+		;;
+	btrfs)
+		echo "444c444c888d"
+		;;
+	*)
+		return 1
+		;;
+	esac
+}
+
 # Try to create a file with inode->i_blocks >= (length / blocksize).
 # There may be some small overhead, e.g. ext2 filesystem allocates a
 # substantial number of blocks to store block mappings. Those are accounted
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

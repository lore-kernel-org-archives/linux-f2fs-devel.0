Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8034DCA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H52DVkoTqOmE5Pp2C20fGwacA6+Wj86pRrcwE1o0c2w=; b=cqcNDTmgrlfBpne6kCd41QJ3hj
	k/EbQEpapqye+NhopgQt/DL5i12MoXTRnqYoZb9ob/FsgArpfeVxaf5FK9Tf8CyJ4H/iwZfNDEDSC
	x+TJKpE32/uKCJDXgU8Qy/XBtMANM5LT6X/AVPG/lnfrVCVd7aYbbX3voNouqeJkI9O4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yG-00065K-TS;
	Tue, 06 Oct 2026 08:56:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yF-00065D-Gp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ad31bi0Kt9xB6EotHGgbdirc7R49xwpFGiQK9AS1wLk=; b=IRuDNncoREXsMWqbzOrB/xYDkT
 fzKKwYbffWv78FLjPyNACTjPmb47aqrOIYdqL7w/Ak1Pt866bvzjlN3HGX07CkWLeFOCR3FPbs+0D
 +tMi9RWmpYMFZQcqXOnFNUKGFzqn9ncD2+FGrr9nbbyQLMfgjuMhK7RsFM1beI8Ecpj8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ad31bi0Kt9xB6EotHGgbdirc7R49xwpFGiQK9AS1wLk=; b=fZYjDe/hAarmDGUNpknpApSu6l
 yMPoOXubo5KXqUeCSdRtBEYq37N0RV88tIVZmbLc5mANbDJ+fgl9Wip2d2wNrRKr02PHCHdmLOsCO
 ESezLtlmB/Wj4XXfgvmvorjLnB4+VMwVpGemGlv8VaqEGknWfh39ADIWkF6TjyjewNLY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yD-0000L3-T4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A92F6022A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ED11F000FF;
 Tue,  6 Oct 2026 08:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276976;
 bh=ad31bi0Kt9xB6EotHGgbdirc7R49xwpFGiQK9AS1wLk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lb+VdIGRkvZV+gQbZkJziy5TSW7MtwzUqcWWxQKwM7phfsAJCxxtbXK3i3yMuT3FU
 hsSorhmZKvf4FWpJrc9Df7LMRFOfQPTHoI1KTKKEMRkjdda1fpYkiJldpSijrBw315
 IPSbc3psNdih4xNcu67/yWUZT+JVKgmo3dckhJQYVHsvbmD820VoAfbZcnb7noivAR
 pF5c85fKdJnqFa8oN0M2KaNAdpg98Di4ZSoSWpRMi1kjG1U2ooL3JnGASr3WrVZcIG
 YJrzLEIbvdnuZbmK6j/1sgva4wVTu5cL3ccs8JAqNEsSsP2rLZlxUFs4qKNd2cuny3
 w3GtBBqZurFAA==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:27 +0800
Message-ID: <245314b2efd616b7ecf09f74e2a775e44e10ab43.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yD-0000L3-T4
Subject: [f2fs-dev] [PATCH 01/21] fstests: introduce _require_clone_mount()
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

Add _require_clone_mount() to common/rc to check whether the filesystem
supports mounting cloned block devices simultaneously. For Btrfs, it
verifies kernel support for the temp_fsid feature, while skipping
unsupported filesystem types with _notrun.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/common/rc b/common/rc
index 3958ac934980..7868e6d311a2 100644
--- a/common/rc
+++ b/common/rc
@@ -6124,6 +6124,21 @@ _force_inplace_writes()
 	esac
 }
 
+_require_clone_mount()
+{
+	case "$FSTYP" in
+	xfs|ext4|f2fs)
+		# No kernel-side restriction; always supported
+		;;
+	btrfs)
+		_require_btrfs_fs_feature "temp_fsid"
+		;;
+	*)
+		_notrun "$FSTYP does not support mounting cloned devices simultaneously"
+		;;
+	esac
+}
+
 # Test that a filesystem can do writes to a file in place (without allocating
 # new extents, without Copy-On-Write semantics).
 _require_inplace_writes()
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

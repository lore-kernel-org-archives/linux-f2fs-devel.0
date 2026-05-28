Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E08CD6E49
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 May 2026 04:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uBc1ofX/QyRw7kgks+voIyiX50oLEUHPP9jOAP/Xlvs=; b=Xl23nM+BxMXc37UoHx2eLstETS
	qlrNY6eJ8QzeLjgR7S1OwsQ1vB1GtmsO9+EQe4pK//XLGL39fPs2UoeNofPW8HVCkkZ9EbbwTyvBv
	YaRgbK5IkXWJVu0M43n4uBWOgNuxXX5TmWDqmYUNAZpVresVYr6JvGXrnoaMnMLlarzY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSS17-0000lv-GX;
	Thu, 28 May 2026 04:06:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wSS16-0000lm-3b
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 04:06:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7n0Nsl40Fw8pzsga6mqykSNEctGK2l6RNst2Rut9Pjo=; b=WrYxIhxGixUKLWN8ygk0IyEWh4
 0tNfwFQcJsl7SPrkJQOVWrb4hwprOeeYYR1ey/R41E+FTS0eHQKEMeEU7DWUCM1iP3N3s7JxZIKaQ
 EdPjSQfHNGGY294JDwVB7PzxKlCGxoKZHPSun6NFeGY7XRPjkpPLOgfLqlIDg+EteQ4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7n0Nsl40Fw8pzsga6mqykSNEctGK2l6RNst2Rut9Pjo=; b=dTRSNuK8PI7WF2/ZmpRYisws7M
 l30zCa6OrbHL4lzlNC25hTlQ9hztuGBvC0MJKGIkH9xZRAtP7es8UPLalojnbQNegdooNJvCRG32i
 08PqNhJZ4Bn51NvYH0UBXOcsOc1SSrFX2gRrHEeepwqHDUMCcHFM46VOCJA5PnBLslG4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSS15-0002Cn-Su for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 04:06:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA89B605C2;
 Thu, 28 May 2026 04:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B506E1F000E9;
 Thu, 28 May 2026 04:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779941193;
 bh=7n0Nsl40Fw8pzsga6mqykSNEctGK2l6RNst2Rut9Pjo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nZexiFWLnDTo2Fh7TyZ/Q0NPjoqk4hrd3g2PYPWoFiN/0weGUYii5ltA+VtV6aKWO
 IQeAuHmU2kKV2mpc/da8GWjaJN8y1QQUrfKt0GaqKfChHvND7fkX3p+8Tbyx+8wbLQ
 ettTJI6/63vCgDjDTcy0VkDwlN/F5K3rfyQuM2hHZSWmfx/pNWKpWZB5Dv6fcvWR4d
 CWJfOD8NjLPvRT86kM9mg4Bg6zD06BrRhTtnlGHinhvyjhoiZARGmv4UlqSA6D56t1
 8K0utVSsjoSJygLq+5e5ZJ6pIB+tJkKaaY1XmT+Ak3dabWZb0mIzDDosofZdaTaafw
 Mm6dEs1rt7eCQ==
To: fstests@vger.kernel.org
Date: Thu, 28 May 2026 12:05:41 +0800
Message-ID: <c906338d34767c8f244171e0cf87558c19cdeab5.1779939330.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779939330.git.asj@kernel.org>
References: <cover.1779939330.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wSS15-0002Cn-Su
Subject: [f2fs-dev] [PATCH v6 10/11] fstests: add _change_metadata_uuid
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
Cc: hch@infradead.org, zlang@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

_change_metadata_uuid changes the UUID of the golden filesystem before it
is cloned.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/rc b/common/rc
index 5446552aed92..79be51e4da31 100644
--- a/common/rc
+++ b/common/rc
@@ -1537,6 +1537,29 @@ _scratch_resvblks()
 	esac
 }
 
+# Change the metadata UUID of the given device to a newly generated one.
+# Args:
+#   $1: Block device path to modify.
+_change_metadata_uuid()
+{
+	local temp_mnt=$TEST_DIR/${seq}_mnt
+	local dev=$1
+
+	case $FSTYP in
+	xfs)
+		_require_command "$XFS_ADMIN_PROG" "xfs_admin"
+		$XFS_ADMIN_PROG -U generate $dev >> $seqres.full
+		;;
+	btrfs)
+		_require_command "$BTRFS_TUNE_PROG" "btrfstune"
+		$BTRFS_TUNE_PROG -m $dev
+		;;
+	*)
+		_notrun "Require filesystem with metadata_uuid feature"
+		;;
+	esac
+}
+
 # Create a small loop image, run an optional tuning function ($2) on it,
 # clone it, and attach both to loop devices, returned in ($1).
 # Args:
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

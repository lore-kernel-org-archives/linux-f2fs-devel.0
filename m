Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2742CA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jl9/iviKGfGxeWQd1AuBM/04+9tQujiLJdObNApyJ48=; b=BgqkVItQhZrxNCSQW7DhPg2KM+
	Stzx2sN/GaRjououEcCIAjJcYRE9ywnniRM8d2Rt2y1Ec0q+H48+pqQEoXGkP5By0DLiTByYtOLez
	dJGkwriRMbSohWTH71WIvrqeEnzf7I6oTzMpxi4uPAjxQdduGxqjSfxuhQDXdXDbAesM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yK-00027p-D2;
	Tue, 06 Oct 2026 08:56:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yI-00027h-Gl
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j7fMyiLEWqhuLHjASayvGfGl8dCR3auJbWrfl9uBIzg=; b=BL2sy6B9jy6swWCm6MEvjBvUAf
 7GHaOfl+zHCbklCXXPq2PQA0rrGKfdPzCqHcyqw2WpYUuDUoE4sPeOy9fojTTbVBU87kIkDVfgC9P
 gqduTSwdRQrSihs41svjX4AgWtCPOuGB8hqMqcqDRCVK33D113FrGfCwM0uLT2iqWFjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j7fMyiLEWqhuLHjASayvGfGl8dCR3auJbWrfl9uBIzg=; b=EDF9L62SstEN5dSxKVQvkBIMbu
 JaPIPRrlT/S9BvqOSbZoZafT+KySRqsPFxX1gwEktwpnv2+EmE5tQGsELeuo4JndK4gSQ4GVjT8Nt
 ys5RQsA8lw58RfLvO9VaUEfZ9j5BqXjwtUUE7N5I6q4qDuIMiwy969QpHT6/cq8hlXI4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yH-00024Q-UE for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 590876022C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FB91F000FF;
 Tue,  6 Oct 2026 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276980;
 bh=j7fMyiLEWqhuLHjASayvGfGl8dCR3auJbWrfl9uBIzg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ngJ94jZZffDsv40ilSFX3FfkI92qSiXNwI1NewFk44Vt0w8jMMkOSU9/O5YNiHNa/
 Eo9J5TsvDCi8UXloNPS6PYK4Aus0RQc6ovo1LZLFYMopKCVoCaXTN/2A5ytuOKrFoI
 wtFMQ14K8CA2ZdYzkhbLH7+VlqjK/j0EPypnaHQD6kKm2tK2crKifrHNOOE+j9dbJD
 qjhzLKYL0XveRFR2UfGy0zHgEM4YbN5yD51telNy2GSyjNNzlOdnzdxNOEI1aeBGNk
 WkpJ42J2gs+wDKAXKDKie7OwfenoYXSxXpTcS6lU0DJ0XPoIw51LpzJPnHTLpewSmw
 oWCeMCAACD7Hw==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:29 +0800
Message-ID: <ff8994fe7511fb1ed3b08bf7830c53168c813713.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yH-00024Q-UE
Subject: [f2fs-dev] [PATCH 03/21] fstests: add _clone_mount_options() helper
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

Adds _clone_mount_options() helper function to handle filesystem-specific
requirements for mounting cloned devices. Abstract the need for -o nouuid
on XFS.

Signed-off-by: Anand Jain <asj@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/rc b/common/rc
index f2ab4bc491af..b9481ba8ab55 100644
--- a/common/rc
+++ b/common/rc
@@ -428,6 +428,19 @@ _scratch_mount_options()
 					$SCRATCH_DEV $SCRATCH_MNT
 }
 
+# Return filesystem-specific mount options required for mounting clone/snapshot
+# devices.
+_clone_mount_options()
+{
+	case "$FSTYP" in
+	xfs)
+		# Allow mounting a duplicate filesystem on the same host
+		echo "-o nouuid"
+		;;
+	*)
+	esac
+}
+
 _supports_filetype()
 {
 	local dir=$1
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

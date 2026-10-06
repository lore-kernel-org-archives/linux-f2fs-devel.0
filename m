Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722BCCA6006
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kCx8tzQASWGj4Kup+rbf0xCy8VWQNWCCGj+DkkhvH6Q=; b=a6H3rOgJjnUHvWLvLehY/Y3+eH
	Rzb5odI0HoRX5Bk2umTm7IEZmIy9Gzv5gwwsnigOON18CoOCIgV6MDnR0wPUVQ2ed7yX3lcCgbQSo
	KNIoA0T5wn9Rhl+4fRmBjumb7OangQzrPdP7qRJOqZgL1bVXiQfOygj6OeK0EUQW5+oM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yp-000696-1P;
	Tue, 06 Oct 2026 08:56:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yl-00068Z-Nf
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yTPg7WgNbGqn4E0eJg50IlBitUMXBRXH6jwA/Ev1yYc=; b=ToUuE5KC/PrXhLG2JzarbrDLFt
 wpXw/fQsNQDDSf1oA/GXVOKFEBR1MaW6n6H6VJNj2v58/NCdiWANHTQ2Gf8rntVwSzsi/nQW8+2cr
 iuDrChX+c8mrJJmc159NG+Ye9LckV95YhmMAnyLwDy9/0PGVeLqmWrhHZjBxDSlEdpBI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yTPg7WgNbGqn4E0eJg50IlBitUMXBRXH6jwA/Ev1yYc=; b=kjrRnObtPeQei5mk6nfroUNpXi
 XvQpTDQglaWmJXDH39WHlVnIG1W2ancEGMbGGLs182EEeIfIcAJL+048ZrIRrE/UP/T+KMG5+0QPU
 871KFaAFDXlLgIc0Tt6ocFYVPL6JqT8J9qc9csB13Ag1cZlP0jdOJ+gq3uvTtJzy/vK8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yk-000269-Cb for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7BF76022A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16341F00893;
 Tue,  6 Oct 2026 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791277008;
 bh=yTPg7WgNbGqn4E0eJg50IlBitUMXBRXH6jwA/Ev1yYc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VIyJTUM5V6A2hzrluI06O2pv8CMghQkGaLA4/m/bkadkBdjQ5IQPOca6zasX2hjUB
 OeFF9xSwFHM00CFx0rX5NVsEvyoVOxoOwwHsh1B6tx5JoxIXNNv3iqaDQ3fxoY+Kxf
 wQT53h0NwCBpUZ5FQAr3CNryW3C6L0hDWGjG3pjq1Su1XErfffrRuC/RlgIxPlOrPA
 IqCotloCa93t96LQj+3su8eopYkorHlyPd6ZBEMdxg1D4WlPGV1P26TLbz2RBBWuVE
 pNMshtn6Ltbm+Zg4kmtMgavo22KGohl9KWGnLyY1SyXY6rYJliES9SUNppz/uDLVzC
 vdlJL0fItfjqw==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:43 +0800
Message-ID: <8aebfe6024e971c967497284c702862f16cbe570.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yk-000269-Cb
Subject: [f2fs-dev] [PATCH 17/21] fstests: add _change_metadata_uuid helper
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

_change_metadata_uuid changes the UUID of the golden filesystem before it
is cloned.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/common/rc b/common/rc
index bc0522dbcdd3..7feeec04a500 100644
--- a/common/rc
+++ b/common/rc
@@ -1577,6 +1577,23 @@ _scratch_resvblks()
 	esac
 }
 
+# Change the metadata UUID of the given device to a newly generated one.
+# Args:
+#   $1: Block device path to modify.
+_change_metadata_uuid()
+{
+	local dev=$1
+
+	case $FSTYP in
+	xfs)
+		$XFS_ADMIN_PROG -U generate $dev >> $seqres.full
+		;;
+	btrfs)
+		$BTRFS_TUNE_PROG -m $dev
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

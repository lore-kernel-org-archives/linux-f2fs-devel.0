Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05160CD98E4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CUF9nHboui8xwRb0GeTWLhe/D2VIsJgxTNNrrS1MnKU=; b=CIj0caIUeT7wl9P7GtK83z/g1Q
	ZFEqaNILXtwEwyD0aVx2cXq3d0Kuh0EURMWiGtjA8vJJ+UC0lB6ac8Y6ET3KiRKrjMRE+0kYhbPP/
	oblnmYT+KHbSZhMuNpgrA7UkWtofNgUIMJN1gs8SeHWDWgaRRLhIYraqKUskpvOLNVZk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZoKM-0008V2-Jk;
	Wed, 17 Jun 2026 11:21:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wZoKK-0008Un-RP
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KaGzvlAFuLvfNXX7hkCbgPcxpzUYNoQuvBwpwaOK3Hc=; b=TXWWXOTZ8rwr3x9JxMnH2Ehi+r
 7NLtWE0XA3XPNmM0gqYp4p5hFYEZdCPQFRzZZyopEr9FzywgIo6B91Gd27gHIEsYn65Pk5ZsdOqnA
 f3PXJniCml5MwKsciQJzcA2uW0OCIVAKgD0zSyH0KJQT2ZzFvcG/CQa/Yt0XOk1uohh8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KaGzvlAFuLvfNXX7hkCbgPcxpzUYNoQuvBwpwaOK3Hc=; b=Ee2/evLhkKjtUX0FTVW9Id+jp9
 Guwx2aHICHb016W7yn3gOViZ+6oK1Md0xahrkuWbxkDuagnafVBCg860pxOkNn+Pt7HysaEdND1JY
 weRqgqr22dqc2A0wG8RXz4ge77R4t4IdzFkLrN7aAfklhx70BxCIaB3Fm+b8Y1hEL2es=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZoKJ-0002NC-05 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A3F244394;
 Wed, 17 Jun 2026 11:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5BF1F00A3D;
 Wed, 17 Jun 2026 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781695254;
 bh=KaGzvlAFuLvfNXX7hkCbgPcxpzUYNoQuvBwpwaOK3Hc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X6d5l7vmxUw9p7rL2GJTP9ljnnIua9w9nhHSTMdXOAniQhpgGQDMLbDj+U1RVnN3y
 ho9xywoFmsInya0CoQE5jZJf0Op8xb4evzxXrHwV+toj9Rk0f7wbqij+0v2atZIYyp
 LpGl/8YzQYXh3FIXB8mMvFcDvUNV/uQLuJQJz3XP0QXHoH4vCvMDS28Vsx5GSnun6H
 bsXA4ag/T7Gy6YWrht1uwVl8l+YfoG3U++0mxjeuU8vOLnhfSbV4sWyhl/LzL+tMBm
 vzHrbpLqnJOImnaN4q9DYKtM+lz4JMVozrB395RVUiqjQHNTlf+fqW8jLend4Ji4nq
 4oixQFp8eac6Q==
To: fstests@vger.kernel.org
Date: Wed, 17 Jun 2026 19:20:29 +0800
Message-ID: <0237f38f9bd3115171e84d15444e00e00898a0e8.1781694879.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781694879.git.asj@kernel.org>
References: <cover.1781694879.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wZoKJ-0002NC-05
Subject: [f2fs-dev] [PATCH v7 02/11] fstests: add _clone_mount_option()
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
Cc: hch@infradead.org, djwong@kernel.org, zlang@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Adds _clone_mount_option() helper function to handle filesystem-specific
requirements for mounting cloned devices. Abstract the need for -o nouuid
on XFS.

Signed-off-by: Anand Jain <asj@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/rc b/common/rc
index d7e3e0bdfb1e..968ba33686f3 100644
--- a/common/rc
+++ b/common/rc
@@ -414,6 +414,19 @@ _scratch_mount_options()
 					$SCRATCH_DEV $SCRATCH_MNT
 }
 
+# Return filesystem-specific mount options required for mounting clone/snapshot
+# devices.
+_clone_mount_option()
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

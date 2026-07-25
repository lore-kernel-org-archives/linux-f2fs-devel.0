Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67345C531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M2LK7uVpvwruZN5/ivHico2crYyslvbUi1qN+qmsh9Y=; b=cD1FCosUaEBrFxu6a7kBhgzT5k
	TFGsyTxSZowXBWWyHNUdZeqk9cgeiC57M9IvpHVItmdsI28vaNIHwFVfAU4TnPbjvsEkevKXmT1/N
	l22H1KSCd2KL93SzebYazxJCm5iGrCEZo3PAEvgtFAZLRZKtYR7IsjHh02Zolac+Z25A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnWzG-0000mi-3f;
	Sat, 25 Jul 2026 07:39:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wnWyv-0000mJ-EU
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BkQ928IhhS+r1y6PyP6u8vBrScuRTuqSeOELrgnM3/Y=; b=T7S2rab99V9747iwmzn8kExboF
 Zjj/5nR+hyuw2RNFhbvaU4NAOgv/ctyGgel/b1rJlHFyAn7Jt0QbsVykEJ9U1ijKSv0ADJaAnzO29
 YDq++Z+UJuxeseHsF6HnZpuVjnJgBAf/MKGZ8Eea9h+hiQUTUOS5LZba3y+2CM/Ki5zs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BkQ928IhhS+r1y6PyP6u8vBrScuRTuqSeOELrgnM3/Y=; b=ZxXmeB+qPGC0/vcvbS47PLAGAO
 bUjaajXDDodsFsr1q5DUt/BhY73Mik5QgOQ4JvDV6Jv1BySCMyfwtgWPv/3FmTwtNExRElAWXlLs7
 1NKuOkE+AncaKL308SXJLUGYJT2I2zgTCRb3SKBcL0PkmvnzUZdVa373cI6+1MFdnLfs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnWyv-0001bz-Pw for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8083843808
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 07:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686371F000E9;
 Sat, 25 Jul 2026 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784965172;
 bh=BkQ928IhhS+r1y6PyP6u8vBrScuRTuqSeOELrgnM3/Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lHYW8eX55SVMeWWNqD/xitYCLBDikNWltjyL/MM5YfJXS2SNbnoJdxdpuiF3O1Wm+
 bPLwXJrfMQM/Tuo5c/aqeNiDANdTN+aRutBAnwdiTkPJrQmtlzbV6cblyeh6kdwuLq
 G5PjfUJnbvaxe09etCN0+a56/afTupNrMWhVYfVuNiIWJd46ASJomhaWzCmLugaei2
 dvsoayJUxNZ7I01SpC85OaBJxSHMNAJFKHW+qH24yImu6OjxDZVrzIscoDB3OIQXET
 MpgHNNArxL/q33jLDoi8r/KNtGc74uR7y0ysWgq0mUEoYVW8eBmr+x7zCsM7JQ7KqD
 ZQuWLsF5E31HQ==
To: fstests@vger.kernel.org
Date: Sat, 25 Jul 2026 15:38:59 +0800
Message-ID: <75ceae4b427ab53c921af395854794b78d7e07a9.1784949154.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784949154.git.asj@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wnWyv-0001bz-Pw
Subject: [f2fs-dev] [PATCH v8 02/13] fstests: add _clone_mount_option()
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

Adds _clone_mount_option() helper function to handle filesystem-specific
requirements for mounting cloned devices. Abstract the need for -o nouuid
on XFS.

Signed-off-by: Anand Jain <asj@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/rc b/common/rc
index e8ff5be0c547..53e5d9d43af6 100644
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

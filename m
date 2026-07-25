Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD557C531F9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JsqesG/bAmrtf7eTYjnZjOqR4yvl0wZ90pDmUqSV3g4=; b=AnXRZWj0AF+1So1ZcXH0bkIArF
	oEIgUwRY/TI5wJhMNUP9mXvhm+mmkKBvjpFfLy4d+Bicj3iZrAuWZ0y4NN6vkfpi6DRzaB/y0JYlC
	kT/Ci1DMCHjIGnT7R7PPmmeKaI2GZA3JwRN0NhJYK1L4yXwMv0yXJJCsgSnF11gqZoxs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnWzf-0000r7-Ur;
	Sat, 25 Jul 2026 07:40:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wnWze-0000qt-7j
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zh0uytEMqjA2I2FeFvX8PcZzuNURLo9sVtjieXsXpLo=; b=PLYx+L3Q/ipEu8uH6/8cew5wcq
 1+gEFRZH0lGO2RmH+fI/hEL7VPkKjOKPxS+hoGsDeYaCd+gDL/PFeU5UbmnmFuGEX5i61T6P08H/e
 ny+0G8mXh7iP4cAtIVxwZsbV5XTGYMoWRJAlOlEvq6qJbUmc0szSN/gUYKm+SaQqjwjg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zh0uytEMqjA2I2FeFvX8PcZzuNURLo9sVtjieXsXpLo=; b=Vi3SvyLDkV5PPKXJ8KEmv8wBlh
 657aEZft7cYppso+vlpc2Y9m0scuZz5ZRaEhZEZrbHv87uSgronoW9gCIG0BPf6IoIl67xp4NWQ4c
 U1yTEVLsITxmL0l9YC4eOhLT6RPAUeE37QuvaKTqhK/5ET9u2k308Ip++NFHAZyTZ+ys=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnWze-0001dd-It for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:40:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F96741F9A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 07:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E10D1F00A3A;
 Sat, 25 Jul 2026 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784965217;
 bh=zh0uytEMqjA2I2FeFvX8PcZzuNURLo9sVtjieXsXpLo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IlB1QwfVTeXeBpH//kROjTjFriZR1UNQ/vKmNoeG3UONqbOcnHhIYL/5FU214KHt7
 S0NP6lbSTVLmG9YTgS3rHSlDfZIPvCfzyoYHLZP8DBtmP/8CLOzLVqdvKvpLcYZi81
 1Ldiavbf+We6h59ZwGDJy5XuyuQGPPgDoSsJFxnkq20xM3aOWC11+4OaSS0VnTGXhC
 +qyAksbw/4xMnh2eF0m4P7hWXwRIBVBVL7Ds4nmWGDcyGHf+7Xyj+eJfctciXKMRlu
 MEShUTGWp6eNsexQTfqYYX2ToLhFcwUgZGGe+7k6Z/aTGhWSfKylr4f0rT/Eo4Wp62
 kplQkZdEkG6lw==
To: fstests@vger.kernel.org
Date: Sat, 25 Jul 2026 15:39:09 +0800
Message-ID: <8d69567fb5700c5a4075509bd7272d02ce9ba4f5.1784949155.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784949154.git.asj@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wnWze-0001dd-It
Subject: [f2fs-dev] [PATCH v8 12/13] fstests: add _change_metadata_uuid
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

_change_metadata_uuid changes the UUID of the golden filesystem before it
is cloned.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/rc b/common/rc
index f73251365a60..45cf9360ba73 100644
--- a/common/rc
+++ b/common/rc
@@ -1533,6 +1533,29 @@ _scratch_resvblks()
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

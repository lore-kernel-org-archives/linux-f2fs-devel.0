Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89835C531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aws1+ltFhQL3S7pR743Cf/KSdqfsLrJADjvjXwuOHFk=; b=imbU7M1df69u7eqhzp4rlqeFKX
	KeyvyKmoVESZFGAX/dUG9eGi221O2IqtMK28NnlCHpWmka9OLEsuWYaGwrSzrqeIMXdd5IFovHfT3
	TAKvuuNqM6dHEcYgdprN5URWPC829u7tsR1R6xg8tHCMPRs0eSyOdfnSZb0tHIT/KE7o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnWzG-0000ms-GC;
	Sat, 25 Jul 2026 07:39:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wnWzB-0000mX-Ui
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qa1sayaIQvzwoExpdR95uN90DWjqj0ydUFZDZMchGLE=; b=JT8xp+Ef4hxNyItYKcw1HdqfLp
 L2RPhJneccWLr/Z1aGrCIfah6LYFOuDSDNNe6PlyNGecdAb62x5gkQED7OinwDqR2KMB/pVj/Zthw
 rroGS1FNIjvnZBgQ3xnj67FA5fhHKth1e4bcE6dxjCdtjEoPZsVYnDIcTH8Mpq1Wg33Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qa1sayaIQvzwoExpdR95uN90DWjqj0ydUFZDZMchGLE=; b=PtepXWf+YJ0LPpohpHOLur34cv
 O350BZhiE/+HnwGxjGJLt3L71zub2oqhBrAt8UBH0YC0W/XxrNcUtuum57b/G/w042854gX+ZrwvG
 x4GWgqME41/dEKsTTHMpZEJ++KgZOtZtDVoSFSGGb0FwvHmjaQD+Medhb3ntGAYkOF6w=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnWzC-0001cK-8Z for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF540600AD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 07:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460AD1F000E9;
 Sat, 25 Jul 2026 07:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784965188;
 bh=qa1sayaIQvzwoExpdR95uN90DWjqj0ydUFZDZMchGLE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dPaoRKB5mRsGUeO1YgS87w8dLD/3UFAfEQ+qSsf9LZYRfpN868YhWRSKU56SBFmCu
 /Bxn36BQTuszrVJuFUN3rhh2a9WY8cy9SHAER62S3hPtLtqopIybYrkwyi5oIZn2Rp
 HgomxRkJd6NslSKW7a+A9gjb4up7RagqMcX3YdXh2t8nVkkMMfQs2SjsG1Zx9KU+xp
 laUZcSChf+wCEj3DvZMIUI4az/vITGVX9E+xamSYk/5gkAElz9uX4RWI/ukSR0PaDX
 SxYDXXECamPrmK9/QT/cZpXvyn8BFDW/1Mu03vfv+aOjVvAVVFyR2Pl0lZoOzT5EkD
 D7l2hRmQJPo6Q==
To: fstests@vger.kernel.org
Date: Sat, 25 Jul 2026 15:39:03 +0800
Message-ID: <97b71706f0c127ec1bf4c73cd97e664fbeb03086.1784949155.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784949154.git.asj@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wnWzC-0001cK-8Z
Subject: [f2fs-dev] [PATCH v8 06/13] fstests: add SEMANAGE_PROG
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

Define `SEMANAGE_PROG` for an upcoming test case that uses `semanage(8)`.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 5661fa0ec310..d760b796ce86 100644
--- a/common/config
+++ b/common/config
@@ -243,6 +243,7 @@ export PARTED_PROG="$(type -P parted)"
 export XFS_PROPERTY_PROG="$(type -P xfs_property)"
 export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
 export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"
+export SEMANAGE_PROG="$(type -P semanage)"
 
 # udev wait functions.
 #
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

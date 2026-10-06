Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22360CA5FFF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VHHExghTthyH2HPG2TH+IyBEeojU3bzcgxLIahGT2BY=; b=IGu2xmKajFB3IFlZWngfVb+d3x
	0BS0eN9LwO86B1yfvPtkJf8yzTmEJ2MwviSn+jS0yBSABosJ99+cbbJUAJ4eABXAWmzUDwyssAuph
	dfFi6rZkFJtFwTsDrj9YKYBH3J2pBgJrzJY2nuSyDXp2SRn+bB9laplauc2rjyWm3/Ik=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yN-00065v-Ay;
	Tue, 06 Oct 2026 08:56:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yL-00065k-VK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9y22LD/+qePQCXLtOMGMMoPRhgQQSeA8domJHzKLADc=; b=MWDDV+bvIgnk2MMgirZVvtC/Xq
 Hx/wkYhhUj4lfsTMJgyCWO1iQiCou6L+5RxnZPG0jk+4JLXwvW31SkvbD+fcCD9Zo9lyMFhLl/JWH
 4zuTyyUJG9PUR7nQYnXDsxEiaYMvEZUZsVcJ+yBkNl2BSY8Ef4EFAdH8dEp9Ljp48IeI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9y22LD/+qePQCXLtOMGMMoPRhgQQSeA8domJHzKLADc=; b=jKev2J1msZIigcrT7bD7uPDS8U
 jgnesYqgr0Q1rwMfIHGROqIC4egpScQt5HrOyU+ewzG+P4kWRJ76D3ygXWiLO0Dz4o13jimLuX+AS
 B/0AAuBubqd+en6EY+LSQSmKHPvA3NowGj34RizLx10Ga4mO7VTnUOmp7c+yjFecihBo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yL-0000LK-Iz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AC6843DF7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970C31F00898;
 Tue,  6 Oct 2026 08:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276984;
 bh=9y22LD/+qePQCXLtOMGMMoPRhgQQSeA8domJHzKLADc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GSDP8yB03tX9/OtTXwNp8GyHq9bwh7p+QcPNKg1uzPl3jmSPyoR8POlNlDendoy+O
 VMc1TQ9TAA0Z5ZKLb+17NzIaYpZFe21V2qOTOvqNJP6cJWBpnQdKq57q91zqvBGqga
 2bm9tBOu37d11ty7wjlNUjey2ZlnTxvgcrTTJGWp59P9HsJ4ajXh3TihxHzYtaid1+
 3QTcIo/5LiE8xyQq7VV+xA2R1l4MPcMTGtYWS8jBt6eNF5n1c+e5EcnCdB2IsrPUx1
 AXFs34/69XUTl+rXtMX/oqgUEMVV4FShCdFEALk6RFEjl7Ub3zvuD8BiSLL8dgDMZC
 38Iev+urxSxnw==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:31 +0800
Message-ID: <16d1b43e27ee01742eb6a431d99a738c0696a94f.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yL-0000LK-Iz
Subject: [f2fs-dev] [PATCH 05/21] fstests: add _require_fanotify_function
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

fanotify support may not be compiled into the kernel. Add
_require_fanotify_function to skip tests when fanotify is disabled.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/rc b/common/rc
index b9481ba8ab55..0fcc1a614ad1 100644
--- a/common/rc
+++ b/common/rc
@@ -6384,6 +6384,13 @@ _require_max_file_range_blocks()
 	esac
 }
 
+_require_fanotify_function()
+{
+        if $FSNOTIFYWAIT_PROG 2>&1 | grep -q "Function not implemented"; then
+                _notrun "Need CONFIG_FANOTIFY and CONFIG_FANOTIFY_ACCESS_PERMISSIONS to be enabled"
+        fi
+}
+
 _require_fanotify_ioerrors()
 {
 	local x
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

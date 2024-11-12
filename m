Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5393AD41D41
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Nov 2024 01:08:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tAfOU-0007Qn-ID;
	Tue, 12 Nov 2024 01:08:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tAfOT-0007Qg-3E
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 Nov 2024 01:08:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GrTVMSroq+oH5A5w152y7NrA4kXhsCqx54X+YRGLlDU=; b=Rofe+061sJLIydVx4a365w0WqA
 AxEPeFmVJyQR9xSA5+ogiG1kBi29bd32mdq6YHiP929TKFiTX7ZqoO4nqkP/Y4rSjK2tL8JsEkU8J
 Np6Te2sQbsxIPauXUtmqUE5sGZJJ2MTFsCQIsh+n06GMwUb8JmyXED878oOpnSsj6YJk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GrTVMSroq+oH5A5w152y7NrA4kXhsCqx54X+YRGLlDU=; b=T
 FxXcjt8iAspor76QzfKcLuJEUYuL+EbLCFxlAT3jx/ejpgejnmRQG6iEkA0Ktri1KqxZRcER4n40k
 ZxaxSdBZsnJOZa3xNscSmzgY6MCodXwmaQINWlLFBRzTECPxBy6ekMAlw+wF+X1UpOrs0Q2LhpRVk
 8XDGtk7wYTcixiXk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tAfOT-0005fX-6Y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 Nov 2024 01:08:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6E1C25C5C4B;
 Tue, 12 Nov 2024 01:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D626C4CECF;
 Tue, 12 Nov 2024 01:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731373702;
 bh=Yvcx1AXHc9kQyvfwxXWWRFwqQa663r5SsuoB/VXqYXA=;
 h=From:To:Cc:Subject:Date:From;
 b=CR0jeD4AnXXENKTzMnCiXV+YDbVByQZ1f1SM6m9Kz49TNoTgxYlqjiEzSrytFxW3/
 3yFUXYsZGSAW7NAwLrdHlKghhpBSWQLbwciLglfY+LG7CS/1HvegPgq1t3EqggOemD
 0GUQeW8vV0KKghLpb/dMH6o0Ma+Y9lYI182/NG2YBnIsnzgxIO61sjymclv7MUgmwt
 nlV/7+V5sbZZBzBP4X3XtUDaNyeUMwF1/MWaD6A2fx9FF5aX6jcTpV+JLk3xAP+tmQ
 G8niQcGQakL6PlRvAfZkeanxvqYc4IJZuwLSVKl4nVg2FIlKZ8vXcy/2S7xrN8woXC
 TYuqrgoch00bQ==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 12 Nov 2024 01:08:20 +0000
Message-ID: <20241112010820.2788822-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
MIME-Version: 1.0
X-Headers-End: 1tAfOT-0005fX-6Y
Subject: [f2fs-dev] [PATCH] Revert "f2fs: remove unreachable lazytime mount
 option parsing"
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Daniel Rosenberg <drosen@google.com>,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.

The above commit broke the lazytime mount, given

mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");

CC: stable@vger.kernel.org # 6.11+
Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 49519439b770..35c4394e4fc6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -150,6 +150,8 @@ enum {
 	Opt_mode,
 	Opt_fault_injection,
 	Opt_fault_type,
+	Opt_lazytime,
+	Opt_nolazytime,
 	Opt_quota,
 	Opt_noquota,
 	Opt_usrquota,
@@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_mode, "mode=%s"},
 	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_fault_type, "fault_type=%u"},
+	{Opt_lazytime, "lazytime"},
+	{Opt_nolazytime, "nolazytime"},
 	{Opt_quota, "quota"},
 	{Opt_noquota, "noquota"},
 	{Opt_usrquota, "usrquota"},
@@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			f2fs_info(sbi, "fault_type options not supported");
 			break;
 #endif
+		case Opt_lazytime:
+			sb->s_flags |= SB_LAZYTIME;
+			break;
+		case Opt_nolazytime:
+			sb->s_flags &= ~SB_LAZYTIME;
+			break;
 #ifdef CONFIG_QUOTA
 		case Opt_quota:
 		case Opt_usrquota:
-- 
2.47.0.277.g8800431eea-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

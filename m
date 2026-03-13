Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E38E106FD98
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7UHNnHXFrZY6Ija+2th1JMlFJDh+a2/scMOrH/84GXM=; b=EwQUAeb4MNBIILyfWBnNHXqs0x
	52mrNDcPPKnN0fyhr0ItDGvqd+yjDOxXaxQQiYJb8550A0yXiAkhFbevLzZHBE7lNKyasKc9UVNAA
	Qk0sihNF7YivIzFCazofTR2+CXscMD4bPQy/qZdG73Ude16TSu//G1G+WDMj15UPaoI8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w0wti-0008Jn-0q;
	Fri, 13 Mar 2026 07:25:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1w0wtg-0008Jf-8Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Mar 2026 07:25:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UlYnLJ5FBqPLBJi1eSvzQkER+ApHSusbeIDZBi8ooxw=; b=Q3oMWTe24Pja3T2envyeFjgAFx
 GJ9+nzCQF7p8+/adZxdVz5xQkMggG4ExP6T8SrrLCwxZ0h5h0aiHio90R+ma4tOsS/wKJ0cOXBnuy
 poKvnIdzIQbJe+DebeVDFlhHhV+hViV8hpzX6bFQPHhLSFBAuHgBkwm2GvDGox6MWc6M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UlYnLJ5FBqPLBJi1eSvzQkER+ApHSusbeIDZBi8ooxw=; b=a
 /K81fvo1bwm+e4aIMwSONLzOilMI/lcV14vFJhb7uvZ6XBDe5cdnUrdxyWbdqNqLAVSNpYMCa9y4P
 w7ImhuKFc3sA4Nye/EXTYhztiKT35wyxU7aYURtTBVbfKHvAnF53OoM1dcL/X/VsSs0UfHYDryjuA
 smiEro3L8JqPhFoM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w0wtf-0007Iv-MP for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Mar 2026 07:25:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 410B442DEF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 13 Mar 2026 07:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B85EC2BCB0;
 Fri, 13 Mar 2026 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773386713;
 bh=G1cA+On/C+XLi27n5zidur8bzN1a9ZKSCHP6yKqRSLU=;
 h=From:To:Cc:Subject:Date:From;
 b=eu6raMgQyGiADo1ksAXNesYaGwD/DW9VnTbGeSyw36zKyokG8U8DEYAF6pO1ponUu
 rjyoAueA5PEdm3XnTJnGqyKKIwEd2APqMWi22kzdng6ZSPg+G5BwnQ+e9RS0muJkT8
 msP2gqkG1CLDIlmW+vlLEZ18rWA+XiZkRxB5kUa92FYL8vzkdUd8rIZxSryVJQLlJg
 Ca6jU1LAb3hhNy48ZRepTDJhypTYYTql9Sl8tKJuROHVwLonhYWDG3JOP+8HdA+u4k
 skdLPGUbmfsCzlGKWFWFTk8AhXR7Yy77AnRbMJAriAi0PbO7a06NtqarKj75LbQBnj
 2bsWOLdhJpWTQ==
To: jaegeuk@kernel.org
Date: Fri, 13 Mar 2026 07:24:59 +0000
Message-ID: <20260313072500.396696-1-chao@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
MIME-Version: 1.0
X-Headers-End: 1w0wtf-0007Iv-MP
Subject: [f2fs-dev] [PATCH] f2fs: call f2fs_handle_critical_error() to set
 cp_error flag
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_handle_page_eio() is the only left place we set CP_ERROR_FLAG
directly, it missed to update superblock.s_stop_reason, let's
call f2fs_handle_critical_error() instead to fix that.

Introduce STOP_CP_REASON_READ_{META,NODE,DATA} stop_cp_reason enum
variable to indicate which kind of data we failed to read.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h          | 20 ++++++++++++++++++--
 include/linux/f2fs_fs.h |  3 +++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 660bf88a376f..86b92b0aecbd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5073,8 +5073,24 @@ static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi,
 		return;
 
 	if (ofs == sbi->page_eio_ofs[type]) {
-		if (sbi->page_eio_cnt[type]++ == MAX_RETRY_PAGE_EIO)
-			set_ckpt_flags(sbi, CP_ERROR_FLAG);
+		if (sbi->page_eio_cnt[type]++ == MAX_RETRY_PAGE_EIO) {
+			enum stop_cp_reason stop_reason;
+
+			switch (type) {
+			case META:
+				stop_reason = STOP_CP_REASON_READ_META;
+				break;
+			case NODE:
+				stop_reason = STOP_CP_REASON_READ_NODE;
+				break;
+			case DATA:
+				stop_reason = STOP_CP_REASON_READ_DATA;
+				break;
+			default:
+				f2fs_bug_on(sbi, 1);
+			}
+			f2fs_handle_critical_error(sbi, stop_reason);
+		}
 	} else {
 		sbi->page_eio_ofs[type] = ofs;
 		sbi->page_eio_cnt[type] = 0;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index dc41722fcc9d..829a59399dac 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -80,6 +80,9 @@ enum stop_cp_reason {
 	STOP_CP_REASON_NO_SEGMENT,
 	STOP_CP_REASON_CORRUPTED_FREE_BITMAP,
 	STOP_CP_REASON_CORRUPTED_NID,
+	STOP_CP_REASON_READ_META,
+	STOP_CP_REASON_READ_NODE,
+	STOP_CP_REASON_READ_DATA,
 	STOP_CP_REASON_MAX,
 };
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

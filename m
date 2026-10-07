Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CA0CA6009
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Oct 2026 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LpxPpFgjdLxeO7PJ1ZWZIKfH2ok1slGRXj9SijpeZu8=; b=azsXhLRYTU1lSjD5h2t8bPRYff
	CqbhZ6h8DxrNUqupLPu+ntm8GK849mnDfzaWrE/EiakXf1uPcY3baH0fCITQ4ZyPbRsS2N1mS30HE
	QyR3V5ZO/r9RM+nd18Gqy53YNaVAPugcoqvEUrOZb7gck4vJ9vzMhPqwI4DN/UqQ7Jhw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEaFN-0002Ke-A9;
	Wed, 07 Oct 2026 22:36:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xEaFM-0002KW-TF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 22:36:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s0hL7DMQpdsnbzZB8C++RDtzIKdJ2wm2h7g58/6ye+0=; b=P52tnFgvNzCt4n3M+orWMU5ZRI
 V7LOEhC0O1YSAtyMBiHHEC+39jHhR76gVacRMZMnG8/pvfS02whNnI0q9kuR1H0JrNbK9A7xIy2Yh
 t+628O/bFiWEQ/xLLLBASVtqEkdxvoFhyEcEiUWyb5LtQa4cs13peOVtKBSWpdbMdYEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=s0hL7DMQpdsnbzZB8C++RDtzIKdJ2wm2h7g58/6ye+0=; b=S
 z1icklUFSRT/FsmicaOuwbqp1b38la0KFGqa4Zde43lbbVg/8FLXGgCZ7iO5IdrCP1xxJyIgcxGLE
 9o3L5quKg07Sog0/gBtjKMfbwxtXELke3S/HIwXe00vghSymONMZK5N8jW/MF7fzr5QD2tjVcKqAB
 Tc/v9Trt7UQFQwS8=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEaFN-00076f-8h for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 22:36:25 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3a8a63785a1so837067a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791412579; x=1792017379; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s0hL7DMQpdsnbzZB8C++RDtzIKdJ2wm2h7g58/6ye+0=;
 b=CEO5ZKF9wbqt+EkluiPMjPO3s5V11dSGj/DtlATQ2VBrnqUr3UOfzeIKoHNNKHYoHg
 kOvJXD3lht/ek5z55qpVEmirIsyRGTJIdL0JZy2hFGuwwMN7noKwTYCmHF8zK5TjzvBL
 9oZ/cYlYlhN0BhfPqKQztF4B7d3dw3RotVtqVvDleINfz2Tda0Dbu1MvJ2MeTQ9A56S4
 HpXBVTyp99FLffpbv93ww/IjitAABj8q/c8zJ0MaLXhWu6aTMk6rdDhol3pT/JB1E0M2
 0UNhYNATj4S1kDyXTWOQLs4snhlNiTbNS0PDbG+FhJMSSR5WhziAiRCbqpuiRnFzhRGU
 bQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791412579; x=1792017379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s0hL7DMQpdsnbzZB8C++RDtzIKdJ2wm2h7g58/6ye+0=;
 b=K5WvHzVldv8Ph3r0gKNFmr+1b/fWRihOtcvBXWrJoSO5IlQupPyCHBwYK52YxPM9Kh
 vkzMN+YdWLf5Zza5t/Wu1Jb5WJKnyDlyBfrPh1/CqaiRLkyfo+xVpjyWYb1PU4tl5n4v
 8sMkUXVTHCzj7lxEm5om/ErlKCzZS/U2VbbJqOvuRdnCtopKV/p6/rSjlABUH9lHdNmh
 1ycXFqnMchf7GTiTJW7QOzrCaxZ/yvvU/fxyzX3O35KvdPxEMwHw0vtd1DkmB/HA3tcU
 79G8ZmfAC1H8yfgc4D4FFopqiDvu327HFfPbiYIPv+aqb/pz5BPXUc1L+1cZTpfX0bQx
 9pzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyVwel9TQZUS2kw3KTyUz7h7xkfHv+lJzD1ZJEl51Utb4d0awRAfYQjfBOHawiR8KkTrkTD+1Rt8bzIZ+V2ey8@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIWQxIuhCGsF+eYWiNePc08VrSOIhMlxFHHbPHX6gTZbZZQrEjr
 vsOdlqlI9zYb1Zmo0gt8VjpQamQEyZmL1GKPnmUFqIFHezdLVLCrO1x1
X-Gm-Gg: AYBFou0xQnlua6DgtrEKFW0cWi7N5QVRcXK7AyHexU87yhO/cU17rSnyw0rTuihaC61
 bLMf4iIXFGaGnB/LhQiVt56RfJulrcFVAQ51rNljxnCMEwTiq3jRCUL+NwNcoGHVtAj/npW0kpk
 sSVSAiZQnUJFhbRyUY1hiQt4N0M3hMI9fO4U3UKkn36gNCb6ZEuctJk6pMb8TI8xQA6AqXXoW8v
 5eASExAjIM14GTAORsDu5uSrXRh523X3l5CcPtWGSq1mQ6CCmkRc7rt1Pj/Yx2h9ZyOW6q53aSx
 u29Tjj+HrF6xgHACARJxhBh11mUSi9cpK2C1VSVYXD7hvcTltqLc+xNzUb3Qy3bcPT80995qd+0
 dTUjdV7IwIGMBoXpDoiJ4iTQV6JLt80fbHqaDHuPVp+WEI1LsCH6wYClNmNJ6fojWMdduhH+lmz
 o3cJCxnkR7f86JudV1fkn8B4a6sGXGu3s7gHgL86yUI8Xkj0TwKPLf2teI3CyO8+77Gxnfd56bl
 rreLtBAhjyFZkr5HDez5MOuNUD/kh+4GjPX324Z0mDlgat708zdZyD89p0cedSZDpkVEMB4sPX0
 vY8PuSRn+/ad19TU
X-Received: by 2002:a17:90b:1812:b0:3a8:6b84:234d with SMTP id
 98e67ed59e1d1-3a89f693aedmr2586526a91.6.1791412579426; 
 Wed, 07 Oct 2026 15:36:19 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9f1c17b63sm1721253a91.12.2026.10.07.15.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 15:36:18 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed,  7 Oct 2026 22:36:08 +0000
Message-ID: <20261007223608.2158904-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
MIME-Version: 1.0
X-Headers-End: 1xEaFN-00076f-8h
Subject: [f2fs-dev] [PATCH] f2fs: write the directory inode in fsync before
 checkpoint
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

fsync() on a directory is done by a checkpoint, but the checkpoint
does not write timestamp-only inode updates. Since commit 7c45729a4d6d
("f2fs: keep dirty inodes selectively for checkpoint"), such updates
are marked with sync=false and left to inode writeback on purpose.

fsync() on a regular file calls f2fs_write_inode() first when the
inode is dirty, but fsync() on a directory goes to the checkpoint
directly and misses it. So if the last change to a directory only
updated its timestamps, e.g. unlinking a file in it, the new mtime is
lost after a sudden power off even though fsync() returned. generic/547
fails sometimes because of this.

Call f2fs_write_inode() for a directory before the checkpoint, as the
regular file path does. The inode block becomes dirty and is written by
the same checkpoint, so no extra checkpoint or flush is added.
Timestamp-only updates without fsync() are still not written by the
checkpoint.

Fixes: 7c45729a4d6d ("f2fs: keep dirty inodes selectively for checkpoint")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 56c686b8580..b012cc22307 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -351,8 +351,15 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 
 	trace_f2fs_sync_file_enter(inode);
 
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode)) {
+		/*
+		 * Checkpoint writes only the inodes on the dirty meta list.
+		 * Timestamp updates of a directory, e.g. by unlinking a file
+		 * in it, do not put it on the list, so write it here.
+		 */
+		f2fs_write_inode(inode, NULL);
 		goto go_write;
+	}
 
 	/* if fdatasync is triggered, let's do in-place-update */
 	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
-- 
2.56.0.360.g66cac248cb-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

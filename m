Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F221AC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Jul 2022 01:12:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o75DN-0001NR-5U; Fri, 01 Jul 2022 01:12:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1o75DL-0001NL-UP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Jul 2022 01:12:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sDiis/jS0+j8vKLgwgh4R98xjzoVFjqGLZR69+2wLWw=; b=YydVWuiCcNH4LoS/ZDLfA/UE6H
 bDF6bY/Qt7XrefjNx/OJCYakO0pS/vIOG0EG/EEPMG9JZ3b5+JTBsCA0z20Lzq+8whnAZjqoDx6sB
 /j1t8u18I0aJn4+YgLeMjjZl1DuHxJerjOAD3ZCjqY3XOSN6ZmmJcpZoqknuUMuy+vRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sDiis/jS0+j8vKLgwgh4R98xjzoVFjqGLZR69+2wLWw=; b=D66gpQXPvevZyqJV2DKWfwTjLX
 MBwmeOatlK5UkROjyQKP1HYhP0KnclsK9Md5tlwimg8IMMAwbFqnZBnfkZih70ZaqlMcYQqxkBJAx
 9wm1Pc+DtzHqboNpU1r2mylicBE1o9M+yT1dKufETnZsWWfzuCv/IttGfe7M4zj6NUM0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o75DL-0000cQ-3D
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Jul 2022 01:12:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B555361578
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 Jul 2022 01:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E7D5C34115
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 Jul 2022 01:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656637969;
 bh=ZnOYTRtVPvrvTyyHuWrrwRnHkNaUbIAMTqYG8i8H17Y=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=pskU1+DSl/dXZEbPjz13pw73PY+T5sx8Gya339QDysgNef78rAC7Z1uapAiSiEoNb
 cfTLD/XKrkaXH2gFdfIAId3MS4yn/Naum7sDzM7fYEmE74aqyD/mmbplqix3CbM3cl
 OrToJJZa0VugTHOlF4F/6zljf8HbCzXM62PpZVD82UCgcKYuNhdkUIMr4hOn9A7Ka3
 aiSOKIBfBsphah/1uTLAVdPSNLVC7pIZTcXqY8fiK5Ch421vTug6yZSrQHcE1dHT9Q
 0nrJCRQUwC3Zn1GvYn5SOxk2X6ZL9K8kFH4SkLEvgvrwO9alDE/aAWIopO/8DDxDmb
 rOYe3qmfv9T/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 09080CC13AD; Fri,  1 Jul 2022 01:12:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 01 Jul 2022 01:12:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-pgHfznRROT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1o75DL-0000cQ-3D
Subject: [f2fs-dev] [Bug 216050] f2fs_gc occupies 100% cpu
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=216050

--- Comment #29 from Chao Yu (chao@kernel.org) ---
From 8a351359b0834f048dc35b5f53276c14a35e4ff9 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Fri, 1 Jul 2022 08:58:50 +0800
Subject: [PATCH] f2fs: add debug log for gc_thread deadloop

---
 fs/f2fs/data.c | 3 +++
 fs/f2fs/gc.c   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c448c3ee7ac3..6cb4ebbbae8b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1303,7 +1303,10 @@ struct page *f2fs_get_lock_data_page(struct inode
*inode, pgoff_t index,
 {
        struct address_space *mapping = inode->i_mapping;
        struct page *page;
+       int i = 0;
 repeat:
+       if (++i % 1000 == 0)
+               printf("f2fs_get_lock_data_page i:%d\n", i);
        page = f2fs_get_read_data_page(inode, index, 0, for_write);
        if (IS_ERR(page))
                return page;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f4aa3c88118b..d252de051810 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1470,6 +1470,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi,
struct f2fs_summary *sum,
        int phase = 0;
        int submitted = 0;
        unsigned int usable_blks_in_seg = f2fs_usable_blks_in_seg(sbi, segno);
+       int i = 0;

        start_addr = START_BLOCK(sbi, segno);

@@ -1555,6 +1556,9 @@ static int gc_data_segment(struct f2fs_sb_info *sbi,
struct f2fs_summary *sum,
                                continue;
                        }

+                       if (++i % 1000 == 0)
+                               printf("gc_data_segment i:%d\n", i);
+
                        data_page = f2fs_get_read_data_page(inode,
                                                start_bidx, REQ_RAHEAD, true);
                        f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-- 
2.25.1

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

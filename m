Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF100C43217
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 27 Nov 2022 00:16:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oz5Lb-0007qQ-D8;
	Sun, 27 Nov 2022 00:16:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oz5La-0007qJ-8l
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Nov 2022 00:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=owi0DPZrVG9B4627zXl3Xpdh70Wrd/UgC+6D1Sj56yo=; b=Y9oi55u+WqP8c9QBJN6zbR4LiT
 Yj9UfMMuAOZQqF7chAASjQ4PK0NQmgS9UwGimKmaHD1Xv9BqGaA6k8OFfJaYwM/DBFyxHWL7pPG++
 JqE+RWPGg6TRrHYYbv9Ncdh2XvYp1foCbFoBkX9ZbgJx4LmLRTtKk/3OqOYggAkc7nEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=owi0DPZrVG9B4627zXl3Xpdh70Wrd/UgC+6D1Sj56yo=; b=B1wtpzPm19Irk8udcofsWpa7s+
 SsA++lJr+nGZjKFajCKj934ADQrZ9pOjsFQuuuIyDYudVULrxH0xrtkvpKMLG3socZ2G5Z4B8v/v5
 3EQjrIppNuX3lr5kuFTPHGajw8OID4hOsB05U60Nr4zodAlNXn1bBsFK5RJMM1TnO2LQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oz5LZ-000254-KK for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Nov 2022 00:16:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3E9DF60C73
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Nov 2022 00:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A21D0C433D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Nov 2022 00:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669508191;
 bh=owi0DPZrVG9B4627zXl3Xpdh70Wrd/UgC+6D1Sj56yo=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=ZWFV08fzmOrQ5mQx1XAJ/Bv8zd7qKJ+zgGeGp8svuULaUFB+EONtgkWJBe5DFngsL
 iSGNZSBNSrsEdbWmiJbClzkjpgeye6BNIuUDGGzLTQvdbdcWLTeqa1sq3lEOivCZ2r
 YMYfytXJoNWubWAM/ehpp78QVVcE55CvGYSLwEQ3w/cY0CXPrFpeM4BeX9Ht9uiU7m
 Xbr96XJnt/ca3BNYLaVzd3EkY5+ypMUCseGkxE6hhFw+7ZVLu4J02d02F7eDKbrtzX
 HvKcg47q0OGPqEx6bt4JWw8hFtMmaJNyFQFbf80vovXoUg3iGYea5mSgnbCYnRtHoD
 yGxQ4LtxHk7sw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 924D5C433E6; Sun, 27 Nov 2022 00:16:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 27 Nov 2022 00:16:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuriy.garin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-dixuYiG8xg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oz5LZ-000254-KK
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

--- Comment #93 from Yuriy Garin (yuriy.garin@gmail.com) ---
It's running on 6.0.9-arch1-1:

$ uname -a
Linux ... 6.0.9-arch1-1 #2 SMP PREEMPT_DYNAMIC Wed, 23 Nov 2022 05:14:08 +0000
x86_64 GNU/Linux

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D78C00140
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 21 Aug 2022 15:56:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oPnIw-0007Kj-FC;
	Sun, 21 Aug 2022 15:56:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oPnIm-0007KB-Hp
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 21 Aug 2022 15:55:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SNslY132XSfxf5vFzce3WLU9thMrjggIVwTACc6LD2I=; b=LHcrDekm6Ck9f6q1HVcf0G7ehy
 FpOYS9Slr0U1F5PY5N2LZ62JfUl9lGKS4ziPVAaq33T6YA5k11rBBL1LIH1+X/AnLGKKdbATe+ter
 CDfxPjVqay5CQQ7HDE2iOC29nS+Fx6hb/DYksIuYGTmv/ByX6PARFt7nPzuDVrZeGlho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SNslY132XSfxf5vFzce3WLU9thMrjggIVwTACc6LD2I=; b=jtNPSuO53PPsZzfpvuMWHphgz7
 0V6ySY1cJawLAL+SIaKgwzOhulUetxwP7Tslna8vmpULx6YS3RdAOwHKlXV8rYdGiuFBbeuFrA2V5
 ODJecrNEscvY3pRgGPjq5NDSKsDY6JxBLoYOeEygu2ZZG6d526ZLzCty4RPqClj2fYYc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oPnIg-0001hF-5B for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 21 Aug 2022 15:55:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C661F60ED9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 21 Aug 2022 15:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36698C433D7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 21 Aug 2022 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661097340;
 bh=SNslY132XSfxf5vFzce3WLU9thMrjggIVwTACc6LD2I=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=tajh2JYlox5Fkdy/AFZHgBS7jWRLWlZZAmtlgujaJ21qX6TBkpyyks6FbccQGfG/J
 DoEW4oVhLLMxR8NuU9Zx/6z+LOZb8kYc33PRSZETJ6z5uaCvSJ1iqcZy7BFyE0o4mF
 puVuaIACh7XLXbi3TXNWfuXkQCJOVIbWDSk/UjTWzJYKOFaeEsvxXWFhxygwdTddg/
 k0fbBx4jE9X9ahw+XKvX8l0JsRpLucG1QI9eo6biywELqT+W5+vUqnwZKtBkEl+5lF
 Ci0fbJ5eidD2HKoer/MnEaOmWc2MR2cOQKK5XtipEZw70fNDK24RTgEdXJ6svCFMsq
 /YpzE+j1m9dZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 16EF9C433E6; Sun, 21 Aug 2022 15:55:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 21 Aug 2022 15:55:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bbutscheidt@yahoo.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-dKInAG3pR5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oPnIg-0001hF-5B
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

--- Comment #54 from bernd_b (bbutscheidt@yahoo.de) ---
I patched kernel 4.19.1 with debug patch v2 but all I can see is that the
workload of the cpu goes up to 3.5G and immediately down to 0.8G, and this
about every 2 seconds, although there is no workload at all.

And there is no output at all with dmesg, just as if nothing happens.

Downgrading to 5.17.9 let the cpu stay steadily with 0.8G in the same
situation.

But who knows if this is something related to this subject at all? Anyway, I
wonder why I miss any kernel messages.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

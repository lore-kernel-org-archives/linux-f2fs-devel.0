Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BE8C04A68
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 Jul 2022 21:39:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oGol0-0005j0-FL; Wed, 27 Jul 2022 21:39:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oGokz-0005iu-Td
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Jul 2022 21:39:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sgZs7nGsSAUXckte+utruxqDbXq9qL+QtJL9WCw2Jdk=; b=GDYngq5q6LEXv01Gqx1GYMP0rw
 a+ujRce4m0CheTcI7Z1yWGN54hgTK/g65kpxKGt3CR1teeLeYwr2hwe/bDtCH3Tv1Cjxr0f+AMIXg
 6l2PIII+f9Mwj3DNR9blrEbLH0BfZ5E9IQMbXgf813zz1xwW7ZTa+Xb7aFh/7AR9DjD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sgZs7nGsSAUXckte+utruxqDbXq9qL+QtJL9WCw2Jdk=; b=jjlDfZu9j5MrqYUGwxN78J99oj
 HOoLZdPpQeSWNci0r9RcDWhhUhqMOghsBch0YUGWM4KOZrzFnaUnt3osuYgy50qoptyrLaPCXD79C
 R8QQMn5c0tiUeVaJfrwC8VhAwgjuS3LQ2ktVELaHZnEJOH1Q0t0o2dUCYhnOc5V2wbV4=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oGoks-00CKHK-Ap
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Jul 2022 21:39:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 09780B8228F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 27 Jul 2022 21:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2C49C433D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 27 Jul 2022 21:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658957970;
 bh=ISIqrfdXc07C1g300Whux0TVfyyHnHB2C7xwdgBLgHY=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=jmtLcWF3BduOMv6Tjbke+8Fpwtwem1/bUCpM+0t34PW5K9V1WBxrCWi2XwPRG2IJz
 97mof1XayTnSuWKSzpEpbxkNuC84tszDMVFv/sEkxNUq6vCe5po9g0L8f7n3ANwSeX
 Vb1YfGDhqFZgFvDMLh9Ih2lwZ96Bws2BeDm0ygWcpe3lAkGS3zTD0z7GUMZtF5PwOr
 KTO+coCczavtHfkStOkB4c6+tYWOUhUt8jHf1yMEknxRwzt2jLHBwAGMTe5eTEvKps
 jepwMnvyTVWP1MK92fTTVKbT0WP3/nnSefdcd0LBrUxxPCqjE6wwKI/FU5CnBLn6hP
 eo58lgfMyP9ZA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8FD3CC433E6; Wed, 27 Jul 2022 21:39:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 27 Jul 2022 21:39:30 +0000
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
Message-ID: <bug-216050-202145-2e3fkuA8p3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oGoks-00CKHK-Ap
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

--- Comment #37 from bernd_b (bbutscheidt@yahoo.de) ---
I (hope I) applied the patch to the archlinux kernel 5.18.14.

Is this supposed to be a fix or is it just "bad luck" from the debugging point
of view that the error didn't reoccur so far?

=========
top | grep f2fs
320 root      20   0       0      0      0 S   0.3   0.0   0:00.10 f2fs_gc-8:17
=========

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

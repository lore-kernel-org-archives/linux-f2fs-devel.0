Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9115C00A5A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Jan 2023 13:42:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pIVBe-0001Mw-DE;
	Thu, 19 Jan 2023 13:42:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pIVBa-0001MY-Os
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Jan 2023 13:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EOr+zT3ZZH8ZpSQ2XzvUR3WjPvbtiTXEKf5Kzs4/RRI=; b=aWGP7J/ZK6nVtpqleqektPB5ci
 o02MvAp1okI1d4ML1ZWG5qUaQfrt1v7TzaTwMt29G709m3Gj/P4J2vMwF+f7gd+grAeMlGKlmYRB1
 TiIVmmQimEK1yryDRmxOJrp5MxfstUQG2C0DUwt61m6+Uf7JlCTsZzyCqcf+vAQxeZWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EOr+zT3ZZH8ZpSQ2XzvUR3WjPvbtiTXEKf5Kzs4/RRI=; b=gxgueVnMG1dIZMyrJ1DMCxwQc5
 Qb2WsCjfjL6kY8h5c2teE1ImRlWGirhWsmUkthUkVKw9bMcr1kOq0JQJkaU8EhBRbrSCBhkK09dB4
 OWiWmsYsiPDQ1ho6oq7TJZbL9e9VSBqU4rr9Cc7ZWIDM5CL5n4Wz9xPR9VNpFokv1DPk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pIVBY-009Bex-Ij for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Jan 2023 13:42:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2F3A761377
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Jan 2023 13:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 942F4C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Jan 2023 13:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674135746;
 bh=EOr+zT3ZZH8ZpSQ2XzvUR3WjPvbtiTXEKf5Kzs4/RRI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=YlLigRw9wveZyv6H0aeJwBrRa8B0HkAshqm5LkLlJWonWyVJuuR4ANJlCzM2p7wh1
 DOXpU2fshsKd93XeTjX5jVSNx8xx+bTnGtZZmwv7Y3fFReDwdHVJGERSr+YG8ytqn9
 Tj04dDdKuWiCSMBirPMbAgyzO1Ua78XUNaoHMeMd6ZsbLUZ1G1IfuuSKBwi3sHGEZL
 MwLXRWjFXrR0/ukknhtlg7CTgM7JOec/Jj7PU0KxDPC/qvll1Cz13RGSA1KEs+ABIK
 uXVDFg9y3BNz17rR6SHOl4rl1eoTIq3pA/74+zx/xK9xwYEzgmC0RmHT/g9rh3h4lu
 EVNsbKsLp1SKQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 563EDC43142; Thu, 19 Jan 2023 13:42:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 19 Jan 2023 13:42:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: rootkit85@yahoo.it
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-iaE6gx0YIe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pIVBY-009Bex-Ij
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

--- Comment #126 from Matteo Croce (rootkit85@yahoo.it) ---
The only way to find the issue is by doing a bisect.
It's a long operation, but in the time we spent commenting, we would have found
it already.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

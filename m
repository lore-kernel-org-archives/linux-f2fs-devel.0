Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9A2C021A0
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 Feb 2025 11:49:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tjGg8-0007ND-Q3;
	Sat, 15 Feb 2025 11:49:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1tjGg8-0007N4-6R
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Feb 2025 11:49:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EGfDZ23hG0F2pIv6mEQBEBBFZ9Rwbw6M/kFRn53pLBw=; b=DCdN97h9dojrwCJuwPV6rqsVVq
 bQ3kiuDQy0thKXzrxZ0eWCPb1eVkqQ4PLKOjD18StK+X0xbSasfG227x9BCR9DMvB052YWxlaxKpS
 aQJZAHPb195tRwlbwrgJsbvgIEhScPBTT0i+ZJ/xNgMJTDkQKa1FGu3Ly4KRFLA/qB9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EGfDZ23hG0F2pIv6mEQBEBBFZ9Rwbw6M/kFRn53pLBw=; b=bpF0ZUgh79k3XHMCnjVglaWpKm
 /g7oL2MYTh+QhkDyuiN6iDFjN6otKYgWaj7J5Rm176kb9zTfYeJ6BASb1u69ODiIP8QoFG7DRXBab
 P51mqDn7cFKTe8W1FrJh/WeQqX8QlB+JcK7bSK87S3mPYW2AcbxmOwOK+Z+OUR8ZAeFQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tjGg8-0003KG-Cl for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Feb 2025 11:49:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 97C475C1072
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 15 Feb 2025 11:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAD8EC4CEDF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 15 Feb 2025 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739620182;
 bh=EGfDZ23hG0F2pIv6mEQBEBBFZ9Rwbw6M/kFRn53pLBw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=X1jPZlbXwVF0ZZP62NY75bEwoEDBb9LJUjcAsRhf6iG5DKRrfs9bs8zNsjT8s3HD7
 NQ5cz+5TkwqjyBIt7xDq4YsHerejhlWm++SdvPosPFB0XWPoZo1/wqYLe85LnwoulD
 8mEnBKhsTGFB7Gp6nquY+aZjlkCAsU3nOS1YnlKwjsQcgiGmnTcSG47XQw102sV/p8
 sbMn73LUPQWa91Aq7LrTbRH8h9+0L3Wek4uMxGIE+L/3KnWjlM9zv6h7CMOg4lBED3
 gdkm6Kupm+eKexX1cgORINiNJQQ16QZyqwsRyau+dJ0ZVP30qo9AarIjseH3g7E2C3
 Vm46CB5OtP7cA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id AC2DCC3279E; Sat, 15 Feb 2025 11:49:42 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 15 Feb 2025 11:49:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219784-202145-i9CPRSnqPr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219784-202145@https.bugzilla.kernel.org/>
References: <bug-219784-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1tjGg8-0003KG-Cl
Subject: [f2fs-dev] [Bug 219784] RIP:
 0010:__list_add_valid_or_report.cold+0x4f/0x60
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
From: bugzilla-daemon--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: bugzilla-daemon@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=219784

--- Comment #3 from sander44 (ionut_n2001@yahoo.com) ---
Maybe exist one regression in 6.13.2/6.13 branch.

I will go back to the 6.12/6.12.0 branch to test more things.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

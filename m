Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890A9C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 May 2022 00:57:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nqlWi-0002wh-MV; Tue, 17 May 2022 00:57:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nqlWg-0002wb-Qu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 May 2022 00:57:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1JG2L//DzwBQcyV0BMqysw5FEMsqUzM8CqzN0kwFOns=; b=LzM09PcsxgVyyxZkb4aZF4TzcQ
 mB74qQJkHUNdFsYECE/I2V0FHDc0bFXS/veJc3QuFI1k2U4bOwJRQ0306y+w6nb0NiLxDe0hE27G3
 fMflf/YeDHNgYqvTFuflLystjk3Q7+EquiUU+GesdLhCKi92CM+xebXsMeJRYjwsY3Lk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1JG2L//DzwBQcyV0BMqysw5FEMsqUzM8CqzN0kwFOns=; b=Tkm3sVX+icpjHTgtjiTgHyCI0W
 ZZDeEteCBG7vioBrUhQxsmrWJvMxxlGL58crc6ElmRfFLRxPQu2kNWHP2+Ki3Aha6TMPiS+bIXTdm
 E9Bs/ntzhndoXrX9le9Q+6goEUWLRjCkCKKEq1hG6PhyvP6Vmgyvg4ujSTijS6C9pTAE=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nqlWc-00058b-CA
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 May 2022 00:57:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1AA2AB816AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 May 2022 00:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD16CC385AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 May 2022 00:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652749034;
 bh=4znLNKRQlyHCsa4QUArjvGjwYIauur9VBL5kA3BUp3A=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=E/hsMWeOOWpoLAFFA9pBfHnoVVEbObO8WFK9ZlxIGg6k/REGZ/bPzkD+5Mv1yF8K5
 uLupo+9v3s5ug5vxKQ0sq/rcpPVcXLY6k45qLQZw/l+Ie2USXA5qTBvA9KSFyAubLz
 Zw/QV4h+izdARCJhK4E6YnL/mHup2an2kKRxS0RmwvJCChK/zFvZbAdYHV6BpG/FcW
 GHnrOH0JbAbbufUXPZsyDOSMXemk7/iHxhonf1wqtohn9dYNn5jHdk0UvNi+p2AwYM
 87IrzoDRBVkWqLy1lwy2zS+Vev9/3eOYI9eZ+RD+zBonHyLyv1uiZy5W4u+dSHV2Oh
 HTzv+K18wtKRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id BB26FC05FD2; Tue, 17 May 2022 00:57:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 17 May 2022 00:57:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Zhiguo.Niu@unisoc.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-215984-202145-yyT3ShyRWp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215984-202145@https.bugzilla.kernel.org/>
References: <bug-215984-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nqlWc-00058b-CA
Subject: [f2fs-dev] [Bug 215984] Is there a f2fs_sload tool used on windows?
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

https://bugzilla.kernel.org/show_bug.cgi?id=215984

Zhiguo.Niu (Zhiguo.Niu@unisoc.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |CLOSED

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

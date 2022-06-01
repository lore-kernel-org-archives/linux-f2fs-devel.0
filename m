Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DDCCCA473
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jun 2022 15:19:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nwQ87-0004B7-7u; Wed, 01 Jun 2022 15:19:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nwQ85-0004Al-R2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jun 2022 15:19:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MRLat1ZQDxGUo2c2puaCWQ3Wg2Pfuk3yuhkrIMsayoU=; b=OmUzIkeBALt8UXUUjMoCMlac0p
 /LbLxZ9ckETIf3pCJDiU0NxQFH4eXWm1zEaKKkouYKvYGKbi5o68Hd+9PShJZ/u6XlnlRXHhg6cWJ
 IQZ0BLA85lYls8j801+K+Yv6RWn6/EDoG94rbJ5myFD3RPku6BvliaCnaR3ySiQaJ/+M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MRLat1ZQDxGUo2c2puaCWQ3Wg2Pfuk3yuhkrIMsayoU=; b=DRruUR+KST2/B3e1D9fZDIjEGe
 DWmQpJJEinsp3Ciwv/7AcgEYSmCUdumTg+5lTbAwGLbEm9gShl1YJx7HDaGmf5WIA5XBACEG9KcIj
 7LS+n7aK+JPZHSWo3p/jvr/ChcpO6uo2XqXrGaCsXqRoRQ+5Vkkhep3vhm6hqFpgskvc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nwQ81-0006mi-3j
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jun 2022 15:19:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 474B0CE1BF5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  1 Jun 2022 15:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D93EC385A5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  1 Jun 2022 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654096753;
 bh=MRLat1ZQDxGUo2c2puaCWQ3Wg2Pfuk3yuhkrIMsayoU=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=TYe0n0KgAWCgNjK5qfomJKkp9jW5nlxAL3zRdOP6RsK0xnTCGq/A0koGhyo9Wb0sx
 mXOK1RZzxRwYDObL0pd1YEQGEhey173k47trVUlxYBC6tziYq32idGNpoyEpkFKMjA
 fwmoTOpy8K99rLt3ZLUhx4wtOgyIdqPuDXDtKR9NZpRZmGe9S7wV16cOzDF7uwpL74
 vv6MGWmU8STS6tis3nVbuqoeulFOuihsFS5NwlRDoDx7kfZNPtrzIe0PHwgpQqxbSB
 1WyApJL69yTfAwOduGxet7qVbvUKJagQn0RR76KwtCfjhBHkv0qHLKmCIhPW4Xfwxq
 ZUI1S1UWivU2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 830ACCAC6E2; Wed,  1 Jun 2022 15:19:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 01 Jun 2022 15:19:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-5PAJ3uGxny@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nwQ81-0006mi-3j
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

--- Comment #12 from Guido (guido.iodice@gmail.com) ---
yes, now I have atgc, but I added the atgc after the problem.

the original mount options were:

https://bugzilla.kernel.org/show_bug.cgi?id=216050#c2

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

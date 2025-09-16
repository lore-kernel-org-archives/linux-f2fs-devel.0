Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530C0CAC597
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Sep 2025 02:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+v1bVjy7YP7lcWcMcEhnyK0tzmyouX09zORumgMFrrM=; b=gQWIVd3BBjKVhinZfotSRUqao4
	r+Zj0xC7XdgzjIkRZwg1xLgri5Og9+TPX69v1WEPLaVdYN9h1qgRm2pLTOfNLxPlDLM3bNGamuind
	F449u49wzuksNJvSRBywPujfdkXlwdJV41E7WNJUdE58ghL8RC0ZnJ5ksMuqcEpUR0Fg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uyLnk-00046y-0m;
	Tue, 16 Sep 2025 02:52:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1uyLnj-00046s-77
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Sep 2025 02:52:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aDwF1S+G7M7sTDKQCph0B2z60gCuc+eZgNsjV6lsKHA=; b=ittWmvhcM29fmeXLWsOK8/8hEj
 Oj5qQd0QPAylWqbyZzuoZaOMFoXj2lNIFqJu+Gi6NR+o3GZe2r6za9gMB4GFGNjz5g6x4KnWF7wcC
 wpeGTVmOEotSDiI2VJhVUNFJ9yX6c24ftDujHo82w3TWm89eFd527KTKy7y6DLFDRE2I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aDwF1S+G7M7sTDKQCph0B2z60gCuc+eZgNsjV6lsKHA=; b=k5MJbyUuGYDYMWRfDJ25q9J5ay
 3W0X2GHGKoqd7kHsmwUVeLviJqXhpG+mMo5hKg38sbnfg+CAz6M5Cx1uf6ET4baPQFx53YXUOCbTo
 ljsp1cD/kj1yOOxocIDv+d6a6IfztWUNJKCJ/yRnuXM5W1RtnAAG4bSRYVif0ElobFAg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uyLnj-00030i-GV for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Sep 2025 02:52:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 24513445B2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Sep 2025 02:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05A75C4CEF5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Sep 2025 02:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757991125;
 bh=aDwF1S+G7M7sTDKQCph0B2z60gCuc+eZgNsjV6lsKHA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=qiqsgKIFus76THCjDZ+i+SvYFXNspGCeYBQXWQpd0smmD+V1nDeTHsW0kZAj0fJIl
 yR0nKVp+FUTeu/xJYl08ae7pPE3lOeqTHZX8l8F6j5zyeU/mYTDBGuW7dtF5uWGiFG
 krlHxE51eLHFU9n0/noSKqYKKUZzCsZUPA5kSIrLge1dkQyeAhUF4eQMoyX9Zf+dhk
 7mtuBKPeduv0SG/5VMKswpiqDx8D2NC6sCJZNJpijAl/9XHrcvTtJO1S0Nd9ctbVRO
 RLqlgvGqdKoN1wbzT03Jk690vwht7kx8G7hsrgicliUJ0C9OR3aaBEtEFColr0Pg1c
 Knfyu2uPAjvTw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id E37A1C433E1; Tue, 16 Sep 2025 02:52:04 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 16 Sep 2025 02:52:04 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220575-202145-hIT4HDwDDo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220575-202145@https.bugzilla.kernel.org/>
References: <bug-220575-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1uyLnj-00030i-GV
Subject: [f2fs-dev] [Bug 220575] Unable to handle kernel NULL pointer
 dereference at virtual address 0000000000000000
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

https://bugzilla.kernel.org/show_bug.cgi?id=220575

--- Comment #3 from Chao Yu (chao@kernel.org) ---
I meant using trace32 to dump field value of victim page, something like that.
:)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

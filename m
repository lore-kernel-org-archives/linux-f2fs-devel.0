Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7625CAC5B8
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Oct 2025 02:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D5kAfdjtHiMYOXOFkANyhsAcO62GhRZ4MUJaFzp4KAo=; b=AnYuWxV6HVkCRqVs6XIVOzG9s9
	ewFwGegB6QEvcm82yOCm7A/SbafFzHxZL627r66xB6wDm/OJD2yIhoasn4qDt9eYDUTB8H9iRP3bX
	XiTSeXXX5AeoW/L38/DCieWQeivGuKHUSTfFJz63batSE6m6OkCwxpGYgQVEuYFWPGDk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v4Vdd-0002zl-Ov;
	Fri, 03 Oct 2025 02:35:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1v4Vdb-0002zc-7M
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Oct 2025 02:35:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xGfB72ooXyHZroVOCtiHh6LuId1dii6+AUGCXTbiM7U=; b=Kd+NBdIPeEbzPT8TjSuNUpEM5K
 7r3X7UTIkEqsxYRxKID172HG3Iy2S9JaX95RVq8ndVp9lD041quBbnYuPvr+0iK71o8BUYdivnn5e
 eiEO35lmuqw6mpujM2fAiEY75E+9xEL2BP85ypV/vKZxtxT+ExEyHaVVk9AUnEzXuktc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xGfB72ooXyHZroVOCtiHh6LuId1dii6+AUGCXTbiM7U=; b=eWgcCfCwnYvMCEHneB9Qu7X3rO
 SNj6ahCtOfEQeqdi/sph09VU3Bzxw188PtHcCZaOFe3a/QGh2xNvBwjgU+7iveW4oRuukXvbK5qCf
 YW1pDXDnZctI2hrnwF+69tup+jKvuTLXqZkmYLIEOIOFslav4qJwsUffevYdwvXHaAsY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v4VdZ-0007PX-Us for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Oct 2025 02:35:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E64156022C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  3 Oct 2025 02:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B694CC4CEFB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  3 Oct 2025 02:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759458823;
 bh=xGfB72ooXyHZroVOCtiHh6LuId1dii6+AUGCXTbiM7U=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=FtFRO6wQDa+wZwUonJvKds2VnIJqF+p5mmpZ0cAWo0LQYxuIlR3bHd8VQP83PA1h5
 jEcTYkkyttvjfFA8WFUitIKsaiuJ98Ig5bQKNDYURebGuWcgZB1q5Lqb7yIa6oBa08
 CYE9TqbovRyanEayf1b/am2onSg0eX4JDZC2unZ+HJUl1VCKEVETERWxm2lu06wvJX
 ArTOgtHDhv52JFiJwTYyoTy3SHl79SDkL1VyqT15G4bsh57qxNbg7KW/hoDSfjT8m8
 a6bAJRGiDxQtbf3xCj3R7VOwN4ky1tXQSwPnUX/FS2H0ynQpopBpcFv059CsxwOoKU
 wSCdwYDqSL/wg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 98ABFC3279F; Fri,  3 Oct 2025 02:33:43 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 03 Oct 2025 02:33:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220575-202145-AmuNyYKojk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220575-202145@https.bugzilla.kernel.org/>
References: <bug-220575-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1v4VdZ-0007PX-Us
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

--- Comment #17 from Chao Yu (chao@kernel.org) ---
(In reply to JY from comment #14)
> - inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
> + inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page, false));
> Is that right?

Yes, I think so.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

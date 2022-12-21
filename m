Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11B9C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Dec 2022 02:46:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p7p7G-0002M6-01;
	Wed, 21 Dec 2022 02:45:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1p7p7F-0002Lz-CM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Dec 2022 02:45:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jqD911P5fIxw36sK1Q9F4umLKI5NAz5XX4CYiZPGnDs=; b=bGagtmVR4PX9Afaq6eLfX49W3r
 FqfiV4OQCMsuElCRdLG0xv6sqx+YayM640YHx2IQwNsemJS/UeXr65jxap0wrmT6pnptCJOpRC+Tz
 Wwd3oCSRWDQOO3WNrhonHe0/IBeggLkTUxXeIOsVJ7YxEruXskytFEtMO65PuwncR64Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jqD911P5fIxw36sK1Q9F4umLKI5NAz5XX4CYiZPGnDs=; b=KAH+OTpm+DU/8FH9r8k7jXKuWt
 +aXpAN6ZACiC8D6S5cT3tRLBF46lREI2e34ucM9g7tNL9byKK0ODh6D5/i1zxVT1t+en0IWN2qOhJ
 Fe0U0rKx4nZjaqHb5eWMKYM+1WLTB0AMVvxbRJf9ZnxzYkoHQRAJQVZm0JpEdMO3P5Fg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p7p7E-006Lls-QI for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Dec 2022 02:45:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2CFBC6165E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Dec 2022 02:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FE8CC433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Dec 2022 02:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671590747;
 bh=CMZofP3cL9wOX0vZdgpHffxICpasniB/l4u8jb96cu8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=eFYBv1Vm44LaqzIYs2m1VzOazWc10cejUoFNEsF6Ceo9vlid46BRFCsDRjNyyRyZJ
 nuXwwCCIfHfr2uMMoclw9NYdD0Y1wVNxQMbTeeOG4joOdz6PnSFP6hPIfR0IaIbFxF
 xWhgDGAJlbGHNZPVewp+ol7kREAua0k06xjExdBbpM9sNIup+4BauoojKKl1w01Rv7
 jyZ4N2L0MqYw7G1v2LxR6E7pjSx3s0b2mRlfJQyXOjFA1YBXHgyDFd1TMtjVicg19C
 9hGqpJ4qWDaAZFRc6xryTdL+eyMLtrZE9+6yJDB5OquuuAyHfkuHDqDJNs+0ZgHBqu
 vTKJ6P2rWpzSA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 6FC3EC43142; Wed, 21 Dec 2022 02:45:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 21 Dec 2022 02:45:47 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216050-202145-mjRiOUtkcL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1p7p7E-006Lls-QI
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

--- Comment #122 from Yuriy Garin (yuriy.garin@gmail.com) ---
Created attachment 303441
  --> https://bugzilla.kernel.org/attachment.cgi?id=303441&action=edit
debug patch log - page, folio and ref count - #2

Today is a lucky day. After two weeks of waiting I've got this GC problem
second time.

It's on different inode, but page-mapping is the same.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

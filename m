Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D06C00A5A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Jan 2023 15:42:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pIX3p-0000lZ-Sk;
	Thu, 19 Jan 2023 15:42:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pIX3p-0000lP-Am
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Jan 2023 15:42:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BQB51PhixebquB5lGUgY6j0mxMR7sZij5xqUfaeme9s=; b=dF7vJRzfcsCYJm13yVzQcZS3Bd
 WEBBdU56IQif7htp1lSzdpQ5sKh+kVdg8WKX08eGLpBqJsqRWDxIzqZlR9QKsGTlGZzCCnierDhxM
 cz9ojmNes1x2soDxaAUB20gCm3rEheq3w7RtluQbvhhQzlNpi5nVEXgEKuaFSnRcOS/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BQB51PhixebquB5lGUgY6j0mxMR7sZij5xqUfaeme9s=; b=EljWSGM4eVfw/+80IArfq9IiIH
 OBjEz17YwGAYNYojTv2frmXzVS5eQj/gWohb8huOH4ZcVDxQwW6shYhxK7xxxVDO/kzp5hutqEIOV
 66jumukkpg7Cd4y85LxiORUb0bA21SLaiR7cWmOB5gWpfiBFRocbASoGV8epGFFWY8gw=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pIX3n-0001SP-S4 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Jan 2023 15:42:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5412FB825A7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Jan 2023 15:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFA0FC433F0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Jan 2023 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674142949;
 bh=BQB51PhixebquB5lGUgY6j0mxMR7sZij5xqUfaeme9s=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=euZ4gHfLvGI1FXet4GOW9VQ2y8omEEGHNpXC6JRVFfggEdt6BXuiPVHTy0Rdcn5I9
 TOzefMbDMEUmlXgKsmjIan6Otp9PuD2VGfoNIhp7T5wBnGbSZ3Puwm+QgCrX+etI9k
 uXKX80R35XLLnIFXWWrnStWJEg5zlMpJsmj0czRJfTjYRyGs6uTDIopfDVJVyci1eX
 p2xjEihwzaHLV1TON8UxrFC/YOOYbXz7j115a918QCfO10ESj+R+IPq27Hy+fJZoFl
 +LLcADCAeM/I8k6U29MZCSrxzadsMyVzIFpqlmRvYVFDLP967UvU7ZUOvDFrRlKkCc
 iDjdU0ATYkCgg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D0681C43141; Thu, 19 Jan 2023 15:42:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 19 Jan 2023 15:42:28 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-zleAwWVJO1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pIX3n-0001SP-S4
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

--- Comment #128 from Guido (guido.iodice@gmail.com) ---
(In reply to Thomas from comment #127)
> Bisecting this is impossible: There are 16205 commits between 5.17 and 5.18.

Well, we need to check only the commits related to F2FS between the last 5.17.x
and the first 5.18.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAD3C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 May 2022 13:28:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ntUaF-0004aq-HH; Tue, 24 May 2022 13:28:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1ntUaD-0004ak-Kf
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 May 2022 13:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k3fofuA2kdIZVqIqHBvOvk0HH1Oe+g/XW7NEEj2Qvn0=; b=ODl3SOiRVuCjoJbwweQsALDhPa
 RwYw0gGGcUJVc4sum5IgsXYRKl//VXG8OlNsFPNUU6ymIDuWYiFSZadt2AyAYNU99a1Y4sRMcl9lb
 8wZkUjSmFMjgViLIaRpZpbkmYm/D+JEHBdQsAFJHOBy3nvwY71GSW9essiYQGvXtu05g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k3fofuA2kdIZVqIqHBvOvk0HH1Oe+g/XW7NEEj2Qvn0=; b=Jm25dw37Keu5l0RQxU35/E+YUN
 Tb+LmJTX2So/GlDuHifaQh527qj+sV+W85MqMgK1o5G9/V6ggXwSrghvNKTee9VQkD9M/YEi7wBZm
 hjqct7OKE7GhzvYmdgM1lfpgwm21pI9r7cjDmJQvDMtDPhvSVZtXggT3P5lON8dG9H4Q=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ntUaB-005FGk-1y
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 May 2022 13:28:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4408A615E1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 24 May 2022 13:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2BBBC385AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 24 May 2022 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653398889;
 bh=k3fofuA2kdIZVqIqHBvOvk0HH1Oe+g/XW7NEEj2Qvn0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=c5z2thoSurQm36AWd5OnXjl2RE+jII5VwkLi+HJDfQL7Icas6f+fSLSLB4ykKYzvc
 heiQeozfKaeL/JtfgdYQAJvH+EVeVwbWlyvtQ9ZxnfK4vhpOV3gdvS/R1CWMiIAJJU
 yMf/mVDZLsKBmfIpcbXn8l5N0VaHQv62KSD88rNAeS/Dh6eauxGD1Glr4upbI4VF5x
 NGXgqW6DpIpsDJLZUiILUvMhbv6jkft0h0ey1yZke7rv6z3vVY+ORyJQQQ4BkYgwgE
 6LPsqxSuJsIMzsP+PFzyL/O20QP6TaTBoGVyzTT6FfcRRT5/EJPmYQW2Ow0gDhwmAM
 XA91akrcq4uNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8F295C05FD4; Tue, 24 May 2022 13:28:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 24 May 2022 13:28:09 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: File System
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_other@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215902-202145-3NS0WQixqk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215902-202145@https.bugzilla.kernel.org/>
References: <bug-215902-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1ntUaB-005FGk-1y
Subject: [f2fs-dev] [Bug 215902] kernel BUG at fs/inode.c:611!
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

https://bugzilla.kernel.org/show_bug.cgi?id=215902

--- Comment #4 from Chao Yu (chao@kernel.org) ---
(In reply to Zorro Lang from comment #3)
> Hmm... this bug is a f2fs specific bug? I thought this's a VFS issue... OK,

Yes, it is.

> if this bug has been fixed, I'll report a new one track the CIFS issue which
> I hit.

Looks fine.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

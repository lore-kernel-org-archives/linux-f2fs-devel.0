Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F99C6FD19
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Mar 2023 10:04:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1paZbx-00056f-BX;
	Fri, 10 Mar 2023 10:04:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1paZbg-00055y-7o
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Mar 2023 10:04:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JaB0X6vpxSNfWUuE+aHFlgzbSmzxMJBBtGTPTQRGPgA=; b=Lle6B/BWxfwEXgm7gG/K7CiU9v
 UI8Ig+k38rXVVYbG9WSNRBCAMEtvzJuGsnOx2zmFcgIYAx0H2qqKHaoNYM07Vu72oPaLouiR28jra
 Y1XZD1YJoSToqBrDjARh3CAP4roHRdy/YcFwk8i519v6aQfjy4V5Kvkojo/hayOliGJY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JaB0X6vpxSNfWUuE+aHFlgzbSmzxMJBBtGTPTQRGPgA=; b=gPqVFT+dhxSSlvzcrSUp9ABvuJ
 BJ2m6zBeOyXAHAcBM23lIWvQMQqWEh3L3Gu6Ci8a2h7Ji85tCcx1HHnj+fipKk1HPorZCGEhyB0m5
 x0WTvRIfqgAD5Q7hgJHu0FE+skFwV1rssU7VRAOCwf7W77y0VlqwapdURmxW2gFz+AzY=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1paZbZ-003NNT-OI for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Mar 2023 10:04:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 27133B82184
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Mar 2023 10:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E67C1C4339B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Mar 2023 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678442636;
 bh=JaB0X6vpxSNfWUuE+aHFlgzbSmzxMJBBtGTPTQRGPgA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=nIDtI7akkvV5HrNwFLWkY9Dy8ABlVInkbSwkb/w3pn1PVWTQ1/WtcD1bG+pMh2VnQ
 vvzwg/YPNvFzVM/x0I/z1KUnvR8g5PECFlQm4fafoGhTMt7j8gzqQBfJjNpqsT5URN
 fIMatjKoh45p2Z/yppI9CcaJjxfhX+zPGOIDuYipX+0e2DwQKorU2MJT5v9KcKhOmN
 LvpSJFHzJFnVq9wGfxczLv8+giRwOuGyS5MEmkwLRgyJJ+yE1728FkCz20uQGNJcis
 tBFVVQn23+q8g6P0FJvCrRwQ8eKm9n/fJM1nZCA0TYTlNLHMuktprN8+wif3CjRs/p
 dlfvm1/z8N+iQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id C5F8CC43141; Fri, 10 Mar 2023 10:03:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 10 Mar 2023 10:03:56 +0000
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
Message-ID: <bug-216050-202145-l3kpuMN8Kw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1paZbZ-003NNT-OI
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

--- Comment #138 from Guido (guido.iodice@gmail.com) ---
(In reply to bogdan.nicolae from comment #137)
> @Guido: any news? Did it work? I did't see any issues with this patch so far.

For me too, so far so good, but I think we still have to wait to be sure.
Anyway I am beginning to have hope that the bug will be fixed with this patch.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

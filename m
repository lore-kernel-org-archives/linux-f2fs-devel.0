Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B1BC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Jun 2022 22:19:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nwt9p-0006iK-HY; Thu, 02 Jun 2022 22:19:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nwt9o-0006iE-T0
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Jun 2022 22:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=baA50AJ8EheIa4y0bK13fkzrH99QHDnfXIlS9aQgSb4=; b=BgSWqPaLn+X2QyPvMCiHx1v1QJ
 47uJrUCHvZdrpNhn4LlhPz8ZRCu9tZTamPOYCM8Fgt8+rFwzkGyt9yRC1nG0ie9YmxqqESpL/Z9tK
 RVA571fLlMiIvLIiHetTKwbmplgF+SplDn8VMQ1jc2qWuBMKDH0EzJB+5+lm6/bTkIv8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=baA50AJ8EheIa4y0bK13fkzrH99QHDnfXIlS9aQgSb4=; b=NPtPQFX4JpEB3RDkIxtH5jYXrh
 wuuweXXYszYkBM+WZUNZFxBD1Nvb6SNFVZFBlmU9zb7kdEhW1kcDeAb3iAr6Xo9odC0jNWTTllAyA
 nVQiTjEEZI5tZ5RUtxTiib3dTjP+7xQfW9oQXj98hiIviwDlAxKyhqORjlRt2j/0u8rQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nwt9m-002oV0-7i
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Jun 2022 22:19:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D8202617A8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Jun 2022 22:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A670C3411C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Jun 2022 22:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654208340;
 bh=baA50AJ8EheIa4y0bK13fkzrH99QHDnfXIlS9aQgSb4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=iwi+O1qFqn03gLxaPC4jQ3MkJvGs6mLtQ6w2ROjNLfinc+j6uFuB6UdQZQiDPo/x7
 plKMwihJ8YB3vJaIakEuiUsgNnK9M/sb88SyoF14fR50/jmB8rmDwv9MBKSf8645PZ
 V9tvuCvtE8KcvSec5MqKGIpWkEqSTjb9KqBB+E+EtWC3CtwGaqLC0SWWka0/JzZcpe
 zHMnX2MyB48NjXCQS9of+3+dWnX6CyzpTl/dBFqAmrWmag3et4YC9h5ae64S81QNhi
 m8Pe80MFHczm1oWA7pZq7gcEWOZOKSjxDX5/LEZc5M1Av6VA/Goe043soysbyHxZD2
 qj0NoLIky9R/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 2B35ECC13B0; Thu,  2 Jun 2022 22:19:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 02 Jun 2022 22:18:59 +0000
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
Message-ID: <bug-216050-202145-wi7HtrsMzJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nwt9m-002oV0-7i
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

--- Comment #19 from Guido (guido.iodice@gmail.com) ---
what are the disadvantages of using background_gc=off considering that I have
the weekly trim active anyway?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

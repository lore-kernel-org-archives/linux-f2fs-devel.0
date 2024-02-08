Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC33C4828F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Feb 2024 09:12:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rY0S2-0007pt-Ah;
	Thu, 08 Feb 2024 09:12:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1rY0Rz-0007pl-Oq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Feb 2024 09:12:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r73sCnWR359S7CADfK0sCzaT/SScPHWC1FBdoKFl15g=; b=N9LVJ9caMzbJ9uLyuwFQiDPti7
 l0Kj13FwYWu9U8zWJpxcG4lpzVZcgXUytU2gWJAuR044oLYhSwNOov0hlT7Z5ryf14jsFe74XNjWn
 11NU5j65P4ktlsCa0iiTS02vBeFOOWZmlrHPPwgqoN0+CFDwDpi1C8470DJ6E66RF+KY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r73sCnWR359S7CADfK0sCzaT/SScPHWC1FBdoKFl15g=; b=OMIzBl4RuH0KoBkBTVpfSeVfGN
 3S8vE62OR16xuBAo6GsKyZU0v6p9EI21OlXTtbk/+lGAhp5BW8HWw15XK1XEJRm1rFiAGaiFsaOrr
 D47l9p/QIJPtXm+2Vx2jgUAis3kUB4dGX/wbzoboKWmzK523yTsILaEk3lJIRiu1m+j0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rY0Rz-0001xf-3X for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Feb 2024 09:12:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5525861B24
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 Feb 2024 09:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F111CC433C7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 Feb 2024 09:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707383517;
 bh=vz5uKQkW51U9p1127n4biMoup3veIUp59rL+v+koXu4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=hucspoFvV3e+mXacayIoxBNF/OaawEskXea7j7xNf8X8mjwtPUK878kT/rvH0ZH7a
 d/1dasyZVs0OPsU07Rgn27cON7a5TGNY6RvrLmJqKU17M2dwlXaphiYnr49WjXTeG3
 m2QMxwVFGk8OnJRrLuP5cF75GwztXJxdOvtlPaH/Yau65onCMpSXJ6WBt4DV656Jgo
 aQ435CjwBRY2vVWhBWY8em6yioNtY4StBsJdlBwnfKZcnrGXk2aRFB4v+7pW5Hmn2v
 M9D/VzhVTJZ0tXWMk50uG2ak3u2u4d1lOBftKJruUSVHVnmI+zV9rA2i8OvDL3jE55
 +NlXDLI9zGdJw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D6835C4332E; Thu,  8 Feb 2024 09:11:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 08 Feb 2024 09:11:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: dhya@picorealm.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218471-202145-uSYwB6N2qF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218471-202145@https.bugzilla.kernel.org/>
References: <bug-218471-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1rY0Rz-0001xf-3X
Subject: [f2fs-dev] [Bug 218471] F2FS fails to mount rw at boot with
 "invalid zstd compress level: 6"
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

https://bugzilla.kernel.org/show_bug.cgi?id=218471

--- Comment #1 from Dhya Pacifica (dhya@picorealm.net) ---
The changelog for the Debian linux-image-6.1.0-18-amd64 kernel package lists:

    - f2fs: clean up i_compress_flag and i_compress_level usage
    - f2fs: convert to use bitmap API
    - f2fs: assign default compression level
    - f2fs: set the default compress_level on ioctl

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (unknown [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78993C6FD1C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Mar 2023 21:39:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pfSeg-0000mj-3l;
	Thu, 23 Mar 2023 21:39:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pfSec-0000md-Pl
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 21:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F/zcRKu9VqbyruFBtlwe1Vk6//LSmNnIGbnGU+QGDRI=; b=U575FS2DmP0tBl0FLjBRoPcLCn
 gtcMD5G2aIycoymnGSJ6oeV0fZmpAINjPlv/oCgnpbcOpA0EAGhVJt/6sw72ugGCu6WQX7e7ZzPRi
 hWzBfWV7GfKUkXYC9G+CVBjBuQEoRt8RwX+2qe+uEJDSeebsxR9ntLI+L05fhFLqMxzQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F/zcRKu9VqbyruFBtlwe1Vk6//LSmNnIGbnGU+QGDRI=; b=RrXSqjN5RAUHva3lfGQ1S4zkHi
 2GCIGaT9TswEeWuR5j/Aj/r6nD5Gltq0LgZmbFXaLdvEyQPTE4FaC/fmNtj+hnAv/6s8k7R9EL4XI
 5Hu0py9mR+axYHUNNAbMqrOY96FqSXPIsOtJDI4MW/P7BUXY6jO0Y9RarYFxycKeYgLw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pfSeY-000j4c-1O for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 21:39:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3F2AD628D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Mar 2023 21:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 124D5C433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Mar 2023 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679607554;
 bh=F/zcRKu9VqbyruFBtlwe1Vk6//LSmNnIGbnGU+QGDRI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=eS9lUDAmpxdlk5WtpG4IEbSDoZG4CMnC/otHvq3e3hXNvo2ptKFymlqO5/PWnyr4Y
 m0LVqGGeMT2iddUZ5qaZ1YDSMzn1AbFzakmSgk+ZoyzPwzTG1lDlmmT71bDQp1IQ6+
 dErqg7WD+b49qeOcsYVBxYF9uT8ceT2QW8Sz+J+yCxAyfJezhuR3C4vpqtuHZg1Zni
 t/OteaN5o3hwi5cYFKIrOR92N6r3dQpWcKAS92iS8vc+5ctlnKD3iANvLQA/QOsKZl
 f8GuCOvyYk4K1eEUFXjvW6Un6Ltp4GlqY2mm1PR4+M6YgkVwCu/LYe05Gq85XmxZKk
 AnvD6jX1HZEDQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id E986EC43142; Thu, 23 Mar 2023 21:39:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 23 Mar 2023 21:39:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-OFVfTUVOJc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pfSeY-000j4c-1O
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

--- Comment #140 from Jaegeuk Kim (jaegeuk@kernel.org) ---
Cook, it seems no reason not to merge this patch. Thanks,

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

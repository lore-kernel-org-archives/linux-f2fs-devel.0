Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E62C76188
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Apr 2023 17:00:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjNXH-00027z-Jd;
	Mon, 03 Apr 2023 17:00:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pjNXF-00027t-Jq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Apr 2023 17:00:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Q5Dows9I8aJm7DcZ4udoIYN2Efhw1dp8qX3QYJSAnc=; b=L2lY5B+6Vw7rPI7VpncQkGfTeW
 cgQ30meEG1vLUz6hMrNovOGPFfLpa6BQCPDQluM2Qnk2iHdzStwxTDucH6Ab+naCYon8JUeJR5TB7
 7f64ysNl6SVuFHW0mONQwpWAQvqnF1UykhuHc3irjpTRgQx19YjPS0ZXQLYYmTBD3wrA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Q5Dows9I8aJm7DcZ4udoIYN2Efhw1dp8qX3QYJSAnc=; b=avR1Le7T03hlPygyxe8Os8STwh
 OSq0zIxiVp160OKhx0CtVEQDQycFFStZmGhS4rIVBAbpUBZ8a/rSIVy8YWstevSoppYNwV/D6ISo2
 PRju60wHeHs8prlG6oc4aFyj7Uc0cTBwEE108XodZ9CqAs79QFPCGnWRqOjK0vIS9Kj0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjNXF-00Duy9-Si for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Apr 2023 17:00:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D92E061347
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  3 Apr 2023 16:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49FEFC433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  3 Apr 2023 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680541190;
 bh=u30HR1yY4x/CmY+veWtAVlQPTLkH1AM6oafE8v/9EgQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=tg5UeiPlK+7WZD8fWWbVSXT54z3BhMvkMq0JXQhEaWzO4goGFe43NZmxA4Za2BFvC
 pzk5ACPpau95zVoB7MZ80CHP08JucqTB2127kmPaxtnVo/U28qt4FyvOik1ZrKVKoE
 aj0Ly/w170p7oXzUfcyz5jgfrKlbF2AqsfgNAtVTTixdHOIb7/XwHGGX3ld61rnozY
 ccvQa6H3z2SnlvPwTsIuzxk3wpSaPnEiKCYr8smmOSAQrsGW06l5eN5SUvBx/k4G2W
 BgkBHSVBPDTLdTFpjRNftxlSdu2JaO88mU0lqFHbFQifleFhqvgzle6S5ZppNdROMK
 igrFtXjFfM/YQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 2C785C43142; Mon,  3 Apr 2023 16:59:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 03 Apr 2023 16:59:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217266-202145-16z3yxLWhk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217266-202145@https.bugzilla.kernel.org/>
References: <bug-217266-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pjNXF-00Duy9-Si
Subject: [f2fs-dev] [Bug 217266] kernel panic on f2fs filesystem when
 f2fs_commit_atomic_write
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

https://bugzilla.kernel.org/show_bug.cgi?id=217266

Jaegeuk Kim (jaegeuk@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jaegeuk@kernel.org

--- Comment #6 from Jaegeuk Kim (jaegeuk@kernel.org) ---
I think this fixes the panic.
https://lore.kernel.org/linux-f2fs-devel/ZCsEytDjqEjQDPiO@google.com/T/#u

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

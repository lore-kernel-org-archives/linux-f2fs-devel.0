Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B30C25B78
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 May 2024 16:12:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sBzQd-0007Vt-Ei;
	Tue, 28 May 2024 16:12:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1sBzQb-0007Vl-Mr
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 16:11:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9+v/hLyTknfSeNichmKaTM0ZFTqFmQRUlhAvAJPNOnI=; b=IQkZYs7gsCB71uywu/4tq0fvMG
 YG+lnVcqpvrW3oNo1XiidsQoq1P7+UQaqvo5/nkw1/1mcaWlHyhXdj7VJ3OwB+8QOnoKr1uy3W+gc
 qk7Pg8nLZgmASxVgyUYeMKJsK1J1szaVZ6YZ4Wrz+rGO+bEB5AiBuFAtoGjwJNUTt9zA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9+v/hLyTknfSeNichmKaTM0ZFTqFmQRUlhAvAJPNOnI=; b=E79DOmB2HjePQ8NiG3Jc54/3DW
 2Ex4kmVOznKZOvaRijhUNDPz/3SVZcpFYVcP9jwicd7XsSWVpe3ZO39YR3nVV9xMISQke3TrKh+Ah
 7uBWIlYi0r46wiQ7xwktWK5jWm2wGUfaGjpTwcuCnGZEtHdU5cBSTiZuiP9/D3nO84hE=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sBzQc-0004R2-QQ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 16:11:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A6AC5CE0A49
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 May 2024 19:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE4EBC2BD11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 May 2024 19:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716666417;
 bh=9+v/hLyTknfSeNichmKaTM0ZFTqFmQRUlhAvAJPNOnI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=pQLYapr78RPnEiJ1QutssOAx7lbr4Ve1xg24UO0AXfNnXhtEwxduNkIohZASl27KV
 FE6dQQFVX7KhHCdo7+/BIwYtJNKjbwWlD5TV8kahAf9so+CtO1yoF5I6vKRottp9LX
 geZVpzyTf23RSP+OOmaCR6ngcQ1fY37KIfq7YZFtXMNncrLFsol+ilRXjXkv49eNww
 YPMO4bgk479UfuKQSbaO2Rzt/rxd5oY2pJbNLOAJbxnWoHTXZX5VSwK6Zn5uMkVyfS
 gw2a+b3Iav/8ba+xOMdApG9X+cNqXtBRDjR4DIW/p8uOsBfKoA8ak8W6yi+7+e7Qux
 vWFBsksgfgGZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D6DE9C53B7F; Sat, 25 May 2024 19:46:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 25 May 2024 19:46:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218770-202145-APFqg4mnQW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1sBzQc-0004R2-QQ
Subject: [f2fs-dev] [Bug 218770] fsck seems unable to solve corruption
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

https://bugzilla.kernel.org/show_bug.cgi?id=218770

--- Comment #14 from Guido (guido.iodice@gmail.com) ---
Thank you!

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6C5C25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 May 2024 23:23:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sDBbG-0006Vz-Bu;
	Fri, 31 May 2024 23:23:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1sDBbE-0006Vr-GQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 May 2024 23:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cKVnmbLaxNt9CL6TfBpwfIgGPSPgVMpLnd3mbKoCnZI=; b=ehQnIOai07CSCIj+x2ASzvyG1m
 73TJJJvuia0cS5cff9gr6XAdI5pGykyZJrXO2SjU7CrNYQzkSXvRNq2mxIxSI6N/Qa0rc7s8GgiEW
 DafI1jrHetCNiM3jPRq2AaX/sXSNP/oOUrfLKsxan4W6IwcAaUo8KAUVFC6qoXLMpNEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cKVnmbLaxNt9CL6TfBpwfIgGPSPgVMpLnd3mbKoCnZI=; b=evG0JUoFQOy6Gd+v8Kqbiz8o+Y
 GUSz1kPoRdytcpOYPFcbBcWBIRwU8uJoVmPJsLBvjDauRCr8w78GoA7tD/12kJsV6fwKSGkW57k2l
 hgjpp+prvlRBtkOejDxF/JjJrQW2IPUUZKRy8EzVZU9g1f50tq6WtP5IHrFWO/DsXRMQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sDBbE-0004Tu-3M for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 May 2024 23:23:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F210662E5A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 31 May 2024 23:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5763C116B1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 31 May 2024 23:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717197820;
 bh=X8IbojzzoC/aRFzXylGn6mBR5kukPGuLYUbErcX5+ls=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Vsi5doUGPhZsgaV2icdm1nuDKOi2fndDErzBIRNfVLgmzpW8h8n+fyJ/aTpj9jO74
 55JWWzWd7bfuRw5z5/8phEVeUQYZEp/cPDNVpB77vJFxZts1Y1CA/oocgA4UueB2wl
 RuHeUcnv94yniVhTE5o4MQ8RCUR8RHgFotRncySdFkax5pegDhVG3CGcy4EuZNoQK1
 393vXOT/847bQRw+v6RL28RYSEdMHkyPFRXC+7W2NNmmPhsPN/QPqj1+kez6Ro5qyW
 3xXViMNqsYLzCof39LBHGnrAlcMq2BzwBqNAfJj1MXidjbdjllUa6cX4DsZq4YvYPW
 Frf1Vm2d/neZw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 906A9C53B50; Fri, 31 May 2024 23:23:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 31 May 2024 23:23:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: patrik.plihal@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218870-202145-ENNUHInpDU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218870-202145@https.bugzilla.kernel.org/>
References: <bug-218870-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1sDBbE-0004Tu-3M
Subject: [f2fs-dev] [Bug 218870] F2FS mount/unmount results in
 invalid_blkaddr
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

https://bugzilla.kernel.org/show_bug.cgi?id=218870

Patrik Plihal (patrik.plihal@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #9 from Patrik Plihal (patrik.plihal@gmail.com) ---
confirming that 6.9.3 (form arch's testing repos) mitigates the issue

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

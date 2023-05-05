Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85FBC77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 May 2023 22:38:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pv44K-0006hm-LO;
	Fri, 05 May 2023 22:38:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pv44J-0006hg-LS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 22:38:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6tgsvxJhxKtFDi9sLW220rPXidp/Avp6/wVQZCKx9ew=; b=VYDeiG/OncxA9RiKtGnMfOTnII
 /1HPpjO7SmNG8UfE9TReP1RqVzHwGOR9TMbGWKqlQ+iUxsV67pHqVqoWJxJKs3WSD7rH6nvyJKaEO
 mKwdEsH1R8YqoQ1t6eKhZYt5afUN+xx+MZbN+E4MItZgJijCnznQQlXNC9hmJJFSxXZ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6tgsvxJhxKtFDi9sLW220rPXidp/Avp6/wVQZCKx9ew=; b=BAf1HbBeCEos5Bt/RU9xYiZ6/K
 fgVogNj1uOG1P151kfyHLyne2D8o06fobkWYFFyyxKpTGpXkz4ajKQrwLjROYmJ8bb88CzIwTq0W6
 ZGH/AVaYpD94jBQRr93dNCCX9bwCFyf1VTqkxAOnrpHislfUk8cnPmNAu1XTnhTnQxmQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pv44J-00FluL-2P for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 22:38:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A508C64161
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  5 May 2023 22:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE9D0C433A7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  5 May 2023 22:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683326300;
 bh=dyekNVsUhikMdiN0Y//6fFc7WSryBS5Yz7VG+ypGTXk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=YZjsWjW/nexRk9BeDhDUqKhkdHjMhyawtq3Huwvzg/3q9bQj6SnhX0QChKwTEtVs4
 NCTvJLKtKdQ3Ut6PJOxNcHOJA4wilztKAbnWXo0JsrpJJA2aSgthkxRFmmiuhxltql
 pl6a6zywGju7JRExfzLPXOVAze9mUFZjJxZBommWSlJOa5WI9vlvhzK9ovP13fLJzK
 qN/KJxaLbp+lGsV98FfrI+kkN6A54b3sHC90Exw6RgZLkCJ+gXP2x6rKdTycSDVxQL
 OKIg9/y/jk7ZkvUd83thqLqy2I/c3eVeKUIWXSTDbiOswTE4dRa1KCS5w/reEfVdXJ
 4qVegS91Vajow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 9E1D9C2BCF6; Fri,  5 May 2023 22:38:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 05 May 2023 22:38:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: lp610mh@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216050-202145-QrhIDmx63z@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pv44J-00FluL-2P
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

Matias (lp610mh@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lp610mh@gmail.com

--- Comment #166 from Matias (lp610mh@gmail.com) ---
I've using 6.3.1 with 6.4-rc1 patch for a few days now and with no extra gc
parameters, f2fs_gc-8:1 starts using 17.8% of cpu and basically the system
becames unusable, can't open anything etc like a soft freeze, but after setting
background_gc=sync (although it might be not ideal), it did not happen again, i
hope this extra information helps Jaegeuk, love this filesystem.
Regards

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

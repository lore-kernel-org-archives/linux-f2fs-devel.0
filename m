Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10DBC53219
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B+ROQRwe/r7dsSRr19BtamRd/rInv1B7BIwpaW4bz+U=; b=WF2duk4A85Pzni93bBA2J1WYmj
	Dc0AEAqxcBvlelwW+cYvRWP0KYsv9e70OZ/zTcJLHn/r4Qj09k6vOGt3YamWVvRKAJnlIY/PCILW/
	vPFh/miTaYOLdjDto7ZIswMACc/QZc11hT+BFgjaxDOqUfHI5/XhvrvHUc2HQmnbzo4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wol6n-0004KL-4H;
	Tue, 28 Jul 2026 16:56:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1wol6l-0004KF-Bl
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 16:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=af+rCFxCY5wv/u+6xNFLDh1ctqWKlvQ5GwXLJPQtvy4=; b=f3JjdUNxh98iO3+ijJYzA08Ln+
 GAKZWlyjMJtTRjjHjb60NywwCVSKqYkYSsyc+r8o5Xy+D7wgg7IScCP2Zrjne+Ij2OkoMELO119ZY
 A024eR02Wn4J4ZFbUpnaiJRE4Bc94g/Ay0RotaB4TSMrpO68ycImn3BooFrZWvZo8fjU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=af+rCFxCY5wv/u+6xNFLDh1ctqWKlvQ5GwXLJPQtvy4=; b=b
 7tu1+iepUSftXN4YytkEMmg9W9l+/K4Ff4SXLCm9Le/yGTspC22e2s5FR6O5NWm8RzA/3Rsh/OoMd
 G+RKQklNp+zynvosNFMDZBLAPSuRo6Hj/hAdCofbXnpaty8WpHj2u5euUR0sUGUQ4VC2U6GbKKKBI
 uj+7gducX61Rb7k0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wol6l-0004kb-Ed for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 16:56:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 17EDF40C39
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 16:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC1F0C2BCC6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785257802;
 bh=BSUprkYGNnvL7M9ckUgEZJ1EERuhL1QjcwXGxY96Iyc=;
 h=From:To:Subject:Date:From;
 b=H7pLhh82fqkwHRGteuaO8d/fIcC7LXSjCC11DdGY3aKf/0NiCWHwbzT4yi4AxoqXS
 HreQEc7TQ6OuB2U8Z2hJTxlOnsOOLLx0YGr1vqalbaTFd6RIsxukVpROfXXJz6JaUj
 zu9jiPaFUHKXXN8Ngiqv0T9LISwM3Z7M16eSZmMZA6jl6DS/HxiA3rYgk1DzGq5KIO
 DN1Kj/ucw0elJuikc0taNrrSMMOLZX7DUpTMtkuXdFq4AGJIL3w9hDJzYXRMYggFu/
 tcZf5arKT8YidWKE8C21sujhnuDt7OvQRS0DkJYYV98orGQr5pNL32blmBhn6PDDLP
 VnrGXyd6dIlAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id C9F08C433E1; Tue, 28 Jul 2026 16:56:41 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 28 Jul 2026 16:56:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: pavel@noa-labs.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221805-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1wol6l-0004kb-Ed
Subject: [f2fs-dev] [Bug 221805] New: [Documentation] Default values for all
 mount options should be indicated
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
From: bugzilla-daemon--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: bugzilla-daemon@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=221805

            Bug ID: 221805
           Summary: [Documentation] Default values for all mount options
                    should be indicated
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: enhancement
          Priority: P3
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: pavel@noa-labs.com
        Regression: No

The documentation currently omits default values for many mount options. Please
add default values for every option to the documentation.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

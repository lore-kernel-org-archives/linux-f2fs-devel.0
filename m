Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB116C4828F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:41:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rY7TF-0006Ez-0L;
	Thu, 08 Feb 2024 16:41:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1rY7TE-0006Et-0r
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Feb 2024 16:41:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=poqggiu+2hK+G9ez6/WqHQ/2HPzAh1n/zM0KnQEDF2U=; b=HVTVGik7g5BWzb8PN30cRGyS4b
 lkk5qS57tONUxxZEOpV5zQIQQSE3ITR4pIiMKYjHieVN905DrjrPHxxwQB8u86EH1dZ8RafYwwWIa
 A3ZWfz7CVWSFfPx5rc722xRiDJEqdD1oBZmscOitYKNraqUqvkIJgQYT5jeXb/1Ec+6g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=poqggiu+2hK+G9ez6/WqHQ/2HPzAh1n/zM0KnQEDF2U=; b=FtED4YWrDLp6QpBRHHcScJlGBq
 DvA2m+ONZn9YGe1EQaIbl6kOxQGVtxdOZ+GF/Bic+ZH6Z6rzExndq87XltlSyKSGH/C4He3hoYvkp
 r1xlYrUoaMe9vhIJq4WaoIYD5oLwjslZIe53QXWMu8mWEgZ7nN6p4UFU0F/awaNAXQCU=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rY7TB-00035I-U3 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Feb 2024 16:41:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BB3D1CE1DA0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 Feb 2024 16:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 055C1C433C7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 Feb 2024 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707410498;
 bh=jrmJDTUaotl679PJ5xqYtTnQRMM/UZ0jLFDs//XbxVI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=pFa+79w++8gTe+qvbORI+7Ce19CnFpS9HnbiKXAn07Ma3XM/UFKiUoYNN8weklwdH
 QAk+ChQtPTauxAL9yhq1W2eTo/0GNPQqOq089EKVkjh/yp+LP+ASM5KFglFrzXL0h2
 M2hyXXx9a3Evj2K3y5OiTHFzLdbjxLgPL3ql6ZskCKRQmMxaLCwKwxiau0Zyg3s3GC
 bK68VaTsVM46XBTjK5WhIGjJhduN1BGJA6MZyqd1V2sfphBE3qbDKea1DlC7XCZsos
 J1OivXoqoU2lHhbGgUfbvfiCPMdbQucuaZAzRJpNOELm/i+ABGWLpFck1ELyHlmvgj
 vNFDA4ml79P/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D5EDEC4332E; Thu,  8 Feb 2024 16:41:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 08 Feb 2024 16:41:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version cf_regression
Message-ID: <bug-218471-202145-RMULLNmCES@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218471-202145@https.bugzilla.kernel.org/>
References: <bug-218471-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1rY7TB-00035I-U3
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.1.76
         Regression|No                          |Yes

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

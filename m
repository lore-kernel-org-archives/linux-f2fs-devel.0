Return-Path: <SRS0=th+A=VO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CCAC7618F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jul 2019 20:56:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3812F21019;
	Wed, 17 Jul 2019 20:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Jvb+jfQ9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="l8icISC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3812F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hnqys-0002Im-ED; Wed, 17 Jul 2019 20:56:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hnqyr-0002Ig-HI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jul 2019 20:56:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KHjiQ5aEuXx9kIoItk0YbSjcnWeGLosbEjDtWIh4LK8=; b=Jvb+jfQ97hOX4e/aDfBeuwDqAN
 DQRhvJn/CfY6PcrDvJ3lo6dD3OuYncNTIUw6ZxolAiqwZJSQ0T7nx2GdJJ0kGokObkkOeMuBcpLcX
 ilZXbKtDhcPpC14vkx2cS8ymBFgwQZzcfXGm0cH9GG1tkH2Aoof76b1741l18KY0Uj/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KHjiQ5aEuXx9kIoItk0YbSjcnWeGLosbEjDtWIh4LK8=; b=l8icISC4srQEGSNRVOs6S8DfcG
 iLVnicfZa14Ndv30hulVA789aJGKZ24DuhgHQoF86hCAemHgwhk3bTKHVurkZgD0LCynX5Ap5aoFT
 Zj9s3R+gjN2HNNZ8B6J25Yp3b0AWvAX9zKuQ/la5RC80nX0hUxLqPy0bLTfOwPoj//+g=;
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hnqyq-0055Z3-7e
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jul 2019 20:56:53 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8EC662877F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jul 2019 20:56:46 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
 id 82D4728785; Wed, 17 Jul 2019 20:56:46 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 17 Jul 2019 20:56:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: phiber2000@gmx.de
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202495-202145-jCuRiJQCe1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202495-202145@https.bugzilla.kernel.org/>
References: <bug-202495-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
X-Headers-End: 1hnqyq-0055Z3-7e
Subject: [f2fs-dev] [Bug 202495] oops in fs/f2fs/checkpoint.c:150
 f2fs_is_valid_blkaddr
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

https://bugzilla.kernel.org/show_bug.cgi?id=202495

--- Comment #7 from phiber2000@gmx.de ---
(In reply to Chao Yu from comment #6)
> Was fixed with a backported patch ("f2fs: fix to skip verifying block
> address for non-regular inode")

Maybe my mistake, but I can't find the backported patch in the v4.14.y branch.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/?h=linux-4.14.y&qt=grep&q=f2fs

Could you just check that?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F338C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 30 Apr 2022 05:24:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nkfaq-0003ZZ-HW; Sat, 30 Apr 2022 05:24:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nkfap-0003ZS-6t
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Apr 2022 05:24:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hdvb64/qpnRHAbf8Aie41lM8PNLgCbInL2Rc4GxGfs8=; b=Bp4Ij4x2WqGb1QKxhGy2NIcAgR
 wpzZE/Xp9zCMbelqJfBnSGtOWw7xGUraUn0taUMW6FNA7k9M+BwpYCFKtA+7dYUpI2hPBPUHdfFTM
 bpUpQW+oD4GcglSMBwJ+d99sIgIFrCD9QBdOayPpptOs9Ym9vDPkyBWREQ/2QOdFfmw8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Hdvb64/qpnRHAbf8Aie41lM8PNLgCbInL2Rc4GxGfs8=; b=Q97uVkWZ76PmqYZw8KI4m/elfJ
 5JmGCPZtgzwdtLzeo4CtDjpG/LCfXRyoZCm0gp/m24HJGXBLcMAJNyVHAlWr9FfDjSa2BnFoWclZH
 g3Fz0/vFvYNNcvUvMT4KU3SnjIieq9TYAYPkC+Ds/PbUkK1AUeHSujYaX/l5EZKJBMwI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nkfak-0004O9-Dl
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Apr 2022 05:24:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3E75D60B5A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Apr 2022 05:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A164AC385A7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Apr 2022 05:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651296255;
 bh=Hdvb64/qpnRHAbf8Aie41lM8PNLgCbInL2Rc4GxGfs8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=RkcTUu0CvU4Dyy+SPVglfOb726VdvF+Oczix4pYvMe0jXpUcnVn3JmKmqStzimt1H
 lSq4cI7juMAY5iLlN0EsXmXz75wlGgu5iYBQ8LWbEJVaCQ4S93nSzPtXdeX485TYKp
 9QeL3Xym6DK0P3S5TzgBFNvK91q63G0S9+xw99kcjAOSdk4WeiE+l05JUaB7FgNeFm
 zHwvDkiYY9zy8uDlNwEKtICVuX4NuE69wqj96tCDinMA++9kYAnbSLyMyaxEeMTe+b
 aJFYc4V4KunQw6XGA4NLSXS1q16tsMUOXmLSfvXcrfTHPcAsa9O9Yp0H6CzXZRWxRU
 orwWhoz201i0A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 852ADC05F98; Sat, 30 Apr 2022 05:24:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 30 Apr 2022 05:24:15 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yanming@tju.edu.cn
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215895-202145-pA80YhFQ1k@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215895-202145@https.bugzilla.kernel.org/>
References: <bug-215895-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nkfak-0004O9-Dl
Subject: [f2fs-dev] [Bug 215895] kernel BUG at fs/inode.c:611!
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

https://bugzilla.kernel.org/show_bug.cgi?id=215895

--- Comment #2 from bughunter (yanming@tju.edu.cn) ---
This bug disappears after adding the patch! Thank you for helping me solve the
problem :)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

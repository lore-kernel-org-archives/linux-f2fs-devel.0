Return-Path: <SRS0=dRGj=KK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2522AC433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 May 2021 19:58:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D96610F8;
	Sat, 15 May 2021 19:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D96610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1li0R5-00088G-2i; Sat, 15 May 2021 19:58:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1li0R4-000889-1i
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 May 2021 19:58:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bxf4qPxVcTr7C3BYNDdYeiFL2WlB693XDbwlvlTd1rM=; b=lYfZYUHebc5kRP0jLfsdbrgn20
 tVWAlAm9/P9zfpwwIs1tlZFlkrnw/UbQaQDgKWWTc2gyfeS/EBckghqtDUTShoZ5OV7YWsK2GX3jH
 c6KB50L65ij7kFpOFPZf/ScaZ9I/aDLlW2dbcj4an3OObmCYUf7kS+oUNwm8CNbOQmfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Bxf4qPxVcTr7C3BYNDdYeiFL2WlB693XDbwlvlTd1rM=; b=S
 hJKwGTo8A1+hYE8RoHMbWQya34iZMiHe0/3jd5Rm24EW2fkatYUddIWFrpBOp/Mz5eyTFAgz8n1xm
 71Q1i0rYyZG1Uje2SKH9GbmKyTlp4AVbVyqQUfWnZKW1VErXMlgN6yn3X4jpHfiV0QqIzWC/3/h83
 4erTBHbqUQwj8Br4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1li0Qv-0004ZO-T2
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 May 2021 19:58:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id 609D3610F8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 15 May 2021 19:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621108716;
 bh=icI5cmUjDVpqOc/cXTR9S2XnDIJKX2XhgvakpfTGmqE=;
 h=From:To:Subject:Date:From;
 b=lvbiBBRfMcPHylb5c9pO71+Rhp2hAYxLLeQ1TFA6CR2x+kq3QLol1LIR/yugRDAta
 N8khvtoxw3GQ7coH677NwTM6QZiMsTJKNA6ZvIfTYXJ0TgKiQeaHypIlK5lamQALtv
 KvSoRRuJxBsT/N37fnUutyr4F88P0NQ8xMnTsuMZBrTo3N+arQnTHUKNqVNr5TzEbR
 3OrYLPdfsAkTpVaq07IzCoUWe5/mDtgxwCUNAus62rZGof0/LkzMuprg2TQzs3Ej5a
 C5DGclvj1Syw83/ZqV9saGdBKyjKXmFA+FJ2vjsm6cyHWL2VOpPl2vs3SVOoQWAvqf
 J7YXCrahhH/JQ==
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 15 May 2021 19:58:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: marcosfrm@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-213089-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1li0Qv-0004ZO-T2
Subject: [f2fs-dev] [Bug 213089] New: Add "pre: crc32" softdep
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

https://bugzilla.kernel.org/show_bug.cgi?id=213089

            Bug ID: 213089
           Summary: Add "pre: crc32" softdep
           Product: File System
           Version: 2.5
    Kernel Version: 5.12.1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: marcosfrm@gmail.com
        Regression: No

initramfs generators rely on "pre" softdeps (and "depends") to include
additional required modules.

f2fs does not declare "pre: crc32" softdep. Then every generator (dracut,
mkinitcpio...) has to maintain a hardcoded list for this purpose.

Hence please use MODULE_SOFTDEP("pre: crc32") in f2fs code.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

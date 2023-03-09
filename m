Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5946C64EC4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Mar 2023 20:22:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1paMmB-00076I-8s;
	Thu, 09 Mar 2023 20:22:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1paMlz-00075y-6Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Mar 2023 20:22:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7+yKWWG1F2dTCSVs/ExHFTM9SQEzCqBRUtttsjS+g/0=; b=VIVODrzqEIAHZllXfdQs/r0Vmz
 Qm2q3P8Hwtv9Uls1PkDJ7y/pi2MB19aftpE1h32UqbCGyuQBRT1H1HUAxgheToz1kRlC8TKVq7liS
 5bD7gcg9oeHXrojdrDOP8btQVmcH5O+1mDv9X121l/qsemUxYljM4EfJT4+fuPID9jIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7+yKWWG1F2dTCSVs/ExHFTM9SQEzCqBRUtttsjS+g/0=; b=EvTy9xTlb0JvNQdOrEnAAJxbKh
 1vJmcueilgBdvBtKvW4idRtSof+KTBmqndNDsDUpQCpSLbdEEvMMofbN/nvvEU7vNPs+WfZhbd7D4
 FPdNafogtfIzEs0dsWW1O3GIZB38e75PNI1oA6pLKMlg/9LSJxSJemMD0zdYJD4aqf6I=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1paMlv-002hhq-Kt for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Mar 2023 20:21:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EF307B82073
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  9 Mar 2023 20:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8951C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  9 Mar 2023 20:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678393304;
 bh=7+yKWWG1F2dTCSVs/ExHFTM9SQEzCqBRUtttsjS+g/0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=CdPtfN9Ynw3jNZl2lOzsfhtUC9JVy6IOXTNrgr39+/SoMffuX41vRr4J4NDRrWrLm
 LWQv/mP9dlYhR3+XVK7sZ1Gr42Qixj8gYwKqeh9QmoyULfB0Rsvov6a3aiT98Anaek
 dm4DE8kUPVsh983YqQ1iiVgyc0IAd92L9cuq0EDolIlcoeJ7IIm8VHFeCwEyN+j+GT
 pikIMvJnqjhZFoXfb+CfzrWLybkeA9YxSbNbZVZw5aOIxyNaWmu7l3eN6MdceWGBmT
 ohev6XO2trZ6EbbsB7mXPW00aT9RoEXkigFynRnjrzaJHUaR1iyypzvtS6C+TMGbKv
 ADPtVJYktLrKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 9A79EC43142; Thu,  9 Mar 2023 20:21:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 09 Mar 2023 20:21:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: bogdan.nicolae@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-8uRmkoppjQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1paMlv-002hhq-Kt
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

--- Comment #137 from bogdan.nicolae@gmail.com ---
@Guido: any news? Did it work? I did't see any issues with this patch so far.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

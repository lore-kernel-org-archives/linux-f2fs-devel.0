Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CE7C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Dec 2022 20:38:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p4pZ2-0002hV-85;
	Mon, 12 Dec 2022 20:38:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1p4pYz-0002hO-TU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Dec 2022 20:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=czwdAeOHh2gAxRwJYpj5G7ysErU/qCBaAyjVZm7e6Xg=; b=gP/ve5Nvyj5OS5CFoBPnNHQuV2
 B9/1GXXfTjPCjzuytxs34ezA3nRaCn5G4+/x6A7cbRHPkJkSk9tf0SBwbengkrkKJnqz4GyiwV+oM
 EohN+kZ6IsspTh+HxByvDhVYCrlNDRBfYXSS/bMpei9tJHXqKGQxtz/0YPwQDJLx/WS0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=czwdAeOHh2gAxRwJYpj5G7ysErU/qCBaAyjVZm7e6Xg=; b=WbL5Unx9CQOAvaTBjGn/adUVpT
 wTGr2K8VzuCOZ7FqDvfRl64CPvlXcoCQve1KU4a1KHKqgm/sOuMc26ybgiH75SBy5V28z+hemBBc5
 wjYn3v+FSWJwFqZiZWrzwfBoqzkAZWf8HQ8hFIzrWquaShiLColbSwzkt+KvEpWbC+d0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p4pYz-00081k-9Y for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Dec 2022 20:38:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0F706B80E0E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Dec 2022 20:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C27B7C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Dec 2022 20:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670877485;
 bh=czwdAeOHh2gAxRwJYpj5G7ysErU/qCBaAyjVZm7e6Xg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=dPb5OBv6yZVhCErjrSHz2bUQ58US0h16S2yNOQa8s0Uz5rZUCWFFzC1PlAByXYVVY
 12LzBSo1XT+iSQabelHOnS3Pumpp3Od5piAFU2sX73TVMEiMF1V3dOYzDBDg22OgrL
 30kJA8k8U8OxzmJJ4++NSYvrhUrWBrec4u1REyRy6H/tPiHFpzGWsDkzTcluTy5VNt
 4eq6RR87b5b6/ZSri7u89wXyhegQR1MsZYUcWluRDrSzbLRTk+G+kh47XF5KfxT+Og
 28C5n5N1VutsgxSklJQOJVBPvLUsrnSMmx1bigFXX/f8ORriRlDc1v3T2DOBkLo2wP
 FxxEEsr7pLaCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id A4C0CC43141; Mon, 12 Dec 2022 20:38:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 12 Dec 2022 20:38:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-jIN14GjkZo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1p4pYz-00081k-9Y
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

--- Comment #110 from Guido (guido.iodice@gmail.com) ---
I deactivate the f2fs-gc script for two days and... again the 100% cpu on
f2fs_gc process :-(

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

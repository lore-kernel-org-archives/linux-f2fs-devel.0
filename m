Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59AFC77B61
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Apr 2023 12:47:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pklVS-0006oR-Cx;
	Fri, 07 Apr 2023 12:47:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pklVR-0006oF-GE
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 12:47:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0SjdOK7AwD15jVHChDisty7gYOo41Lz46I6uSaLnUPE=; b=SpABaNSiTfO/MwU5I9wXv7dZ3J
 zvMXpHKIm4kFP6okieJuHUiAyBgYDU9GZ7FQeTTGt8BqAyS9lmEl2jaj3e+25ojQFgKrMvLtzONQX
 YFnuASEnyK+TmfCp/DC0lpUmRevAlIs+EZ9+Jg0dFUM4jjZHTzkY7c6Q8nohVhqRf9iY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0SjdOK7AwD15jVHChDisty7gYOo41Lz46I6uSaLnUPE=; b=euVo0b7hHENKOhIfYDVf/cfWhh
 wWLX1oK3SNj6EKBjFF63Bqo3iDMROatolgJN1PcwPlDY3//Vn0cKGfyIHydMZScoiJfh6B84L8+lY
 lHe/dUZWLrAxXscTZF1KZ9mKj4DTIbN7/8izJtveddxp01prOAwiCndIDWI9iUKOshLA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pklVQ-000Arg-3z for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 12:47:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B167B60A24
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  7 Apr 2023 12:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FCCAC433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  7 Apr 2023 12:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680871666;
 bh=0SjdOK7AwD15jVHChDisty7gYOo41Lz46I6uSaLnUPE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=oBMLL3MqZO9hbHoTjMcFrRem7Q2WBnbONk4wVpc1OKgao2g0Hcqh8xBEGavhC5sMh
 aLa8ZMdkMcnzhaGmT6EOg0xCKCGw+mjy4nA2qw7tlK5iOIfnKaIcFPt004qu8l99vr
 wF08VRNaSYuIkh2NfzSnYtKOBQMfw1cJbEODaPw4LzCBqYDBkUNBxsBUwomdIOtcUI
 id3qTIXBGdRNTddSf8cKz5acUUgUkr1tgUaHudrw/Gsur0QaU8UabzYkj1l7bYDPe9
 U7dlLbDZPgZKMTOyG+OyIA+Anis2aQnZOw+VUz+MwAiBKJNydlQPIB000dWvCQ1rUA
 BvLy35b8jQKlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id F39A7C43142; Fri,  7 Apr 2023 12:47:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 07 Apr 2023 12:47:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-k5P8wNrTSS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pklVQ-000Arg-3z
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

--- Comment #149 from Guido (guido.iodice@gmail.com) ---
The build process fails but not on f2fs (it fails on a driver for some reason).
Is there a way to build only the patched f2fs module against the stock kernel?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

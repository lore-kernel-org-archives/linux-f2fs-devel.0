Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7492C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jun 2022 03:19:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nwEtE-0002nq-2Q; Wed, 01 Jun 2022 03:19:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nwEtD-0002nk-3l
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jun 2022 03:19:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ttr8+DOd5BUqAIvKHGFtPUWd0qBn3S8fkNIFwroavsA=; b=KYsgUMIeqjidK0r0QEu7Bs+MqZ
 Vyj9QFjI/3Vb1b9SIVIGCSTpmO3E+dtgyOPfA2u6smsZ6NOAsMkX0IyW4EroxeOP89G2BYvIfbJX7
 ei/jq3yno1tSjKrkrXVXxgjpKvehKoNGj6X3EU6V2AXnnEnwtVqt0mYOTY2GxxdHgoYM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ttr8+DOd5BUqAIvKHGFtPUWd0qBn3S8fkNIFwroavsA=; b=me5GEz7gTeqyxM6bAxuOxrzcu0
 GBhcMNlXz1k57ejeibN8T/jHoYT1nwKQmM9NlPKXrjSBLH35w41rNfKBTNSzl958tXJgjupjSXCO9
 ViB6DZy1Xt68gzNLqo6wQtvgGcwp6ReD61gMihz2CgjEnD+ibiPSuEFbkDefjvjJrImE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nwEtD-00Edve-9I
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jun 2022 03:19:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DE11660FFD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  1 Jun 2022 03:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42DC6C385A9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  1 Jun 2022 03:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654053553;
 bh=Ttr8+DOd5BUqAIvKHGFtPUWd0qBn3S8fkNIFwroavsA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=BjFxKzvPf5KrVGcFmgEWLxrcdQw+yZiphcKohV1ktvjJkSbtOlueO6pgn+Jnmb2kQ
 xC4QaY1/IG67FOKKft908aQTmMEgKTump70Dj7WtAnJ9ehYaZOV1BoubqCwmctQKUZ
 i67doOowumMGGE4mEreTw1lJgsnGXusvb8X3Jv5+jvIAiCmh4u7kS88mAKhLLpVdMz
 L19f1Jrl3ZWYCX/TJl0lE3pKY4JIi+UJsRkmqtDvDN/tjLMGa2XJBpGtPzFJk75VvJ
 3CERcqFsenuZxAZAhf5H1k2n0Fd7oR0MQoJ+tuWtR95e6pMd5kGNzzJa8YN1mqrdhQ
 bAhRLOK2zC2ww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 1F981C05FD2; Wed,  1 Jun 2022 03:19:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 01 Jun 2022 03:19:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: plague@privacyrequired.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-P3D2edoGAi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nwEtD-00Edve-9I
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

--- Comment #8 from plague@privacyrequired.com ---
Yes, it is running... I will collect some tracing for analysis...

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

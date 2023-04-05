Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFB9C76188
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 20:46:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkA12-0005DS-9v;
	Wed, 05 Apr 2023 20:45:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pkA10-0005DM-ST
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 20:45:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kvs7G53kHQ4yhVug7bqdcUTxyrN7f69T8xfFTZ5tcBE=; b=AfwWC0Tuu8JxXNoT3qLqzrhGi0
 ilQX0/Sj8LfGMKruuUF40RMj4yPb8VAnbTe4SNdlPa1bSObYIkpuRS41X3IEUVkXeGU+MrHQFlHKN
 nTMHrIZ11BPD6dFpAvmyoIULS28eqouW+I4UJUB9SMAPtqaRd7R1RTeEGsHrlfbQt6Ks=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Kvs7G53kHQ4yhVug7bqdcUTxyrN7f69T8xfFTZ5tcBE=; b=kuj3ND0ppbzR5V/HBA4yOx4qmb
 9hHHqlqSQOMRxOxHXKkZhP0HcUIkK8lrmeRD7WLtUpgOhpcMSvsJ92GXwdE3YSoyu1H3CKN500lcX
 5LyhP3DtqQIkoCvBoRdqn+qDnc3BRAraDIPVKU8qAZRkrmRo6fU1Q7Qmsbu19VfACUWw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkA0z-0001aE-F0 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 20:45:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1386364193
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Apr 2023 20:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7840EC433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Apr 2023 20:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680727551;
 bh=Kvs7G53kHQ4yhVug7bqdcUTxyrN7f69T8xfFTZ5tcBE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Tz3Jbr5mgRdCdx6mVl9qMn/MqZMLWCenmqCBdyIRYuW3vBpm7GqfNKm95YwzfeYF/
 EyfeuIp5G0TmFvdZDeCeGwUdQu/VVAb5nObHkNuycOUMi+anMLUVZhBNHuAxnHh1y0
 qHsZm+VwSoHU4E9zAxw+CGMjGRebF3VyECIsEBTnqP1can6Fv4OclseUoUyryk0Lux
 reeWaZQFyBeUhVea30GnsspQMbxkZHHokxnjSeYgav9zgzqT1phcjY2R7NG+kYmZwA
 fgTbdeCXZRMTap8++pnERWewBJAtKkeb+Fb81eZMbVXj8oMTRh8dhWdjBESET2HVzr
 VS/zxlkSh+Hgg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 53BEFC43141; Wed,  5 Apr 2023 20:45:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 05 Apr 2023 20:45:51 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-r9aC6H9uvS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pkA0z-0001aE-F0
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

--- Comment #142 from Jaegeuk Kim (jaegeuk@kernel.org) ---
I've reviewed the refcount of the path and found one suspicious routine when
handling page->private.

By any chance, can we try this patch instead of the above workaround?

https://lore.kernel.org/lkml/20230405204321.2056498-1-jaegeuk@kernel.org/T/#u

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

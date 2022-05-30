Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACFCC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 May 2022 11:53:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nvdxF-0000Ou-CG; Mon, 30 May 2022 11:53:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nvdxE-0000OP-0E
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 May 2022 11:53:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PvkwNazNRjkWZrXsuOm1WM5xTnev/Z0Gljvsx4RV3L4=; b=ESU2DiUNw0db+3o5GTEuKgEhhX
 r6DEIhG5bwgTOpsYWJGHq2DT10qOnBG9eGDfQwUCkbK7COMbGI4g18B12XgtCpNnMvl9tud14oevf
 T2J6ZxKkqn6uKzFiDng6rVyk6MsCdFijtk9BuLhZiiJ7iL/+QKj907O/WytOXOoMgy3Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PvkwNazNRjkWZrXsuOm1WM5xTnev/Z0Gljvsx4RV3L4=; b=dwfzACJzz2PgmBy9IV78XG6W7M
 kwTJczOq4FFBwQSeL9TQRPGs/f0aOcnmyB22wrJW2OIZTqbCehR5A/AdGP3mZk2tvCys8TGlHjAHo
 4Xzx2R6IpzcekZGHuoMmRLlUp6eiHo8q8Znj542w+YOOBrDmkuR8/tMCueoMIlJc0nPo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nvdxD-002ODz-KB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 May 2022 11:53:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2D646611A8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 30 May 2022 11:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90C8BC3411A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 30 May 2022 11:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653911568;
 bh=PvkwNazNRjkWZrXsuOm1WM5xTnev/Z0Gljvsx4RV3L4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=DfCW0koC/LPUIW2IBdQRkIhXgN0CfTTeXwuuz5E7grgZ9wua96aDqZC8fa5wjnZDO
 1Zum6uq7V3tYtFfr96ARQX2DAeaBvdbfenn2fZLQizs+zNwVDCJ6f/B9pqLa0ZxeRw
 l2ewEIyW+PpnUsQiSYpT+eRazgdMIN17aBg8+A7XXBhIR4drD2tEPRQXyZ6lYUzita
 gA6+y+xnUbitMcyr7FZl8VTguiikQsOa3UqoLpjxF/OrECCK0ZNLrimcTy45FwaO49
 TPiQXdpwmKGKqiSNzgcz9g5jySCd4Eze0JprEncp1EEG3AikqL0DKWVcqHiu3gQNpG
 j6TwKP4NGPeMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 73DEDC05FD4; Mon, 30 May 2022 11:52:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 30 May 2022 11:52:48 +0000
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
Message-ID: <bug-216050-202145-eooe9ZDr17@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nvdxD-002ODz-KB
Subject: [f2fs-dev] [Bug 216050] fsfs_gc occupies 100% cpu
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

--- Comment #1 from Guido (guido.iodice@gmail.com) ---
I was too optimistic. The problem reoccurred.

217 root 20 0 0.0m 99.3 0.0 12:28.48 R f2fs_gc-259:3

the only related error I see the logs is:

30/05/22 13:13 kernel nvme nvme0: missing or invalid SUBNQN field.

I forced fsck on all partitions, but with no result.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

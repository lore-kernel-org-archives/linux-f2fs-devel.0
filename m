Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53BDCAC597
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Sep 2025 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dlJ4K8eGT64WbBHPqnNCx2Y2QUs/9CFi29H0vkN7G7c=; b=S6nxyqpH1ugPv4nK2QM6a+SOcL
	OEmz3TjpXapZgo2ARL0dCwzYNP4DOd3azXXKSeZPI755yDFLw///643Az7CdpgnUa5TxziZ35JxUN
	cSOzpqZrEs16IR+JN8Das6fAriFcrQ+uJdEX9PkuERD3aWv0WF1jVWPA6PstzrVitRV0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uy8Ix-0002XS-N4;
	Mon, 15 Sep 2025 12:27:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1uy8Iw-0002XM-PM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 12:27:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vJyMGC1PDPKujtEaLzZObvIYE4I3AMXkM8Q79hLVGGQ=; b=NSmUj8zBm/We+jj5xdvgfA87Bk
 ZRSQM6on4N3LrsdR2utdbLCEY8FwF5jlnucs0wZHBV1DwqcJM91UOWNIm1MINkq6Xkj3ADtI8Tg/u
 iguRLlzNU1x4WwOvFPW1Tig5oIasJTcuzclE0ELU6IIofgNevcPg7VPUnPnIYO7qCpek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vJyMGC1PDPKujtEaLzZObvIYE4I3AMXkM8Q79hLVGGQ=; b=lnaNs/nqdNCtVRcChNUqLsMf8X
 vMWWV+3t3vQJjuTIh0fMzOdeXlewzFb+4VV9QlMVfDrWHb9AInyVWl03SrW4OtAi+W6pIVZxo1IM1
 bFBD6b5I7xdnjFMy69cP0bw3tbO61ThBPLvwMKv6zkbJtnXB1VWYUy7wZ7oO7yz0IOeY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uy8Iw-0006W4-5i for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 12:27:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CD87244931
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Sep 2025 12:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF8D2C4CEFD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Sep 2025 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757939248;
 bh=EIafdC2D195NuVysFAkcU2KrvBFRXUmV0IYUidKpQC4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=u4G3nRyXN8sej+YTkOTj+1kYhGotmkWLKhfhh5QcZP6Vxtx7qbBIBPnLyHTeev3bE
 pgJazaXqaD4tIg76+sWYQJfJXwsSl9TpoxZXmWCsZlYBnA9UaoKc6uQM8ojJw18xHA
 jMACBboqGyYBUL5WNeZShYkX1AzqDlvzwXbm80qUUUh+fdnh6a8Y29ZgEyHZzRmxxe
 GpWWxhoUdQt/pD5EqGcQo8W9X5/GBuQEVqg1orYILkDjnegPkVZ7EXD5mLgimTj9A1
 G6xcZs760Bx6XGf46AaJJmLhn+oDNURaVbR33X4xMTNdRJexuWJGt3htQonoNuQjMd
 z4gqm2Xv5ydPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 93CAAC41613; Mon, 15 Sep 2025 12:27:28 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 15 Sep 2025 12:27:28 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220575-202145-KhjWjghrrF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220575-202145@https.bugzilla.kernel.org/>
References: <bug-220575-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1uy8Iw-0006W4-5i
Subject: [f2fs-dev] [Bug 220575] Unable to handle kernel NULL pointer
 dereference at virtual address 0000000000000000
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
From: bugzilla-daemon--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: bugzilla-daemon@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=220575

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chao@kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
Hi,

Do you have a ramdump about this issue, if there is, can you please provide
more information about the corrupted page?

Thanks,

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D8CC4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Apr 2024 11:41:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rzb00-0006Fr-Hr;
	Wed, 24 Apr 2024 11:41:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1rzazy-0006FT-SE
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Apr 2024 11:41:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iq92VtBOg7NFmJMicReZarLN5kKfnjGSDgWVzMJJUzc=; b=HzpPmS/Aof2sso2IhsP8dxA3Wq
 4UpWkT4ettOoFISUjtpJRUgowqb/IHHG5HsvhmpVOfiP3nNSj59/f2vi+w7VLhWnrRBSu5u9H5R07
 w2lT+rSUJKeXtahCp9/by9ld4/pl0D8TduszhMXgtshpSBJgVcahXOuVExwdBaB4qtis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iq92VtBOg7NFmJMicReZarLN5kKfnjGSDgWVzMJJUzc=; b=avUdxVzCbWtlZ1zphqUeoR+I/1
 armz/o1hzbfrI1u9QBLcfYu32tz05haj6L6KWYH2EkguIJtB6V5jHaX0w6SSLOiPuHu1aNN9i7oWb
 KqZwgXHLj8IZaGGJrVAMVhdVIQIgj7SMfsy04OBwApx6+5+wVH4mYv60C+8UT5E/3VBM=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rzazx-0004fm-Rj for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Apr 2024 11:41:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A800ACE1398
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 11:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE0C4C113CE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713958866;
 bh=wyDk5qOm4uQAhl7r56srrRDwh2E0xOMgbIJ+8HnBuIQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=HIyc/dZqSxs/PY6au4EZUNiSKFgRyPSDW4sk8QLzOEEcgW+RxgQdzr0dKqgrPUS7M
 M0hNkpoI3XDPJ5shQ+WEFq+FUJh89Gb8//x7uG7dXfkKJHbSzzRBfjarAM9B/hGQ8g
 3yw1ZY4T+VEXel08S0AZKpMCdyeGCih6ruc+DkKCRnnSGKa6ITf0oD2pSnlWF8a/CI
 rNYEBBsMZSPVd+ejjyFyemtCpV1UvYlDRxbEOe93E84LtCMatdlcnkJvWvYkFd6ec2
 8GM3jxjrQUVW0USiSYyUn6l+rYb7hV81BdoaPOSuURbntbqr8A52vWcVfqLIcwASgS
 KseWvKMgRFl3w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id C667EC433E3; Wed, 24 Apr 2024 11:41:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 24 Apr 2024 11:41:06 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218770-202145-UkBqAms4kw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1rzazx-0004fm-Rj
Subject: [f2fs-dev] [Bug 218770] fsck seems unable to solve corruption
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

https://bugzilla.kernel.org/show_bug.cgi?id=218770

--- Comment #1 from Guido (guido.iodice@gmail.com) ---
Created attachment 306205
  --> https://bugzilla.kernel.org/attachment.cgi?id=306205&action=edit
fsck

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

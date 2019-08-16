Return-Path: <SRS0=leBL=WM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB94C3A59C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:56:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1008020644;
	Fri, 16 Aug 2019 05:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="LuAHIAAY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fnnt6hez";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZkH7Pvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1008020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hyVEP-0000ci-OS; Fri, 16 Aug 2019 05:56:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hyVEO-0000cR-Ph
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Aug 2019 05:56:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y1gjkw6tPJFwk3U5ZzCQHJwUgMfaG/bb3IZCEdyAEhY=; b=LuAHIAAYiVulxa+Z2LQh4O8LC9
 6NzYbPk9+yXYAy+s0vs1Q3ae7Wmw6seZHsT+tMsuGTVU1AUogHzeXTOe9fRtFwMjn2HDgKCJnTw7c
 FLxCkes8YpQVmh/Pty0tZAjD4KWRwb1Nbn6QxEk41MNXbB3oytURIRwAx1AYJk8STkVk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Y1gjkw6tPJFwk3U5ZzCQHJwUgMfaG/bb3IZCEdyAEhY=; b=f
 nnt6hez3d91OPwwARaF+K4fVmng/tmhliGVRbMBLcRGY7QXDPQ/3DvQ0xITq0QRa06Aah2bkhCwNx
 wxeSVAmJvs8jABHOx94kPey0RMLyqUxc7kpT8mPd2QoZ8y31MrvWch5uzryRrQFO8icrgzNzGOEQw
 Ufd6YgE/h1E9gplk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hyVEE-005XTH-Ox
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Aug 2019 05:56:56 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0373520644
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 Aug 2019 05:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565935001;
 bh=h/c1tbLABiIIFnhxnUUwUSPbxMDGcE66LQMBIfWv2CE=;
 h=From:To:Subject:Date:From;
 b=DZkH7PvklU7TPZv1s8Ke1GR6n5RFwP9+WJtOvBao76z6sJHCwPVDDjepLLeBsaoG1
 g28WuLJH+rAj9wnu2nLOS04QCrF7qWfmtQhnMqMFvTXo4oFj1B63OiC9ckgmH7VQvs
 5ihxTbqDmljpqUJG3E0FS0deP44bqogP7uqswOn4=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 15 Aug 2019 22:55:36 -0700
Message-Id: <20190816055539.30420-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Headers-End: 1hyVEE-005XTH-Ox
Subject: [f2fs-dev] [PATCH 0/3] f2fs: fixes for FS_IOC_{GET,SET}FSLABEL
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

Fix some bugs in the f2fs implementation of the FS_IOC_GETFSLABEL and
FS_IOC_SETFSLABEL ioctls.

Eric Biggers (3):
  f2fs: fix buffer overruns in FS_IOC_{GET,SET}FSLABEL
  f2fs: fix copying too many bytes in FS_IOC_SETFSLABEL
  f2fs: add missing authorization check in FS_IOC_SETFSLABEL

 fs/f2fs/file.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

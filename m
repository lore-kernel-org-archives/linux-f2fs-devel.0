Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F09C76196
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Mar 2023 00:34:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1phJlV-0001xN-0O;
	Wed, 29 Mar 2023 00:34:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1phJlT-0001xH-M8
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Mar 2023 00:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AOlgz4YpMMEj1RbNQ+ewff/wZ8Udt3gLs6vZThcCh/c=; b=CC3gJn5qPpvJKgQfcd/Kndm07Y
 YDZI4sUAzIlawkYilTd5OQeGd1FoWLn6t/jux1cwJNdiDkFbWTsFbYYzEkFW53jzkYJP76M7d9Vlu
 5ZQGLh4AABdig1lUtOv/ucGV6m03Hjo31njkRT9hG4fx7TyYkO1ucKGtEfW9sufOKag4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AOlgz4YpMMEj1RbNQ+ewff/wZ8Udt3gLs6vZThcCh/c=; b=g
 f/4UCfF3wNdS3RunptATW+17P6EfvXD2FADN9FQzWK1U8q61xtv9uxja92E6VUYufDxo1Ym/Cj4aF
 /8oAbxBhL8suqOLhbH3H6fd4oBmPHIBdLfx2xj4Qo/1idFuR8uo7GAajYDEDMgh9FaBYaamSJ9RPq
 agjZH9W111c5heV0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1phJlS-0006Eq-6y for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Mar 2023 00:34:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 98DD4619FE;
 Wed, 29 Mar 2023 00:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A36C433D2;
 Wed, 29 Mar 2023 00:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680050041;
 bh=g089sGSaaERFzueEez0e66+EbLsOH6ztVTsG7Po75Lo=;
 h=Date:From:To:Cc:Subject:From;
 b=X4am4hbMxv4DpSN4wvHdA/XhxYZMlUCQk2lY5uTPQM1GbuEjyHROe2IBAKA/zdQ2m
 QMufrrwYOQQlhZYcsKUqwnWwlLGsRCBH5742xrz+xw4cGvuS8btPgADoFYIHASlmce
 trzt65KHHA7d8s0+1BGP4RpbdhQTMAvDgsspbQ8PmaQhQSHexMFHhoFGj8DLy4T+4T
 JQ97PcWcCC3AsHggtV5A2UQchoq2qzOy7bqlXHzA21cg/CXkb2UN9HkA3Ug9bkJrcr
 hzvDU6ov0DpKWZoufvoFX/r7EaNy8R0we4cBwIb249M01FdSquRy8HLtLh5bH4/3BY
 EFvXN8w8zwCsw==
Date: Tue, 28 Mar 2023 17:33:59 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <ZCOHd4jYn8zUCEZ0@google.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1phJlS-0006Eq-6y
Subject: [f2fs-dev] [GIT PULL] f2fs fix for 6.3-rc5
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.3-rc5

for you to fetch changes up to 0b04d4c0542e8573a837b1d81b94209e48723b25:

  f2fs: Fix f2fs_truncate_partial_nodes ftrace event (2023-03-10 08:57:49 -0800)

----------------------------------------------------------------
f2fs fix for 6.3-rc5

This fixes a tracepoint field size in f2fs, and another patch [1] to reveal this
bug comes in rc5 as well.

[1] https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230309221302.642e82d9@gandalf.local.home/

----------------------------------------------------------------
Douglas Raillard (1):
      f2fs: Fix f2fs_truncate_partial_nodes ftrace event

 include/trace/events/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
